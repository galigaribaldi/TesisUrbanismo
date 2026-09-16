"""
GeoExporter — convierte respuestas de VFTClient a GeoDataFrame y las guarda como GeoJSON.

Dos caminos de trabajo:

  Camino A — REST (geolayer endpoints):
      fc = client.fetch_detour_routes()
      gdf = GeoExporter.from_geolayer(fc)          # geometría Point por ruta
      GeoExporter.save(gdf, "df_puntos")

  Camino B — SDK (map_data.network_route):
      routes = orchestrator.calculate_sample_routes(...)  # desde VFTModel notebook
      gdf = GeoExporter.routes_to_linestrings(routes)     # geometría LineString por ruta
      GeoExporter.save(gdf, "df_rutas_lineas")
"""

from __future__ import annotations
import json
from pathlib import Path

import geopandas as gpd
from shapely.geometry import LineString

# Destinos por defecto (relativos a la raíz del repo)
_REPO_ROOT = Path(__file__).parents[2]
TABLEAU_GEO_DIR = _REPO_ROOT / "tableau" / "exports" / "geo"


def _derive_categoria(df_val: float) -> str:
    """
    Replica la categorización de VFTModel.
    Verificar contra DetourFactorOrchestrator si cambian los umbrales.
    """
    if df_val < 1.3:
        return "eficiente"
    if df_val < 1.6:
        return "moderado"
    if df_val < 2.5:
        return "alto"
    return "crítico"


class GeoExporter:

    # ── Camino A: desde GeoJSON de geolayer ───────────────────────────────────

    @staticmethod
    def from_geolayer(feature_collection: dict) -> gpd.GeoDataFrame:
        """
        Convierte un FeatureCollection (respuesta de VFTClient) en GeoDataFrame.
        Preserva todas las propiedades tal como vienen del API.
        """
        features = feature_collection.get("features", [])
        if not features:
            raise ValueError("FeatureCollection vacío — verificar que el API responde.")
        return gpd.GeoDataFrame.from_features(features, crs="EPSG:4326")

    # ── Camino B: desde route dicts del SDK VFTModel ──────────────────────────

    @staticmethod
    def routes_to_linestrings(routes: list[dict]) -> gpd.GeoDataFrame:
        """
        Convierte una lista de route dicts (map_data.network_route) a LineStrings.

        Cada route dict debe tener:
            route["map_data"]["network_route"]  → list of {"lon": float, "lat": float, ...}
            route["metrics"]["Factor_Desviacion"]
            route["metrics"]["Origen"]
            route["metrics"]["Destino"]
            route["metrics"]["Distancia_Red_km"]
            route["metrics"]["Sistemas_Involucrados"]  (opcional)

        Uso desde VFTModel notebook:
            routes = orchestrator.calculate_sample_routes(sample_size=200, seed=42, return_json=True)
            gdf = GeoExporter.routes_to_linestrings(routes)
            GeoExporter.save(gdf, "df_rutas_lineas")
        """
        rows = []
        skipped = 0

        for route in routes:
            try:
                nodes = route["map_data"]["network_route"]
                if len(nodes) < 2:
                    skipped += 1
                    continue

                coords = [(float(n["lon"]), float(n["lat"])) for n in nodes]
                m = route["metrics"]
                df_val = float(m.get("Factor_Desviacion", 0))
                sistemas = m.get("Sistemas_Involucrados", [])

                rows.append({
                    "origen":            m.get("Origen", ""),
                    "destino":           m.get("Destino", ""),
                    "factor_desviacion": df_val,
                    "dist_red_km":       float(m.get("Distancia_Red_km", 0)),
                    "sistemas":          json.dumps(sistemas) if isinstance(sistemas, list) else str(sistemas),
                    "categoria_df":      m.get("Categoria_DF") or _derive_categoria(df_val),
                    "geometry":          LineString(coords),
                })
            except (KeyError, TypeError, ValueError):
                skipped += 1
                continue

        if skipped:
            print(f"  ⚠️  {skipped} rutas omitidas por datos incompletos.")

        return gpd.GeoDataFrame(rows, crs="EPSG:4326")

    # ── Guardar ───────────────────────────────────────────────────────────────

    @staticmethod
    def save(
        gdf: gpd.GeoDataFrame,
        filename: str,
        output_dir: Path = TABLEAU_GEO_DIR,
    ) -> Path:
        """
        Guarda el GeoDataFrame como GeoJSON en output_dir/{filename}.geojson.
        Crea el directorio si no existe.
        """
        output_dir.mkdir(parents=True, exist_ok=True)
        out = output_dir / f"{filename}.geojson"
        gdf.to_file(out, driver="GeoJSON")
        print(f"✅  {len(gdf)} features → {out}")
        return out
