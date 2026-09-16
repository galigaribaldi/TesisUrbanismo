"""
@author: Hernán Galileo Cabrera Garibaldi
@description: Endpoint principal para probar la ingesta y validación de datos espaciales.
@route: src/api/main.py
@date: 2026-04-09
@notes:
            Se actualizó para consumir la nueva clase VFTGraphBuilder, permitiendo 
            diferentes modos de construcción topológica (STRICT_TOPOLOGY vs REALISTIC_INTEGRATION)
            y controlando la tolerancia de transbordo peatonal (Q1 por defecto).
        
            Se implementó un Caché en Memoria (Singleton) y delegación a hilos (to_thread)
            para evitar bloqueos (TimeOuts) del Event Loop de FastAPI.        
"""
import os
import uvicorn
import asyncio
import pandas as pd
from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException, Query, Body
from fastapi.middleware.cors import CORSMiddleware

load_dotenv(os.getenv("ENV_FILE", ".env.local"))
from typing import List, Optional, Union, Tuple


from src.api.schemas.schemas import GeoJSONTransportSchema
from src.infrastructure.go_client.client import fetch_full_network

from src.core.services.graph_builder import VFTGraphBuilder
from src.api.dependencies import (
    DEFAULT_TOLERANCE, get_or_build_graph, get_scc_report,
    get_giant_component, get_travel_time_report, get_betweenness_report,
    T_CACHE, B_CACHE
)
from src.api.routes import router as geo_router

from src.infrastructure.go_client.client_spatial import fetch_territorial_polygons
from src.core.algorithms.spatial.spatial_coverage import SpatialCoverageAnalyzer
from src.core.algorithms.topological.capillar_strength import CapillaryStrengthAnalyzer
from src.core.algorithms.topological.detaurFactor import DetourFactorOrchestrator
from src.core.algorithms.topological.average_travel_time import AverageTravelTimeOrchestrator
from src.core.algorithms.topological.betweenness_centrality import BetweennessOrchestrator
from src.core.utils.logger import vft_logger

app = FastAPI(
    title="VFT Model API",
    description="Motor analítico para topología de red de la Ciudad de México y su área Metropolitana.",
    version="1.0.0"
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)
app.include_router(geo_router)

@app.get("/api/v1/network/build-auto", summary="Descarga y valida la red completa (Cache Warming)")
async def build_network_auto(
    mode: str = Query("REALISTIC_INTEGRATION", description="Modos: STRICT_TOPOLOGY o REALISTIC_INTEGRATION"),
    tolerance_m: float = Query(DEFAULT_TOLERANCE, description="Distancia máxima en metros para transbordos peatonales.")
):
    """
    1. Ejecuta el cliente HTTP para ir a la API de Go.
    2. Descarga Líneas y Estaciones simultáneamente.
    3. Pasa el JSON unificado por el escudo de validación Pydantic.
    Llama a este endpoint al iniciar el servidor 
    para que el grafo quede listo en la memoria RAM para los demás endpoints.
    """
    try:
        G = await get_or_build_graph(mode, tolerance_m)
        return {
            "status": "success",
            "mensaje": "Grafo listo y en caché.",
            "nodos": G.number_of_nodes(),
            "aristas": G.number_of_edges()
        }
        
    except ValueError as val_error: # Captura errores de Pydantic
        raise HTTPException(
            status_code=422,
            detail=f"Fallo en el contrato de datos Pydantic: {str(val_error)}"
            )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Fallo crítico en la comunicación con el servidor Go: {str(e)}"
            )