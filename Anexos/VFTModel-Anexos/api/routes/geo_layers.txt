"""
@author: Hernán Galileo Cabrera Garibaldi
@description:
        Output adapters GeoJSON para los tres indicadores topológicos VFT.
        Este módulo es exclusivamente una capa de serialización — no contiene
        lógica analítica. Transforma los DataFrames de los algoritmos en
        FeatureCollections consumibles por Transport-gis-zmvm-mjg y QGIS.
@route: src/api/routes/geo_layers.py
@date: 03-06-2026
@notes:
    Contrato de datos definido en VFT_CLIENT_SPEC.md (raíz del repo).
    Todas las geometrías se entregan en EPSG:4326 (WGS84).
    Los algoritmos trabajan internamente en EPSG:32614; se reprojecta antes de serializar.
"""
import ast
import json
import asyncio
from datetime import datetime, timezone
from typing import List, Optional

import geopandas as gpd
import pandas as pd
from fastapi import APIRouter, HTTPException, Query
from shapely.geometry import Point, mapping

from src.api.dependencies import (
    DEFAULT_TOLERANCE, get_or_build_graph,
    get_giant_component, get_betweenness_report, B_CACHE
)
from src.core.algorithms.topological.betweenness_centrality import BetweennessOrchestrator
from src.infrastructure.go_client.client import fetch_full_network
from src.infrastructure.go_client.client_spatial import fetch_territorial_polygons
from src.core.algorithms.spatial.spatial_coverage import SpatialCoverageAnalyzer
from src.core.algorithms.topological.capillar_strength import CapillaryStrengthAnalyzer
from src.core.algorithms.topological.detaurFactor import DetourFactorOrchestrator

from src.core.utils.logger import vft_logger

## Router
router = APIRouter(
    prefix="/api/v1/network/geolayers",
    tags=["GeoLayers"]
)
# ----------------------------------------------------------------------
## Auxiliares de serialización
# ----------------------------------------------------------------------

def _build_feature_collection(
    indicador: str, 
    layer: str, 
    feature: list,
    parametros: dict) -> dict:
    """Envuelve una lista de Features en la envoltura estándar VFT."""
    return {
        "type": "FeatureCollection",
        "metadata": {
            "indicador":    indicador,
            "layer":        layer,
            "n_features":   len(feature),
            "crs":          "EPSG:4326",
            "fetched_at":   datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
            "parametros": parametros
        },
        "features": feature
    }
    
# ----------------------------------------------------------------------
## Clasificación de Categorias (Umbrales supuestos)
# ----------------------------------------------------------------------

def _clasify_coverage(pct: float) -> str:
    if pct > 60:
        return "alta"
    if pct >= 30:
        return "media"
    return "baja"

def _clasify_node(fc_total: float) -> str:
    if fc_total > 20:
        return "hub_principal"
    if fc_total > 10:
        return "hub_secundario"
    if fc_total > 6:
        return "nodo_relevante"
    return "nodo_basico"

def _clasify_diff(factor: float) -> str:
    if factor <= 1.3:
        return "eficiente"
    if factor <= 1.6:
        return "moderado"
    if factor <= 2.0:
        return "alto"
    return "critico"

# ----------------------------------------------------------------------
## Sección D — Endpoint /coverage
# ----------------------------------------------------------------------

@router.get("/coverage", summary="Cobertura Espacial como FeatureCollection GeoJSON")
async def get_geolayer_coverage(
    layer:       str                 = Query("cobertura_por_alcaldia",
                                             description="cobertura_por_alcaldia | estaciones | cobertura_800m"),
    radio_m:     float               = Query(800.0,  description="Radio de buffer peatonal en metros"),
    entidades:   Optional[List[str]] = Query(None,   description="Entidades federativas (default: Ciudad de México, Estado de México)"),
    mode:        str                 = Query("REALISTIC_INTEGRATION"),
    tolerance_m: float               = Query(DEFAULT_TOLERANCE)
):
    if entidades is None:
        entidades = ["Ciudad de México", "Estado de México"]
    try:
        # ── cobertura_por_alcaldia ─────────────────────────────────────────
        if layer == "cobertura_por_alcaldia":
            net, pol = await asyncio.gather(
                fetch_full_network(),
                fetch_territorial_polygons(entidades=entidades)
            )
            analyzer = SpatialCoverageAnalyzer(net, pol)
            df       = await asyncio.to_thread(analyzer.calculate_general_coverage, radio_m)
            gdf_pol  = analyzer.gdf_poligonos.to_crs("EPSG:4326")

            features = []
            for _, row in df.iterrows():
                nombre  = row["Demarcacion"]
                pol_row = gdf_pol[gdf_pol["nombre"] == nombre]
                if pol_row.empty:
                    continue
                geom    = pol_row.iloc[0].geometry
                cob_pct = row["Cobertura_Porcentaje"]
                features.append({
                    "type": "Feature",
                    "geometry": mapping(geom),
                    "properties": {
                        "id":                  nombre,
                        "nombre":              nombre,
                        "indicador":           "cobertura",
                        "layer":               layer,
                        "area_total_km2":      row["Area_Total_km2"],
                        "area_cubierta_km2":   row["Area_Cubierta_km2"],
                        "cobertura_pct":       cob_pct,
                        "cobertura_deficit":   round(100 - cob_pct, 2),
                        "categoria_cobertura": _clasify_coverage(cob_pct)
                    }
                })

        # ── estaciones ────────────────────────────────────────────────────
        elif layer == "estaciones":
            net          = await fetch_full_network()
            features_est = [f for f in net["features"]
                            if f.get("properties", {}).get("tipo_entidad") == "estacion"]
            gdf_est      = gpd.GeoDataFrame.from_features(features_est, crs="EPSG:4326")
            gdf_est      = gdf_est.drop_duplicates(subset=["nombre", "sistema"])

            features = []
            for _, row in gdf_est.iterrows():
                features.append({
                    "type": "Feature",
                    "geometry": mapping(row.geometry),
                    "properties": {
                        "id":            str(row.get("id", "")),
                        "nombre":        row.get("nombre", "Sin nombre"),
                        "indicador":     "cobertura",
                        "layer":         layer,
                        "sistema":       str(row.get("sistema", "")),
                        "tipo_entidad":  row.get("tipo_entidad", "estacion"),
                        "sistemas_count": 1
                    }
                })

        # ── cobertura_800m ────────────────────────────────────────────────
        elif layer == "cobertura_800m":
            net          = await fetch_full_network()
            features_est = [f for f in net["features"]
                            if f.get("properties", {}).get("tipo_entidad") == "estacion"]
            gdf_est      = gpd.GeoDataFrame.from_features(features_est, crs="EPSG:4326")
            gdf_est_m    = gdf_est.to_crs("EPSG:32614")
            mancha       = gdf_est_m.geometry.buffer(radio_m).unary_union
            gdf_mancha   = gpd.GeoDataFrame(geometry=[mancha], crs="EPSG:32614").to_crs("EPSG:4326")
            geom_mancha  = gdf_mancha.iloc[0].geometry

            features = [{
                "type": "Feature",
                "geometry": mapping(geom_mancha),
                "properties": {
                    "id":        "cobertura_800m",
                    "nombre":    f"Cobertura {int(radio_m)}m",
                    "indicador": "cobertura",
                    "layer":     layer,
                    "radio_m":   int(radio_m)
                }
            }]

        else:
            raise HTTPException(
                status_code=400,
                detail=f"Layer '{layer}' no reconocida. Opciones: cobertura_por_alcaldia, estaciones, cobertura_800m"
            )

        return _build_feature_collection(
            indicador  = "cobertura",
            layer      = layer,
            feature    = features,
            parametros = {"radio_m": radio_m, "entidades": entidades}
        )

    except HTTPException:
        raise
    except Exception as e:
        vft_logger.error(f"Error en GeoLayer coverage [{layer}]: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Error en GeoLayer coverage: {str(e)}")
