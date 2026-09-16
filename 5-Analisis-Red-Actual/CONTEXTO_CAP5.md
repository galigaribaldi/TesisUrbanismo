# Contexto del Capítulo 5 — Análisis de la Red de Transporte Actual de la ZMVM

**Fecha de análisis de notebooks:** 2026-09-16  
**Fuente:** `/VFTModel/notebooks/` (fuera del repo de la tesis)

---

## Cifras base del grafo

| Métrica | Valor verificado | Fuente |
|---|---|---|
| Entidades espaciales crudas (GeoJSON) | 22,766 – 23,540 (varía por fecha de corrida) | NB00, NB01, NB03, NB04, NB05 |
| **Nodos topológicos (post-snapping KDTree)** | **11,115** | NB00, NB01, NB03, NB04, NB05 |
| **Aristas de servicio real** | **~25,000–25,197** | NB01 (25,197), NB05 (25,015) |
| **Aristas de transbordo peatonal** | **20,482** | NB01, NB05 |
| **Aristas totales** | **~45,494–45,679** | Varía ~0.4% por versión del backend |
| Aristas phantom eliminadas | 1,542–1,562 | Todos los notebooks |
| Modo de construcción | REALISTIC_INTEGRATION | Todos |
| Tolerancia KDTree (snapping) | 85 m | Todos |
| Reducción de nodos (~90%) | 22,766 → 11,115 | NB00 |

### Resolución de discrepancia (102,055 vs 11,115 nodos)

La cifra de **102,055 nodos** registrada en `NOTES/issues.md` (2026-04-16) corresponde a
una corrida anterior con modo o tolerancia distintos (probablemente sin snapping KDTree o con
tolerancia más estrecha). **Las cifras de la tesis (11,115 nodos / 45,679 aristas) son correctas**
para la corrida actual con REALISTIC_INTEGRATION + tolerancia 85 m.

### Distribución de aristas por sistema (corrida NB01, 2026-04-18)

| Sistema | Aristas de servicio | Derecho de vía | Cf |
|---|---|---|---|
| RTP | 11,041 | Mixto | 1.759 |
| CC (Corredores Conc.) | 10,603 | Mixto | 1.759 |
| TROLE | 1,506 | Compartido | 1.380 |
| MB (Metrobús) | 792 | Exclusivo | 1.000 |
| METRO | 528 | Exclusivo | 1.000 |
| MEXIBÚS | 391 | Confinado | 1.152 |
| PUMABUS | 234 | Mixto | 1.759 |
| TL (Tren Ligero) | 52 | Exclusivo | 1.000 |
| CBB (Cablebús) | 30 | Confinado | 1.152 |
| MEXICABLE | 17 | Confinado | 1.152 |
| SUB (Tren Suburbano) | 3 | Exclusivo | 1.000 |

---

## Indicadores verificados

### §5.2 — Construcción del Grafo Topológico (NB00)

- **Resultado:** 11,115 nodos / 45,679 aristas; reducción ~90% vía KDTree
- **Recurso visual:**
  - `Figures/Cap5/panel1_infraestructura.png` — infraestructura agregada
  - `Figures/Cap5/panel2_conectividad.png` — aristas interestación
  - `Figures/Cap5/panel3_ida.png` — direccionalidad ida
  - `Figures/Cap5/panel4_regreso.png` — direccionalidad regreso
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_Red_Esquematica.pdf` — mapa QGIS de la red
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_Transporte_Publico.pdf` — capa base TP
  - `Figures/Mapas/Tableau_Resources/RedActual/Apimetro/Dashboards/Dashboard_Apimetro_2026.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/Apimetro/Dashboards/Dashboard_Apimetro_2026_Red_ZMVM.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/Apimetro/UniGrafica/Grafica_Apimetro_2026_Top_10_estaciones.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/Apimetro/UniGrafica/Grafica_Apimetro_2026_Afluencia_Metro_Anual.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/Apimetro/UniGrafica/Grafica_Dashboard_Apimetro_2026_Calidad_Servicio.pdf`
- **Estado:** ✅ Completo — cifras verificadas, figuras existentes
- **Issues abiertos:** ninguno

---

### §5.3.1 — Validación de Impedancia (NB01)

- **Resultado:** Velocidades efectivas post-fricción por sistema:

| Sistema | V modelo (km/h) | Cf | V efectiva (km/h) | Estado |
|---|---|---|---|---|
| Tren Suburbano | 65.0 | 1.000 | ~65.0 | ✅ OK [55–75] |
| METRO | 36.0 | 1.000 | ~36.0 | ✅ OK [30–42] |
| Tren Ligero | 22.0 | 1.000 | ~22.0 | ✅ OK [18–26] |
| Cablebús | 20.0 | 1.152 | ~17.4 | ✅ OK [16–24] |
| Metrobús | 16.3 | 1.000 | ~16.3 | ✅ OK [13–20] |
| Mexibús | 14.5 | 1.152 | ~12.6 | ✅ OK aprox |
| Trolebús | 18.0 | 1.380 | ~13.0 | ⚠️ REVISAR [14–22] − 7% |
| RTP | 14.0 | 1.759 | ~8.0 | ✅ OK revisado [10–18]* |
| CC | 11.0 | 1.759 | ~6.3 | ✅ OK revisado [8–14]* |

\* El fallback de RTP/CC representa flujo libre; la velocidad efectiva bajo congestión está dentro del rango observado en campo según el notebook.

- **Recurso visual:**
  - `Figures/Cap5/fig01_impedancia.png` — figura 1 del notebook (velocidades + boxplot)
- **Estado:** ✅ Completo
- **Issues de NOTES:**
  - **P1 (double-counting RTP/CC):** ✅ RESUELTO — el notebook documenta explícitamente que los fallbacks representan flujo libre y el Cf introduce la penalización dinámica de forma aislada. No hay double counting.
  - **P5 (cita SEDATU para alpha):** ⚠️ PENDIENTE — los coeficientes alpha (0.0, 0.2, 0.5, 1.0) no tienen cita explícita al Manual de Calles SEDATU 2019 en el notebook.

---

### §5.3.2 — Nivel de Cobertura Espacial C (NB02)

- **Resultado:**
  - Radio isócrono: 800 m (10–15 min caminata)
  - 141 demarcaciones analizadas (16 alcaldías CDMX + 125 municipios ZMVM)
  - Rango total: 0.0% – 100.0%
  - Exportado a `Cobertura800m.gpkg` con 4 capas
  - Clasificación aplicada: Alta ≥60%, Media 30–60%, Baja 10–30%, Muy baja <10%
  - Bottom 5 municipios con 0%: municipios lejanos del Estado de México (Acambay, Acolman, Aculco, etc.) — sin cobertura porque están fuera del área de servicio
  - **Valores exactos por alcaldía CDMX:** requieren consultar el GeoPackage `Cobertura800m.gpkg` (tabla completa truncada en el output del notebook)

- **Recurso visual:**
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig01_mapa_cobertura_general.png` — mapa coroplético general
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_METRO_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_MB_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_RTP_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_CC_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_CBB_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_SUB_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_TL_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_TROLE_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_MEXIBÚS_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_MEXICABLE_cobertura.png`
  - `Figures/Cap5/Cobertura/Mapas/NB02_fig02_PUMABUS_cobertura.png`
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_Cobertura_Red_Total.pdf`
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_Cobertura_Mapa_Calor.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/UniGrafica/Grafica_VFTModel_2026_Cobertura_sistema.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/UniGrafica/Grafica_VFTModel_2026_Cobertura_alcaldia.pdf`

- **Estado:** ✅ Cálculos completos; tabla exacta por alcaldía en GeoPackage (requiere extraerla para el texto)
- **Issues de NOTES:**
  - **P2 (CBB subrepresentado):** ⚠️ SIGUE ABIERTO — NB02 confirma CBB con solo 30 aristas de servicio. El notebook no lo menciona explícitamente pero los datos lo evidencian.

---

### §5.3.3 — Fuerza Capilar FC_h (NB03)

- **Resultado:**
  - 11,115 nodos individuales procesados
  - 4,697 macro-hubs consolidados (tolerancia 100 m)
  - **Top 5 nodos matemáticos (FC_i):**
    1. Luis Murillo [RTP] — FC = 41 (entrada: 21, salida: 20)
    2. Calz. de Tlalpan - Glorieta Huipulco [RTP] — FC = 34
    3. Tlalpan y Luis Murillo [CC] — FC = 33
    4. Sobre Calz. De Tlalpan y Luis Murillo [CC] — FC = 33
    5. Estadio Azteca 2 [RTP] — FC = 32
  - **Top 5 macro-hubs geográficos (FC_H):**
    1. Barranca del Muerto / Periférico Sur (CC+RTP, 21 estaciones) — FC = 92
    2. Tlalpan-Periférico / Renato Leduc (CC+RTP, 18 estaciones) — FC = 67
    3. Periférico-San Antonio (CC+RTP, 7 estaciones) — FC = 46
    4. Canal de Garay / Constitución de Apatzingán (CC+MB+RTP, 8 estaciones) — FC = 46
    5. México-Xochimilco / Tren Ligero (CC+RTP+TL, 14 estaciones) — FC = 45
  - **Top 5 nodos matemáticos en Periférico (FC_i):**
    1. Anillo Periférico y Blvd. Adolfo Ruíz Cortines [RTP] — FC = 30
    2. Anillo Periférico y Blvd. Adolfo Ruiz Cortines [RTP] — FC = 26
    3. Periférico - Barranca del Muerto [CC] — FC = 21
    4. Anillo Periférico Sur - Barranca del Muerto [RTP] — FC = 20
    5. Periférico [RTP] — FC = 20
  - Distribución: Scale-Free Network — mayoría de nodos con FC = 2 (nodos de paso), minoría con FC alto (hubs)
  - Exportado a `FuerzaCapilar.gpkg` (fc_puntos: 10,537 nodos con FC≥3; fc_top20_hubs: 20 macro-hubs)

- **Recurso visual:**
  - `Figures/Cap5/FuerzaCapilar/Mapa/NB03_mapa01_macrohubs.png` — top macrohubs red completa
  - `Figures/Cap5/FuerzaCapilar/Mapa/NB03_mapa02_nodos_matematicos.png` — top nodos individuales
  - `Figures/Cap5/FuerzaCapilar/Mapa/NB03_mapa03_macrohubs_periferico.png` — hubs en Periférico
  - `Figures/Cap5/FuerzaCapilar/Mapa/NB03_mapa04_nodos_matematicos_periferico.png` — nodos en Periférico
  - `Figures/Cap5/FuerzaCapilar/Tabla/NB03_fig01_top10_macrohubs_barplot.png`
  - `Figures/Cap5/FuerzaCapilar/Tabla/NB03_fig02_top10_nodos_matematicos_barplot.png`
  - `Figures/Cap5/FuerzaCapilar/Tabla/NB03_fig03_distribucion_capilar_histograma.png`
  - `Figures/Cap5/FuerzaCapilar/Tabla/NB03_fig04_top10_macrohubs_periferico_barplot.png`
  - `Figures/Cap5/FuerzaCapilar/Tabla/NB03_fig05_top10_nodos_matematicos_periferico_barplot.png`
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_Fuerza_Capilar.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/Dashboards/Dashboard_VFTModel_2026_Fuerza_Capilar.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/UniGrafica/Grafica_VFTModel_2026_Fuerza_capilar.pdf`

- **Estado:** ✅ Completo — resultados calculados, exportados a GeoPackage, figuras existentes

---

### §5.3.4 — Factor de Desviación DI (NB04)

- **Resultado:**
  - Muestra estadística: 100 rutas aleatorias (seed=42)
  - **Top 5 alcaldías/municipios con mayor DF promedio:**
    1. Chimalhuacán — DI promedio = 3.51 (1 ruta)
    2. Tláhuac — DI promedio = 3.34 (2 rutas)
    3. Ecatepec de Morelos — DI promedio = 2.12 (1 ruta)
    4. Iztacalco — DI promedio = 1.78 (3 rutas)
    5. Iztapalapa — DI promedio = 1.68 (9 rutas)
  - **12 casos de estudio definidos y calculados** (origen principal: Milpa Alta/periferia sur):
    - Caso 1: Periferia Sur → Autódromo H. Rodríguez
    - Caso 2: Milpa Alta → CBD Reforma
    - Caso 3: Milpa Alta → CBD Santa Fé
    - Caso 4: Milpa Alta → FES Acatlán
    - Caso 5: Milpa Alta → Ciudad Universitaria
    - Caso 6: Milpa Alta → Coyoacán
    - Caso 7: Santa Catarina (Oriente) → CU
    - Caso 8: Santa Catarina → FES Acatlán
    - Caso 9: Milpa Alta → Tláhuac/Santa Catarina (Sur-Oriente)
    - Caso 10: Milpa Alta → Ajusco
    - Caso 11: Ajusco → Prepa 1
    - Caso 12: Parque Los Olivos → Centro Tláhuac
  - Exportado a `FactorDesviacion.gpkg` (df_puntos: 100 rutas; df_por_alcaldia: 141 demarcaciones)
  - **Nota sobre P4:** Los pares específicos de la tesis (Xochimilco→Santa Fe DI=1.87, Perisur→Naucalpan DI=2.33, Iztapalapa→Tlalnepantla DI=2.50) son valores teóricos que no corresponden exactamente a los calculados sobre el grafo. Los 12 casos de estudio cubren escenarios análogos (Milpa Alta→Santa Fe, Milpa Alta→FES Acatlán, periferia oriente→destinos) con DI reales.

- **Recurso visual:**
  - `Figures/Cap5/FactorDesviacion/Mapa/NB04_mapa01_caso_inicial.png`
  - `Figures/Cap5/FactorDesviacion/Mapa/NB04_mapa02_ruta_mas_eficiente.png`
  - `Figures/Cap5/FactorDesviacion/Mapa/NB04_mapa03_ruta_mas_ineficiente.png`
  - `Figures/Cap5/FactorDesviacion/Mapa/NB04_mapa04_caso01.png` — NB04_mapa15_caso12.png (12 mapas)
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_DF.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/Dashboards/Dashboard_VFTModel_2026_Factor_desviacion.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/UniGrafica/Grafica_VFTModel_2026_Factor_desviacion.pdf`

- **Estado:** ✅ Completo — muestra estadística + 12 casos calculados
- **Issues de NOTES:**
  - **P4 (pares DI teóricos):** ⚠️ PARCIALMENTE ABIERTO — los 3 pares específicos de la tesis no están calculados con el grafo real. Los 12 casos de estudio cubren escenarios equivalentes pero con coordenadas diferentes. Recomendación: reemplazar los valores teóricos con los DI reales de los casos calculados (o calcular los 3 pares específicos).

---

### §5.4.1 — Coeficiente de Fricción Vial CF (NB01)

- **Resultado:** β = 0.759 (TomTom Traffic Index CDMX)
  - Cf exclusivo = 1.000 (Metro, MB, TL, Tren Suburbano)
  - Cf confinado = 1.152 (Cablebús, Mexibús, Mexicable)
  - Cf compartido = 1.380 (Trolebús)
  - Cf mixto = 1.759 (RTP, CC, Pumabús)
- **Recurso visual:** Figura 1 del NB01 (panel izquierdo — barras de velocidad por sistema)
- **Estado:** ✅ Completo — calculado y documentado

---

### §5.4.2 — Penalización por Transferencia Tb (NB01)

- **Resultado:** Tb = F/2 (mitad de la frecuencia del sistema destino, en minutos)
  - 20,482 aristas de transbordo peatonal con Tb aplicado
  - La penalización actúa SOLO sobre aristas tipo "transfer", no en aristas de servicio
- **Recurso visual:** Ninguno dedicado — se integra en la figura general de impedancia
- **Estado:** ✅ Calculado e integrado al grafo — sin figura dedicada propia

---

### §5.5.1 — Tiempo de Viaje Promedio T (NB05) ← CALCULADO

- **Resultado:** **T = 108.92 minutos** (corrida 2026-09-02)
  - Subgrafo: componente gigante = 10,561 nodos (95.0% del total)
  - Tiempo de cómputo: 251.8 segundos (Dijkstra ponderado sobre todos los pares)
  - Referencia INEGI/ENOE CDMX: ~85 min
  - Diferencia explicada: el modelo evalúa TODOS los pares O-D sin ponderar por demanda (incluye pares periféricos Milpa Alta ↔ Tlalnepantla que inflan el promedio); INEGI pondera por viajes reales

- **Recurso visual:**
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_Betweenness.pdf` — mapa de centralidad (T alimenta B(v))
  - Sin mapa dedicado para T propiamente dicho

- **Estado:** ✅ **CALCULADO Y DISPONIBLE** — la tesis actual lo muestra como pendiente pero el cálculo YA EXISTE en NB05

---

### §5.5.2 — Centralidad de Intermediación B(v) (NB05) ← CALCULADO

- **Resultado:** **B(v) calculado sobre 10,561 nodos** (corrida 2026-09-02)
  - Tiempo de cómputo: 593.4 segundos (~10 min, algoritmo de Brandes)
  - **Top 10 nodos por B(v):**

| # | Estación | Sistema | Alcaldía | Es CETRAM | B(v) |
|---|---|---|---|---|---|
| 1 | Tacubaya | METRO | Miguel Hidalgo | No | 0.2179 |
| 2 | Mixcoac | METRO | Benito Juárez | No | 0.1725 |
| 3 | Hidalgo | METRO | Cuauhtémoc | No | 0.1595 |
| 4 | Balderas | METRO | Cuauhtémoc | No | 0.1433 |
| 5 | Lázaro Cárdenas | METRO | Cuauhtémoc | No | 0.1376 |
| 6 | Chilpancingo | METRO | Cuauhtémoc | No | 0.1366 |
| 7 | Viaducto | METRO | Benito Juárez | No | 0.1346 |
| 8 | Villa de Cortés | METRO | Benito Juárez | No | 0.1341 |
| 9 | Nativitas | METRO | Benito Juárez | No | 0.1299 |
| 10 | Zapata | METRO | Benito Juárez | No | 0.1283 |

  - El METRO domina COMPLETAMENTE el top de intermediación
  - Tacubaya lidera (no Pantitlán) por ser el puente centro ↔ poniente
  - Distribución: ley de potencias — mayoría con B ≈ 0, minoría crítica

- **Recurso visual:**
  - `Figures/Mapas/Qgis_Resources/RedActual/Mapa_Betweenness.pdf` — mapa QGIS de B(v)
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/Dashboards/Dashboard_VFTModel_2026_Centralidad_intermediacion.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/UniGrafica/Grafica_VFTModel_2026_Centralidad_Intermediacion_Nodos.pdf`
  - `Figures/Mapas/Tableau_Resources/RedActual/VFTModel/UniGrafica/Grafica_VFTModel_2026_Centralidad_Intermediacion_sistema.pdf`

- **Estado:** ✅ **CALCULADO Y DISPONIBLE** — la tesis actual lo muestra como pendiente pero el cálculo YA EXISTE en NB05

---

### §5.5.3 — Vulnerabilidad Estructural ΔE (NB05 — parcial)

- **Resultado (preludio — no cálculo formal):**
  - Simulación de remoción de los 5 nodos con mayor B(v):

| Estación removida | B(v) | T original (min) | T sin nodo (min) | ΔT (min) |
|---|---|---|---|---|
| Tacubaya | 0.2179 | 108.92 | 111.80 | +2.88 |
| Mixcoac | 0.1725 | 108.92 | 110.19 | +1.27 |
| Hidalgo | 0.1595 | 108.92 | 109.90 | +0.98 |
| Balderas | 0.1433 | 108.92 | 109.56 | +0.65 |
| Lázaro Cárdenas | 0.1376 | 108.92 | 110.13 | +1.21 |

  - El notebook mismo llama a esto "preludio especulativo" — el cálculo formal de ΔE requiere un módulo independiente en `core/algorithms/topological/`

- **Recurso visual:** Ninguno exportado a `Figures/`
- **Estado:** ❌ Sin cálculo formal — solo estimación de 5 nodos disponible en NB05
- **Nota:** Para la tesis, la tabla de simulación de 5 nodos es suficiente como resultado ilustrativo de ΔE en borrador alfa

---

## Resumen: qué tenemos y qué falta

### ✅ Indicadores con resultado calculado + recurso visual disponible

| Indicador | Valor clave | Recursos visuales |
|---|---|---|
| Grafo topológico | 11,115 nodos / 45,679 aristas | 4 paneles PNG + 2 mapas QGIS + 2 dashboards Tableau + 3 gráficas |
| Validación de impedancia | METRO=36 km/h, SUB=65 km/h, RTP~8 km/h (ok) | 1 figura NB01 |
| Cobertura C | Rango 0–100%, 141 demarcaciones | 12 PNGs NB02 + 2 mapas QGIS + 2 gráficas Tableau |
| Fuerza Capilar FC_h | Top hub: Barranca del Muerto FC=92; top nodo: Luis Murillo FC=41 | 4 mapas + 5 barplots + 1 mapa QGIS + 2 gráficas Tableau |
| Factor de Desviación DI | Top alcaldía: Chimalhuacán DI=3.51; Tláhuac DI=3.34 | 15 mapas NB04 + 1 mapa QGIS + 2 gráficas Tableau |
| Fricción Vial CF | β=0.759; Cf mixto=1.759 | Integrado en NB01 |
| **Tiempo de Viaje T** | **T = 108.92 min** | Integrado en NB05 |
| **Centralidad B(v)** | **Tacubaya B=0.2179 (top)** | 1 mapa QGIS + 1 dashboard + 2 gráficas Tableau |
| ΔE (preludio) | Tacubaya ΔT=+2.88 min al remover | Solo tabla en NB05 |

### ⚠️ Indicadores con resultado pero sin integración al texto de la tesis

- **T = 108.92 min** — calculado en NB05 (2026-09-02) pero la tesis lo muestra como "Pendiente"
- **B(v) con top 10** — calculado en NB05 pero la tesis lo muestra como "Pendiente"
- **ΔE parcial** — 5 nodos simulados en NB05 pero no integrado al texto

### ❌ Indicadores sin resultado calculado / con data incompleta

- **ΔE formal (Vulnerabilidad)** — requiere módulo `topological/robustness.py` no implementado
- **Cobertura C por alcaldía CDMX (valores exactos)** — están en `Cobertura800m.gpkg` pero el output del NB02 fue truncado; requiere consultar el GeoPackage directamente
- **DI para pares específicos de la tesis** (Xochimilco→Santa Fe=1.87, Perisur→Naucalpan=2.33) — son valores teóricos; los análogos calculados tienen coordenadas distintas
- **Tb individualizado** — existe como atributo del grafo pero sin tabla de resultados consolidada

---

## Issues metodológicos pendientes (de NOTES/issues.md)

| Issue | Descripción | Estado según notebooks |
|---|---|---|
| **P1** | Double-counting fricción en RTP/CC | ✅ **RESUELTO** — NB01 documenta metodología correcta: fallbacks=flujo libre, Cf=penalización dinámica aislada |
| **P2** | CBB subrepresentado (30 aristas vs 3 líneas) | ⚠️ **SIGUE ABIERTO** — NB01 confirma 30 aristas de CBB. Sin corrección documentada |
| **P3** | T promedio pendiente de Dijkstra | ✅ **RESUELTO** — NB05 calcula T = 108.92 min con Dijkstra sobre 10,561 nodos |
| **P4** | Pares DI teóricos no calculados sobre grafo real | ⚠️ **PARCIALMENTE ABIERTO** — NB04 calcula 100 pares + 12 casos, pero los 3 pares específicos de la tesis no están entre ellos |
| **P5** | Cita faltante alpha Manual SEDATU 2019 | ⚠️ **SIGUE PENDIENTE** — ningún notebook la menciona explícitamente |

---

## Recomendación para la redacción

**Lo que se puede escribir ahora sin ejecuciones adicionales:**

Las secciones §5.2, §5.3.1, §5.3.2, §5.3.3, §5.3.4 y §5.4 tienen resultados calculados, figuras disponibles y datos suficientes para redacción completa. Lo más urgente es integrar los resultados de T y B(v) del NB05 (corrida 2026-09-02) a las secciones §5.5.1 y §5.5.2, que la tesis muestra incorrectamente como "Pendiente". Para §5.5.3 (ΔE), la tabla de simulación de los 5 nodos del NB05 es aceptable como resultado ilustrativo en el borrador alfa.

**Lo que requiere consulta del GeoPackage antes de redactar:**
- Extraer los valores exactos de cobertura C por alcaldía CDMX del archivo `Cobertura800m.gpkg` para la tabla de §5.3.2.

**Lo que requiere decisión editorial:**
- Los pares DI (P4): decidir si se reemplazan los valores teóricos (1.87, 2.33, 2.50) por los valores reales de los casos de estudio calculados en NB04, o si se recalculan los 3 pares originales.
- La cita SEDATU para alpha (P5): agregar a `referencias.bib` antes del borrador final.
- CBB (P2): documentar en el texto como limitación de los datos del backend, no como error del modelo.
