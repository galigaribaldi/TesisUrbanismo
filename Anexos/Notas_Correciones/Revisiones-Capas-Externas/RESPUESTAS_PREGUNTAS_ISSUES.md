# Respuestas de datos — PREGUNTAS_ISSUES (Revisión-2 Dr. Jairo, #28 🔴, #29 🟠)

**Fecha:** 2026-10-14
**Responde a:** `PREGUNTAS_ISSUES.md` (P0–P10) y a las preguntas de datos de `VERIFICACION_VFTMODEL.md`, `CHECK0_DIAGNOSTICO_DATOS.md` y `Notas-Seminario/` (sección 12).
**Método:** solo lectura. Las cifras salen de las exportaciones en disco, de las APIs locales que estaban corriendo (VFTModel :8000/:8001/:8002, Apimetro :8080/:8083/:8084) y del código de VFTModel y Apimetro. No se reconstruyó ninguna caché ni se modificaron datos. Cuando un dato no existe, se dice y se da el valor más cercano que sí existe.
**Estados:** ✅ Respondida · 🟡 Parcial · ❌ No se puede responder con los datos · 📝 No es pregunta de datos (redacción o bibliografía).
**Abreviaturas de rutas:** `GIS/` = este repo · `VFT/` = repo VFTModel · `TES/` = repo de la tesis (TesisUrbanismo) · `GAR/` = `GIS/tableau/exports/data/garibelt`.
**Valores derivados:** cuando una cifra no la entrega VFTModel directamente y se calculó aplicando la regla del código a los datos, se marca como *derivada*.

---

## Resumen

| P | Tema | Estado | Lo esencial |
|---|---|---|---|
| P0 | Corrida canónica | ✅ | Corrida post Fix #23 (2026-10-03 noche), con #22, #23 y #26. 11,115 nodos, 45,517 aristas, gigante 10,610. |
| P1 | Cifras del grafo | ✅ | 25,025 aristas de servicio en **12** sistemas. 7.28 % / 92.71 % con la lista actual del texto. Metro 2.11 %. |
| P2 | Cobertura con 76 | ✅ (año 🟡) | C(76) = 13.29 % → 0.1661, Crítico. CDMX 53.52 %, municipios 3.92 %. 42 de 60 municipios en 0 %. |
| P3 | FC / FC_H | ✅ (desglose 🟡) | Mediana 7, Q1 6, Q3 10 sin cambio. 49.3 % de transbordos del mismo sistema sí es de la corrida vigente. |
| P4 | DI | ✅ | Media 1.701 (100 pares), mediana del Espectro 1.52 → 0.6533. 0 pares con DI < 1. 12 casos recalculados. |
| P5 | Velocidades | ✅ | El Cuadro 5.3 no coincide con los datos: MB 16.3, CBB y Mexicable 20.0, RTP V = 11. |
| P6 | α y β | 🟡 / ❌ | α documentados en código. Sin edición de TomTom, sin criterio de α, sin sensibilidad (#30). |
| P7 | T y ENOE | ✅ T / ❌ ENOE | T = 113.91 min sobre 10,610 nodos. La cita de la ENOE no existe en ninguna fuente local. |
| P8 | B(v) figura vs cuadro | ✅ | Misma corrida. La figura suma B(v) por nombre sin radio. Gini 0.8007 → 0.1993. |
| P9 | ΔE y E₀ | ❌ | No hay código ni corrida vigente de ΔE (Issue #5). Lo más cercano: E₀ = 1/113.91. |
| P10 | Espectro MJG | ✅ | Bandas de la red actual sin cambio. Cambian DI, T y B(v). Normalización sin cambios. |

---

## P0. Corrida canónica

**P0.1 — ✅ Corrida vigente**
- Re-corrida **post Fix #23 del 2026-10-03 (noche)**. El 2026-10-04 se verificó con el #26 y el perfil quedó igual. Fuente: `NOTES/VFTModel/RESULTADOS_RECORRIDA.md` §7 y §9.2.
- Código VFTModel: rama `feat/propuesta-anillar-indicador`, HEAD `4ef4265` (2026-10-05, commit de docs). Contiene:

| Commit | Fecha | Fixes |
|---|---|---|
| `5577273` "fix(grafo): corregir distancia de aristas y conectar el Tren Suburbano" | 2026-10-04 | #22 y #23 |
| `e1adf44` "feat(cobertura): reportar C sobre las 76 demarcaciones ZMVM" | 2026-10-04 | #26 |

- Apimetro: HEAD `e0b9122` "fix(data): correcciones de calidad de datos ACHECKs 01-04" (2026-10-03).
- Los servidores se levantaron el 2026-10-12 a las 19:18. Después del HEAD solo cambió un notebook. Los cambios sin commit en el árbol de trabajo no se pueden descartar sin usar git.

**P0.2 — ✅ Cifras de la corrida vigente**

| Métrica | Valor |
|---|---|
| Nodos | 11,115 |
| Aristas totales | 45,517 |
| Aristas de servicio | 25,025 |
| Aristas de transbordo | 20,492 (20,482 por el umbral de 85 m + 10 de los 5 transbordos oficiales del SUB) |
| SCC | 195 |
| Componente gigante | 10,610 nodos (95.46 %), 44,377 aristas |
| Entidades de origen en Apimetro | 23,550 = 22,872 estaciones/paradas + 678 trazos |

Los 11,115 nodos son las coordenadas únicas de las 22,872 estaciones. Fuente: `GET :8000/api/v1/network/topological/scc-analysis`, `GIS/tableau/connectors/VFTModel/exports/wdc_t_escalar.csv`, `GET :8080/movilidad/mapas/geojsonEstacion` y `geojsonLinea`.

**P0.3 — ✅ ¿10,561 y 11,115 son de la misma corrida?**
No. 10,561 es la componente gigante y 11,115 el grafo completo, pero vienen de corridas distintas. Los 11,115 nodos no cambian entre corridas. §5.2 combina el grafo del 04-18 con la componente gigante del 09-02.

| Corrida | Entidades | Aristas phantom eliminadas | Servicio + transbordo = total | Gigante |
|---|---|---|---|---|
| 2026-04-18 (§5.2) | 22,766 | 1,562 | 25,197 + 20,482 = 45,679 | no calculada |
| 2026-09-02 (§5.5.1, §5.5.2) | 23,540 | 1,542 | 25,015 + 20,482 = 45,497 | 10,561 nodos, 44,241 aristas, 209 SCC |
| **Vigente** | 23,550 | 1,530 | 25,025 + 20,492 = 45,517 | **10,610 nodos, 44,377 aristas, 195 SCC** |

Fuente: salidas de `VFT/notebooks/00_Construccion_grafo.ipynb` (celdas 1-2) y `05_Fase3_T_B.ipynb` (celdas 2-5); `scc-analysis`.

**P0.4 — 🟡 Datos vigentes por sección.** La elección entre las opciones A y B la decide el autor. Esta tabla solo dice qué datos existen hoy.

| Sección | Corrida que cita el texto | Datos vigentes disponibles |
|---|---|---|
| §5.2 Grafo | 04-18 | Totales y nodos por sistema en `scc-analysis`. Las aristas por sistema no tienen endpoint. Están en `RESULTADOS_RECORRIDA.md` §8.2 y se confirmaron reconstruyendo el grafo en memoria. |
| §5.3.1 Impedancia | 04-18 | Velocidad y derecho de vía en Apimetro; α y β en `VFT/src/core/models/impedance.py`. No hay archivo con tiempo por arista. |
| §5.3.2 Cobertura | 04-18 | `/spatial-coverage` con los dos dominios; `GAR/escenario-base/cobertura_alcaldias_baseline.csv` (141 filas). |
| §5.3.3 FC | 04-18 | `fc_puntos`, `fc_hubs`, `wdc_fc_*.csv` y `fc_distribucion_baseline.csv`. |
| §5.3.4 DI | 04-27 | Muestras de 100 pares (disco), 200 (disco) y 500 (API); `df_por_alcaldia.geojson`. |
| §5.5.1 T | 09-02 | T = 113.9087 sobre 10,610 nodos. No hay tiempo de cómputo. |
| §5.5.2 B(v) | 09-02 | `b_ranking_baseline.csv` (top 2,000), `bv_comparativo.csv` (10,610 nodos) y Gini. |
| §5.5.3 ΔE | 09-02 | **No hay datos ni código** (ver P9). |
| §5.6 Espectro | 09-02 / 09-24 | `garibelt_perfil_*.csv` y `kpi_comparativo.csv`. |

---

## P1. Cifras del grafo — §5.2

**P1.1 — ✅ Aristas de servicio por sistema.** El grafo tiene **12 sistemas**, no 11, porque incluye el Interurbano.

| Sistema | Texto (04-18) | Vigente | Nodos |
|---|---|---|---|
| RTP | 11,041 | 10,904 | 4,905 |
| CC | 10,603 | 10,573 | 4,620 |
| TROLE | 1,506 | 1,489 (1,460 compartido + 29 confinado, L10) | 738 |
| MB | 792 | 789 | 347 |
| METRO | 528 | 528 | 195 |
| MEXIBÚS | 391 | 393 | 157 |
| PUMABUS | 234 | 234 | 90 |
| TL | 52 | 52 | 18 |
| CBB | 30 | 30 | 19 |
| MEXICABLE | 17 | 17 | 14 |
| SUB | 3 | 12 | 7 |
| INTERURBANO | — | 4 | 5 |
| **Total** | **25,197** | **25,025** | **11,115** |

Fuente: `RESULTADOS_RECORRIDA.md` §8.2, idéntico a la reconstrucción; nodos de `scc-analysis` → `fragmentation_by_system`.

**P1.2 — ✅ Tren Suburbano y Cablebús**
- **SUB ya no está subrepresentado.** Tiene 12 aristas, que son los 6 tramos en ambos sentidos. Sus 7 estaciones están en la componente gigante. Tiene 5 transbordos oficiales: Buenavista con Metro y con MB, Lechería con Mexibús y Tlalnepantla con CC. En el GTFS tiene 6 trips y 7 stops únicos (`Apimetro/ETL/Data/`).
- **CBB tiene las mismas 30 aristas, con problemas de calidad.**
  - Tiene 19 estaciones, de las cuales 14 están en la gigante (73.7 %).
  - El filtro phantom eliminó 4 aristas de la L1.
  - La L3 solo tiene aristas en un sentido (Apimetro#71).
  - 9 de las 30 aristas cruzan saltos de más de 50 m entre sublíneas y son candidatas a adyacencias falsas (#24).

**P1.3 — ✅ Derecho de vía y porcentajes**
- En el código no existe una categoría "estructurada". El modelo toma el campo `derecho_de_via` de Apimetro y le asigna α: exclusivo 0.0, confinado 0.2, compartido 0.5 y mixto 1.0 (`impedance.py:20-28`).
- Así llegan los sistemas en los datos vigentes:
  - **Exclusivo:** METRO, MB, TL, SUB, CBB, MEXICABLE, INTERURBANO.
  - **Confinado:** MEXIBÚS, TROLE L10.
  - **Compartido:** RTP, CC, PUMABUS, resto de TROLE.
  - **Mixto:** ninguno.

| Base de 25,025 aristas | Aristas | % |
|---|---|---|
| Lista actual del texto (7 sistemas) | 1,821 | **7.28 %** |
| RTP + CC + TROLE + PUMABUS | 23,200 | **92.71 %** |
| Exclusivo según Apimetro | 1,432 | 5.72 % |
| Exclusivo + confinado | 1,854 | 7.41 % |
| Metro | 528 | **2.11 %** |

**P1.4 — ✅ Phantom, redundancias y entidades**
- **Entidades.** Pasan de 22,766 a 23,550 (+784).
- **Filtro phantom.** Elimina 1,530 aristas: RTP 686, CC 637, MB 142, TROLE 28, MEXIBÚS 16, METRO 13, CBB 4 y TL 4. La regla del Fix #23 conserva 11 aristas de más de 5 km: SUB 4, INTERURBANO 4, MB 1, MEXIBÚS 1 y TROLE 1.
- **El código no elimina nodos fantasma.** Un nodo es una coordenada única. Las 22,872 estaciones se colapsan en 11,115 nodos. Hay 39 coordenadas compartidas por dos sistemas, y cada una queda etiquetada con un solo sistema.
- **Hallazgo nuevo, sin registro en las notas.** El grafo admite una sola arista por par de nodos. Cuando un transbordo de 85 m o menos une dos paradas que ya tenían un tramo de servicio, lo reemplaza.
  - Así se pierden **5,552 aristas de servicio**: RTP 2,728, CC 2,428, TROLE 301, MB 60, PUMABUS 28, MEXIBÚS 5 y METRO 2.
  - El balance cuadra: 32,107 − 1,530 − 5,552 = 25,025.
  - Es una cifra *derivada* de la reconstrucción del grafo.
- **Nota † sobre la geometría de OSM.** ❌ No se puede verificar: el campo `fuente` de Apimetro documenta la velocidad, no la geometría.

---

## P2. Cobertura C con 76 municipios — §5.3.2

**P2.1 — 🟡 Capa y año**
- El modelo no usa una capa propia de la ZMVM. Usa un catálogo de 76 claves CVEGEO en `VFT/src/core/utils/zmvm.py`, rotulado "SEDATU-CONAPO-INEGI", y lo aplica sobre los polígonos municipales de Apimetro.
- La composición se verificó: **16 CDMX + 59 Edomex + 1 Hidalgo (Tizayuca, 13069) = 76** ✅.
- ❌ **El año o la edición no aparecen** ni en el código ni en la capa. Lo más cercano son menciones sin respaldo: "Decreto CONAPO 2018" en `VERIFICACION_VFTMODEL.md:236` e "INEGI 2023" en un pie de figura de la tesis.
- El dominio 141 son 16 alcaldías y 125 municipios, todos del Estado de México. Ninguno es de Hidalgo, Puebla ni Tlaxcala.

**P2.2 — ✅ C con 76 demarcaciones.** La API devuelve los dos dominios en `resumen_dominios`. El desglose CDMX / municipios es *derivado*, aplicando la fórmula del modelo a las filas de la API.

| Dominio | n | Área (km²) | Cubierta (km²) | C (%) | Normalizado | Banda |
|---|---|---|---|---|---|---|
| Entidades (141) | 141 | 23,982.18 | — | 4.4138 | 0.0552 | Crítico |
| **ZMVM (76)** | 76 | 7,905.98 | 1,050.48 | **13.287** | **0.1661** | Crítico |
| CDMX | 16 | 1,493.14 | 799.16 | 53.52 | 0.669 | Aceptable |
| Municipios (59 + Tizayuca) | 60 | 6,412.84 | 251.32 | 3.92 | 0.049 | Crítico |

En MB y Metro, que son idénticos entre sí: C(141) = 4.4596, C(76) = 13.426 → 0.1678, CDMX 53.53 % y municipios 4.09 %.

**P2.3 — ✅ CDMX / 🟡 municipios. Menor cobertura en el dominio 76, red actual**

| CDMX | Área (km²) | Cubierta (km²) | C (%) |
|---|---|---|---|
| Milpa Alta | 298.01 | 35.00 | 11.75 |
| La Magdalena Contreras | 63.37 | 16.33 | 25.76 |
| Tlalpan | 314.25 | 94.31 | 30.01 |
| Tláhuac | 85.78 | 43.85 | 51.12 |
| Cuajimalpa de Morelos | 71.10 | 37.12 | 52.20 |

En municipios no existe un top 5 único: **42 municipios empatan en 0 %** y el modelo no define criterio de desempate. Hay dos lecturas posibles con los datos:
- **Los 5 menores con C > 0:**

| Municipio | Área (km²) | Cubierta (km²) | C (%) |
|---|---|---|---|
| Ixtapaluca | 318.27 | 0.11 | 0.03 |
| Atenco | 92.35 | 0.10 | 0.11 |
| Chalco | 229.64 | 0.60 | 0.26 |
| Cuautitlán Izcalli | 103.89 | 1.90 | 1.83 |
| Zumpango | 244.75 | 6.88 | 2.81 |

- **Los 5 en 0 % con mayor área:** Texcoco, Villa del Carbón, Axapusco, Hueypoxtla y Nicolás Romero.

⚠️ En la tabla de extremos de la tesis, **Capulhuac, Calimaya y Donato Guerra no pertenecen a la ZMVM 76**. Tonanitla y Ayapango sí pertenecen.

**P2.4 — ✅ Dominio del 4.4 % del Espectro.** Se calculó con **141**, igual que el valor anterior. Con 76 vale 13.287 % → 0.1661 y **sigue en Crítico**. Fuente: `GAR/escenario-base/garibelt_perfil_baseline.csv`, fila `accesibilidad`; `VFT/src/api/main.py:466-491`.

**P2.5 — ✅ Recursos que hoy usan el dominio 141**

| Recurso | Herramienta | Fuente de datos |
|---|---|---|
| Clasificacion_Garibelt_Mapa_Cobertura (Red Actual, MB, Metro) | QGIS | `cobertura_garibelt*.geojson` |
| Comparativo_Garibelt_Cobertura | QGIS | `cobertura_garibelt.geojson` + CSV de escenarios |
| Mapa_Cobertura_Red_Total y Mapa_Cobertura_Mapa_Calor | QGIS | `Cobertura800m.gpkg` (09-17) |
| Grafica_VFTModel_2026_Cobertura_alcaldia y _sistema | Tableau | `cobertura_por_alcaldia.geojson` |
| Dashboards Garibelt: Espectro, KPI y Clasificación | Tableau | `garibelt_perfil_baseline.csv` (C = 4.4138) |

⚠️ El layout "Cobertura Garibelt" de `garibelt_red_actual.qgz` todavía dice "141 demarcaciones de la ZMVM", "isócronas peatonales" y "0.055 — banda crítica". ESTADO_RECURSOS lo da como corregido. El PDF no tiene texto extraíble, así que no se pudo confirmar qué quedó exportado.

**P2.6 — ✅ Municipios con C = 0 %.** En la red actual son **42 de 60**. Ninguna alcaldía de la CDMX tiene 0 %. En MB y Metro son 41, porque Texcoco sube a 0.13 %.

Lista ordenada por área: Texcoco*, Villa del Carbón, Axapusco, Hueypoxtla, Nicolás Romero, Tepotzotlán, Temascalapa, Amecameca, Tepetlaoxtoc, Atlautla, Huehuetoca, Tlalmanalco, Otumba, Juchitepec, Jilotzingo, Tequixquiac, Atizapán de Zaragoza, Nopaltepec, Acolman, Teotihuacán, Apaxco, Isidro Fabela, Tizayuca (Hgo.), San Martín de las Pirámides, Nextlalpan, Ecatzingo, Ayapango, Ozumba, Tepetlixpa, Tenango del Aire, Teoloyucan, Temamatla, Chiautla, Tultepec, Melchor Ocampo, Coyotepec, Tezoyuca, Cocotitlán, Tonanitla, Chiconcuac, Jaltenco y Papalotla.

\* Texcoco tiene 0.01 km² cubiertos y aparece con 0 % por redondeo.

---

## P3. Fuerza Capilar FC / FC_H — §5.3.3

**P3.1 — ✅ Mediana, Q1 y Q3: no cambian**

| Población | n | Mediana | Q1 | Q3 | Media | Mín–Máx |
|---|---|---|---|---|---|---|
| Perfil del Espectro (todos los nodos) | 11,115 | **7.0** | **6** | **10** | 8.19 | 0–41 |
| `fc_puntos` (filtro FC ≥ 3) | 10,543 | 8.0 | 6 | 11 | 8.53 | 3–41 |

El valor normalizado es (7 − 6)/(10 − 6) = **0.250, Débil**. Cae justo en el corte, porque Crítico es < 0.25. Al citar, hay que indicar la población: `fc_puntos` excluye los nodos con FC < 3.

**P3.2 — ✅ Top 10**

| # | Nodo | Sistema | FC | | Macro-Hub (zona) | Sistemas | Estaciones | FC_H |
|---|---|---|---|---|---|---|---|---|
| 1 | Luis Murillo | RTP | 41 | | Calz. Tlalpan – San Fernando / Hospitales (Gea González) | CC, RTP | 21 | 130 |
| 2 | Calz. de Tlalpan - Glorieta Huipulco | RTP | 34 | | Huipulco – Estadio Azteca – Acoxpa | CC, RTP, TL | 61 | 111 |
| 3 | Tlalpan y Luis Murillo | CC | 33 | | Tezoquipa – La Rosa (Tlalpan) | CC, RTP | 10 | 100 |
| 4 | Sobre Calz. De Tlalpan y Luis Murillo | CC | 33 | | Barranca del Muerto – Periférico Sur | CC, RTP | 21 | 92 |
| 5 | Estadio Azteca 2 | RTP | 32 | | Chapultepec (CETRAM) | CC, METRO, RTP, TROLE | 29 | 77 |
| 6 | Sobre Calz. De Tlalpan y Av. Acueducto | CC | 31 | | Plan de San Luis | CC, RTP | 11 | 71 |
| 7 | Tlalpan - Estadio Azteca | CC | 31 | | 5 de Mayo – Autopista México-Cuernavaca | CC, RTP | 14 | 67 |
| 8 | Calz. de Tlalpan - Estadio Azteca | RTP | 31 | | Periférico Ruiz Cortines – Renato Leduc | CC, RTP | 18 | 67 |
| 9 | Tlalpan - Acoxpa | CC | 31 | | Tlalpan e Insurgentes – La Joya | CC, RTP | 6 | 62 |
| 10 | Tezoquipa | RTP | 30 | | Calz. Tlalpan – Ciudad Jardín | CC, RTP, TL | 7 | 60 |

Fuente: `GIS/tableau/exports/geo/fc_puntos.geojson`; `GIS/tableau/connectors/VFTModel/exports/fc_hubs.geojson`, idénticos a los `wdc_fc_*.csv`.

**P3.3 — 🟡 Transbordos entre paradas del mismo sistema**
- El **49.3 % sí corresponde a la corrida vigente**: 10,104 de 20,492 aristas. Su total coincide con el de §7.
- Ningún endpoint ni archivo da el sistema de origen y destino de cada transbordo; el grafo solo guarda "Transbordo Peatonal". El desglose de abajo es *derivado*, aplicando la regla del código: pares a más de 0 y hasta 85 m, más el catálogo del SUB. Reproduce exactamente el total de 10,104.

| Sistema | Aristas dentro del mismo sistema | % del total de transbordos | % de mismo sistema entre los transbordos que tocan el sistema |
|---|---|---|---|
| RTP | 5,214 | 25.44 % | 39.9 % |
| CC | 4,256 | 20.77 % | 33.0 % |
| TROLE | 444 | 2.17 % | 15.3 % |
| MB | 120 | 0.59 % | 13.9 % |
| PUMABUS | 48 | 0.23 % | 92.3 % |
| METRO | 10 | 0.05 % | 1.1 % |
| MEXIBÚS | 10 | 0.05 % | 38.5 % |
| MEXICABLE | 2 | 0.01 % | 50.0 % |
| TL, CBB, SUB | 0 | 0 % | 0 % |

El par intersistema más frecuente es CC↔RTP, con 6,432 aristas.

**P3.4 — ✅ Radio de FC_H: sí, 100 m**
- Fuentes: `VFT/src/api/main.py:163`, `geo_layers.py:224` y el metadato de `fc_hubs.geojson`.
- Matices para el texto:
  1. **No es un radio estricto.** El agrupamiento es transitivo, por componentes conexas de pares a 100 m o menos. Por eso un hub llega a reunir 61 paradas.
  2. **FC usa w = 1.** Cuenta aristas únicas.
  3. **FC individual sí tiene tolerancia espacial.** El código une a un trazo los nodos de grado 0 si están a 25 m en el perfil o a 50 m en `fc_puntos`. El texto dice "sin tolerancia espacial".

**P3.5 — ✅ Fechas de las 3 figuras.** En el repo de cartografía son posteriores a la corrida vigente:
- Mapa: 2026-10-12.
- Gráfica y dashboard: 2026-10-13.

Las copias en `TES/Figures/` son del 2026-09-15 o anteriores, y los pies todavía dicen "Corrida: 2026-04-18".

---

## P4. Factor de Desviación DI — §5.3.4

**P4.1 — ✅ Estadísticos vigentes.** Las tres muestras usan semilla 42 y son anidadas: los primeros 100 pares de la de 200 son la de 100, y así sucesivamente.

| Muestra | n | Media | Mediana | DE | Mín | Máx | P10 | P25 | P75 | P90 | DI < 1 | DI > 2 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Tableau / QGIS (`df_puntos.geojson`, `wdc_df_puntos.csv`) | 100 | **1.701** | 1.54 | 0.566 | 1.03 | 4.42 | 1.23 | 1.34 | 1.90 | 2.338 | 0 | 22 |
| `generate_exports` (`df_distribucion_baseline.csv`) | 200 | 1.682 | 1.52 | 0.604 | 1.00 | 5.33 | 1.21 | 1.33 | 1.845 | 2.321 | 0 | 39 |
| Espectro / perfil (API) | 500 | 1.6675 | **1.52** | 0.553 | 1.00 | 5.33 | 1.21 | 1.34 | 1.8125 | 2.28 | 0 | 87 |

**P4.2 — ✅ Mejor y peor caso con 100 pares**
- **Mejor, empate en 1.03:**
  - Plutarco Elías Calles → Fuente de Loreto - Av. Guelatao, RTP, 1.05 / 1.02 km. Es el mismo par que cita el texto, que lo daba en 0.97.
  - Guadalupe Inclán Ramírez - Periférico → Periférico - Tec de Monterrey, CC.
- **Peor, 4.42:** Av. Sur del Comercio → C. Violeta y Nezahualcóyotl, con 50.94 km de red frente a 11.52 km en línea recta.
- **Carlos A. Vidal** ahora va a Tecolotes, con DI 2.09. Ya no va a 20 de Noviembre.
- **Con 200 o 500 pares:** el mejor caso es Francisco Morazán → Villa de Aragón, con 1.00. El peor es Calz. San Bartolo Naucalpan → Av. Homero y La Martine, con 5.33.

**P4.3 — ✅ Los 12 casos recalculados.** Se usaron las coordenadas de `VFT/notebooks/04_Detaur_factor.ipynb` (celda 11) y el endpoint POST `/get_detour_factor_any_node`, que es de solo lectura. Las distancias en línea recta coinciden con el texto, así que son los mismos puntos.

| # | Caso | Red: antes → ahora (km) | Recta (km) | DI: antes → **vigente** |
|---|---|---|---|---|
| 1 | Milpa Alta → Autódromo | 29.18 → 32.03 | 22.59 | 1.29 → **1.42** |
| 2 | Milpa Alta → Reforma | 37.73 → 40.94 | 27.50 | 1.37 → **1.49** |
| 3 | Milpa Alta → Santa Fe | 36.42 → 41.28 | 28.62 | 1.27 → **1.44** |
| 4 | Milpa Alta → FES Acatlán | 48.34 → 52.40 | 35.73 | 1.35 → **1.47** |
| 5 | Milpa Alta → CU | 26.25 → 29.30 | 19.96 | 1.32 → **1.47** |
| 6 | Milpa Alta → Coyoacán | 25.24 → 28.40 | 18.86 | 1.34 → **1.51** |
| 7 | Santa Catarina → CU | 42.06 → 43.13 | 23.10 | 1.82 → **1.87** |
| 8 | Santa Catarina → FES Acatlán | 45.64 → 47.34 | 32.16 | 1.42 → **1.47** |
| 9 | Milpa Alta → Santa Catarina | 37.22 → 44.30 | 14.79 | 2.52 → **2.99** |
| 10 | Milpa Alta → Ajusco | 29.19 → 33.01 | 20.56 | 1.42 → **1.61** |
| 11 | Ajusco → Preparatoria 1 | 15.91 → 16.96 | 11.16 | 1.43 → **1.52** |
| 12 | Parque Los Olivos → Centro de Tláhuac | 2.20 → 2.21 | 2.08 | 1.06 → **1.06** |

**P4.4 — ✅ Mediana del Espectro.** La de 1.43 → 0.713 viene de la corrida de la mañana del 03-10, anterior al Fix #22. La vigente es **1.52 → 0.6533, Aceptable**, con normalización (2.5 − 1.52)/1.5.

**P4.5 — ✅ Qué corrigió el Fix #22**
- **Antes:** `dist_acumulada` se reiniciaba a 0 en cada vértice que caía dentro del radio de captura de una estación. Por eso 13,761 de 25,020 aristas medían menos que el haversine, y aparecían DI de 0.97 y 0.78.
- **Ahora:** la distancia se acumula sobre todo el trazo. Cada estación se proyecta sobre él y la arista mide `off_a + trazo(ancla_a → ancla_b) + off_b`, que siempre es mayor o igual al haversine (`VFT/src/core/services/graph_builder.py:186-228` y `243-266`; commit `5577273`).
- **Resultado:** 0 aristas por debajo del haversine y DI mínimo de 1.00.
- El "antes" se tomó de las notas y del revisor; no se consultó el código anterior en git.

**P4.6 — 🟡 DI por alcaldía con n.** El dato existe pero no hay un cuadro armado. Está en `df_por_alcaldia.geojson`: 20 demarcaciones con `df_promedio`, `df_stddev` y `n_rutas`, muestra de 100 pares asignados según el origen. Cinco demarcaciones tienen n = 1 o 2 y no tienen desviación estándar.

| Demarcación | n | DI medio | DE |
|---|---|---|---|
| Chimalhuacán | 1 | 3.73 | — |
| Tláhuac | 2 | 3.255 | 1.648 |
| Milpa Alta | 2 | 3.125 | 0.799 |
| Naucalpan | 1 | 2.63 | — |
| Nezahualcóyotl | 1 | 1.98 | — |
| Coyoacán | 6 | 1.837 | 0.514 |
| Iztapalapa | 9 | 1.801 | 0.463 |

Las 13 restantes tienen DI medio entre 1.37 y 1.68.

**P4.7 — ✅ Figuras.** En §5.3.4 hay **4 figuras**, no 5:
- `Mapa_DF`: 10-12 en el repo de cartografía.
- Gráfica y dashboard: 10-13 en el repo de cartografía.
- `NB04_mapa10_caso07.png`: del 06-18, sin versión vigente.

Las copias en la tesis son del 09-15 o anteriores.

---

## P5. Velocidades por sistema, Cuadro 5.3 — §5.3.1

**P5.1 — ✅ Velocidades vigentes.** La velocidad base viene de Apimetro, campo `velocidad_promedio_kmh`. El CF se calcula como CF = 1 + α·β, con β = 0.759.

| Sistema | V base (km/h) | Derecho de vía | α | CF | V efectiva = V/CF | Cuadro 5.3 hoy |
|---|---|---|---|---|---|---|
| Tren Suburbano | 65.0 | exclusivo | 0.0 | 1.000 | 65.0 | 65.0 |
| Metro | 36.0 | exclusivo | 0.0 | 1.000 | 36.0 | 36.0 |
| Tren Ligero | 22.0 | exclusivo | 0.0 | 1.000 | 22.0 | 22.0 |
| Cablebús | 20.0 | exclusivo | 0.0 | 1.000 | **20.0** | 17.4 |
| Mexicable | 20.0 | exclusivo | 0.0 | 1.000 | **20.0** | 17.4 |
| Metrobús | 16.3 | exclusivo | 0.0 | 1.000 | **16.3** | 14.1 |
| Mexibús | 16.3 | confinado | 0.2 | 1.1518 | 14.15 | 14.1 |
| Trolebús, 20 de 21 rutas | 18.0 | compartido | 0.5 | 1.3795 | 13.05 | 13.0 |
| Trolebús L10 elevado | 25.0 | confinado | 0.2 | 1.1518 | **21.70** | no aparece |
| RTP | **11.0** | compartido | 0.5 | 1.3795 | 7.97 | V = 14.0, efectiva 8.0 |
| Corredores Concesionados | 11.0 | compartido | 0.5 | 1.3795 | 7.97 | 8.0 |
| Pumabús | **14.0** | compartido | 0.5 | 1.3795 | **10.15** | V = 11.0, efectiva 8.0 |
| Interurbano | 70.0 | exclusivo | 0.0 | 1.000 | 70.0 | no aparece |

- **Fuentes:** `GIS/tableau/exports/geo/lineas.geojson`, que coincide con `GET :8080/movilidad/mapas/geojsonLinea`; `Apimetro/cmd/pkg/models/SQL/Update_Capacidad_vehicular.sql:107-124`; `VFT/src/core/models/impedance.py:15-28`.
- **Por qué el revisor ve 20 km/h para RTP y 16 para CC.** Son los valores `FALLBACK_VELOCIDAD` (`impedance.py:44,48`). El modelo solo los usa si Apimetro manda un dato vacío o en 0, y Apimetro manda 11. La columna "V modelo" del notebook 01 imprime el fallback, no la velocidad que se usó.
- **Trolebús en conjunto.** No hay archivo de aristas en disco para sacar el promedio por segmento. Una cuenta aproximada, que no es dato, da unos 13.2 km/h.
- **MB y Metro.** Tienen los mismos valores por sistema. El escenario MB agrega 8 rutas MB "confinado" del anillo.

**P5.2 — ✅ Derecho de vía y α:** ver la tabla de P5.1. Si una ruta no trae derecho de vía, se le asigna "mixto" (`impedance.py:27,115`). Los comentarios del código no coinciden con los datos: dicen "confinado: Metrobús" y "mixto: RTP, CC" (#27).

**P5.3 — 🟡 Rangos esperados**
- **Solo hay rangos para 8 sistemas,** en el notebook 01, celda 8: Metro 30–42, MB 13–20, TL 18–26, TROLE 14–22, RTP 10–18, CC 8–14, CBB 16–24 y SUB 55–75. Como fuente solo dicen el nombre del organismo, sin documento ni año.
- **Mexibús, Mexicable y Pumabús** tienen rango solo en la tesis.
- **Lo único con fuente documentada son las velocidades base,** en el campo `fuente` de Apimetro: SEMOVI PIM, Wikipedia, STE, etc.
- **Fuera de rango con los datos vigentes:**
  - RTP: 7.97, frente a 10–18.
  - CC: 7.97, frente a 8–14.
  - Trolebús compartido: 13.05, frente a 14–22.

**P5.4 — ✅ Método**
- **En el modelo,** el tiempo de una arista es `(distancia_segmento_m / v) · CF` (`impedance.py:108-119`).
- **En el cuadro y la figura,** la velocidad efectiva es el **promedio aritmético por segmento** de distancia/tiempo, con filtros de distancia > 5 m (en otra celda > 10 m) y tiempo > 0 (notebook 01, celda 12). No es la mediana.
- En sistemas homogéneos ese promedio da exactamente V/CF.

**P5.5 — ✅ `fig01_impedancia.png` es anterior a las correcciones.** Es del 2026-06-18 y su título interno dice "corrida 2026-04-16". Tampoco coincide con el Cuadro 5.3: muestra MB 16.3, CBB y Mexicable 20.0 y Pumabús 10.1.

---

## P6. Supuestos α y β — §5.4.1

**P6.1 — 🟡 Edición del TomTom Traffic Index**
- El código solo tiene una URL y la etiqueta "Average_congestion_level", sin año (`impedance.py:13-14`).
- El `.bib` (`tomtom2024`, `TES/referencias.bib:261-268`) dice `year = 2024`, con otra URL. No distingue año de datos y año de publicación.
- "Datos 2024, publicados 2025" aparece solo en `VERIFICACION_VFTMODEL.md:276`, sin evidencia.

**P6.2 — 🟡 Métrica y conversión a 0.759.** El código tiene la constante `BETA_SATURACION_CDMX = 0.759` (`impedance.py:15`), sin ninguna conversión. La relación β = 75.9/100 aparece solo en una nota. El revisor señala que la edición vigente reporta minutos por cada 10 km.

**P6.3 — ✅ Los cuatro α**

| Derecho de vía | α | CF | Sistemas en los datos vigentes |
|---|---|---|---|
| Exclusivo | 0.0 | 1.000 | Metro, MB, TL, SUB, Interurbano, CBB, Mexicable |
| Confinado | 0.2 | 1.1518 | Mexibús, TROLE L10, anillo MB (escenario) |
| Compartido | 0.5 | 1.3795 | TROLE, RTP, CC, Pumabús |
| Mixto | 1.0 | 1.759 | ninguno; es solo el valor por defecto |

**P6.4 — ❌ Criterio de apoyo de los α**
- No hay criterio documentado. Solo existen los comentarios de `impedance.py:21-24`.
- La nota `VFT/notebooks/NOTES/impedance.md:170` deja pendiente citar la tabla del Manual de Calles de SEDATU 2019.
- Lo más cercano es la recomendación de `VERIFICACION_VFTMODEL.md:281`: declararlos como "supuestos del autor basados en categorías de SEDATU (2019)".

**P6.5 — ❌ Sensibilidad de T y B(v) ante α y β (#30)**
- No hay resultados. El issue #30 solo está registrado.
- La sensibilidad que existe en `weighted_graph_enrichment.md` trata otro α, el del node score.
- Lo más cercano son las diferencias de T entre escenarios, que no son sensibilidad a α ni a β.

---

## P7. Tiempo de viaje T frente a la ENOE — §5.5.1

**P7.1 — ✅ T vigente. El tiempo de cómputo ❌ no está disponible.**

| Escenario | T (min) | Nodos de la SCC | Aristas de la SCC | Normalizado (banda) |
|---|---|---|---|---|
| Red actual | **113.9087** | **10,610** | 44,377 | 0.6957 (Aceptable) |
| MB | 108.9857 | 10,707 | 44,870 | 0.7475 (Aceptable, a 0.0025 de Idóneo) |
| Metro | 101.921 | 10,707 | 44,861 | 0.8219 (Idóneo) |

- **Fuente:** `/average-travel-time` en los puertos 8000, 8001 y 8002, que coincide con `wdc_t_escalar.csv` y con §7.
- **Tiempo de cómputo:** la API no lo reporta. Los 251.8 s son de la corrida del 09-02.

**P7.2 — ❌ Qué dato de la ENOE es el de 85 min.** La ENOE no está en `referencias.bib`. Ningún archivo dice trimestre, año, tabulado ni si es solo ida. Los 85 min aparecen solo como constantes en el código: `expected_cdmx_approx` en `orchestator.py:55` y `T_REFERENCIA_MIN` en `network_profile.py:26`.

**P7.3 — ❌ Cobertura geográfica del dato ENOE.** Las fuentes locales se contradicen:
- **ZMVM:** `5-5-1-TiempoViaje.tex:16,35`.
- **CDMX:** el Cap. 3 (`3-3-9-*.tex`), la clave `expected_cdmx_approx` del código y los notebooks.

**P7.4 — ✅ Fig. 5.15**
- **La figura existe** (`fig:grafica-t-promedio`). Ningún archivo usa la etiqueta "Promedio observado ENOE".
- **El PDF de la tesis,** del 09-16, dice "Tiempo Promedio Real 108.92" y "Referencia Ideal CDMX 85.00".
- **El PDF del repo,** del 10-13, dice 113.91 y "Referencia CDMX (min)". Su texto todavía dice "referencia ideal".
- **El workbook** conserva el alias "Referencia Ideal CDMX" en `dashboard_viz04_red_vftmodel.twb:1179`.

---

## P8. Intermediación B(v): figura frente a cuadro — §5.5.2

**P8.1 — ✅ Corrida de cada figura.** La figura que vio el revisor viene de la **misma corrida del 09-02** que el cuadro. Su PDF, en `TES/Figures/.../UniGrafica/`, es del 09-11. La re-exportada el 10-13 en el repo de cartografía usa la corrida vigente. La tesis todavía usa la del 09-11.

**P8.2 — ✅ Regla de agregación, reproducida con datos**
- La hoja "Centralidad de Intermediación B(v) — Top 20 Nodos" suma B(v) de todos los nodos que comparten el texto exacto de `nombre`, en todos los sistemas. Pone el nombre en filas, `SUM(betweenness)` en columnas, el sistema en el color y un filtro Top 20 por suma (`dashboard_viz04_red_vftmodel.twb:2844-2923`).
- Con los datos del 09-02 la regla reproduce exactamente los valores del revisor:
  - Tacubaya 0.3216: 3 nodos Metro.
  - Zapata 0.2565: 0.128317 + 0.12815.
  - Chabacano 0.2602: 3 nodos Metro.
- La fuente se limita a los 2,000 nodos con mayor B(v) (`GIS/utils/generate_exports.py:86`).

**P8.3 — ✅ Top 10 por nodo individual, vigente**

| # | Nombre | Sistema | Alcaldía | B(v) |
|---|---|---|---|---|
| 1 | Tacubaya | METRO | Miguel Hidalgo | 0.2232 |
| 2 | Mixcoac | METRO | Benito Juárez | 0.1923 |
| 3 | Hidalgo | METRO | Cuauhtémoc | 0.1515 |
| 4 | Balderas | METRO | Cuauhtémoc | 0.1430 |
| 5 | Lázaro Cárdenas | METRO | Cuauhtémoc | 0.1365 |
| 6 | Zapata (nodo 1) | METRO | Benito Juárez | 0.1357 |
| 7 | Chilpancingo | METRO | Cuauhtémoc | 0.1348 |
| 8 | Zapata (nodo 2) | METRO | Benito Juárez | 0.1346 |
| 9 | Barranca del Muerto | METRO | Álvaro Obregón | 0.1313 |
| 10 | Garibaldi y Lagunilla | METRO | Cuauhtémoc | 0.1303 |

Fuente: `GAR/escenario-base/b_ranking_baseline.csv`. Respecto del cuadro del 09-02, salen Viaducto, Villa de Cortés y Nativitas.

**P8.4 — ✅ Regla, radio y top agregado**
- La regla es la suma por nombre exacto. **No hay radio,** así que junta homónimos lejanos: "Hidalgo" abarca 17.6 km y "Chabacano" incluye una parada RTP a 15.5 km. Las distancias son *derivadas*, calculadas con haversine.
- Top 10 agregado vigente, como lo arma la figura con 2,000 nodos:

| # | Nombre | Suma B(v) | Por sistema |
|---|---|---|---|
| 1 | Tacubaya | 0.3279 | METRO 0.3242, MB 0.0037 |
| 2 | Hidalgo | 0.3265 | METRO 0.2710, TROLE 0.0451, RTP 0.0105 |
| 3 | Mixcoac | 0.2837 | METRO 0.2787, RTP 0.0051 |
| 4 | Zapata | 0.2704 | METRO |
| 5 | Chabacano | 0.2478 | METRO 0.2445, RTP 0.0033 |
| 6 | Barranca del Muerto | 0.2431 | METRO 0.1313, RTP 0.0964, CC 0.0154 |
| 7 | Garibaldi y Lagunilla | 0.2364 | METRO |
| 8 | Balderas | 0.2340 | METRO |
| 9 | Lázaro Cárdenas | 0.1911 | METRO 0.1365, TROLE 0.0546 |
| 10 | Bellas Artes | 0.1812 | METRO 0.1503, MB 0.0171, TROLE 0.0138 |

Con los 10,610 nodos, Hidalgo pasa al primer lugar con 0.3342, así que el límite de 2,000 nodos altera el orden. El Top 10 de los dashboards de Garibelt usa esta misma regla de suma por nombre.

**P8.5 — ✅ Gini de B(v).** El vigente es **0.8007 → 0.1993, Crítico**; antes era 0.7891 → 0.2110. El valor 0.8009 de §6.1 corresponde a una corrida intermedia. Fuentes: `garibelt_perfil_baseline.csv`; recalculado sobre 10,610 nodos; `VFT/src/core/algorithms/composite/normalization.py:26`.

**P8.6 — ✅ Fechas.** En el repo de cartografía, las figuras por nodo, por sistema y el dashboard son del 10-13. En la tesis son del 09-11 al 09-15. El mapa QGIS tiene un metadato de creación que no refleja la exportación real.

---

## P9. Vulnerabilidad ΔE y E₀ — §5.5.3

**P9.1 — ❌ Eficiencia de Latora-Marchiori**
- No existe: no hay `global_efficiency` ni ningún promedio de 1/d_ij en `src/`, en los tests ni en los notebooks.
- T es el promedio de d_ij (`average_shortest_path_length`).
- **Lo más cercano:** E₀ = 1/T = 1/113.9087 = **0.008779 min⁻¹**. Antes era 1/108.92 = 0.009181.

**P9.2 — ❌ Remoción del macro-hub.** No hay código ni corrida que lo haga. La agrupación de 100 m que existe es la de FC_H, que agrupa estaciones pero no las elimina. El hub de Tacubaya en FC_H tiene 15 estaciones de 4 sistemas.

**P9.3 — 🟡 Pares desconectados.** Solo hay dato para la corrida del 09-02:
- En el notebook 05, celda 16, "Nodos Perdidos" vale 1 para los 5 nodos, y ese 1 es el propio nodo removido. Eso implica 0 pares desconectados adicionales.
- El método recalcula sobre la nueva SCC, así que **excluye** los pares desconectados en lugar de contarlos como infinito. Es la limitación que señala M11.
- No hay dato para la corrida vigente.

**P9.4 — ❌ T_f y ΔE vigentes.** No existen. Valores de la corrida del 09-02:

| Nodo | T_f (min) | ΔE con T₀ = 108.92 |
|---|---|---|
| Tacubaya | 111.80 | 2.58 % |
| Mixcoac | 110.19 | 1.15 % |
| Hidalgo | 109.90 | 0.89 % |
| Balderas | 109.56 | 0.58 % (la tesis pone 109.57 y 0.59 %) |
| Lázaro Cárdenas | 110.13 | 1.10 % |

Lo más cercano vigente es E₀ = 1/113.9087, junto con el B(v) vigente de esos nodos que aparece en P8.3.

**P9.5 — ✅ Issue VFTModel #5.**
- Está **abierto**, con las etiquetas `enhancement` y `fase-4`.
- Su comentario lista los requisitos del revisor: macro-hub de 100 m, pares desconectados, Latora-Marchiori y ΔE frente a B(v).
- CHECK-6 sigue bloqueado.

---

## P10. Espectro MJG — §5.6.2

**P10.1 — ✅ Valores vigentes**

| Dimensión | Red actual: bruto → normalizado (banda) | MB | Metro | Texto de la tesis hoy |
|---|---|---|---|---|
| C (141) | 4.4138 % → 0.0552 (Crítico) | 4.4596 % → 0.0557 (Crítico) | 4.4596 % → 0.0557 (Crítico) | 4.4 % / 0.055 ✅ |
| C (ZMVM 76) | 13.287 % → 0.1661 (Crítico) | 13.426 % → 0.1678 (Crítico) | 13.426 % → 0.1678 (Crítico) | no aparece |
| Cᵢ | 7.0 (Q1 6, Q3 10) → 0.25 (Débil) | igual | igual | 0.250 ✅ |
| DI | 1.52 → 0.6533 (Aceptable) | 1.51 → 0.66 (Aceptable) | 1.58 → 0.6133 (Aceptable) | 0.713 ❌ |
| T | 113.9087 → 0.6957 (Aceptable) | 108.9857 → 0.7475 (Aceptable) | 101.921 → 0.8219 (**Idóneo**) | 0.748 ❌ |
| B(v) | Gini 0.8007 → 0.1993 (Crítico) | 0.8012 → 0.1988 (Crítico) | 0.8134 → 0.1866 (Crítico) | 0.211 ❌ |

- **Las bandas de la red actual no cambian.** Ninguna dimensión alcanza Idóneo.
- **MB perdió el Idóneo en T** que tenía en el análisis preliminar de septiembre. Metro lo conserva.
- **La línea 138 de la tesis tiene dos errores.** Los 125 municipios son todos del Estado de México, no de "México, Hidalgo, Puebla y Tlaxcala". Además, 141 demarcaciones no son la ZMVM.
- **El Idóneo de T que se reportó el 03-10** venía de la corrida con el error de distancias del Fix #22 y quedó revertido. No era error de normalización: ver `RESULTADOS_RECORRIDA.md` §1 y §6.

**P10.2 — ✅ La normalización no cambió.** Las constantes se crearon el 2026-09-18 y no se han modificado. El #26 solo agregó el dominio 76 con la misma fórmula.

| Elemento | Fórmula | Código |
|---|---|---|
| Bandas | < 0.25 Crítico · < 0.50 Débil · < 0.75 Aceptable · ≥ 0.75 Idóneo | `normalization.py:48-55` |
| C | media ponderada por área, normalizada entre 0 y 80 % | `network_profile.py:138-146` |
| Cᵢ | (mediana − Q1)/(Q3 − Q1) del propio conjunto | `network_profile.py:162-167` |
| DI | (2.5 − mediana)/1.5 | `network_profile.py:183-186` |
| T | (180 − T)/95, es decir, 85 = 1 y 180 = 0 | `network_profile.py:201-205` |
| B(v) | 1 − Gini | `network_profile.py:224-228` |

- El techo de **180 min** es "definido empíricamente" según el código (`network_profile.py:27`). La tesis lo atribuye a la ENOE (`3-3-9-2-Instrumento.tex:59-61`).
- **La ENOE no aparece en el código fuente;** solo en los notebooks 05 y 06.

**P10.3 — ✅ Figuras del Espectro**

| Figura | Repo de cartografía | Copia en la tesis |
|---|---|---|
| Dashboard_Espectro_Red_Actual | **09-23, sin re-exportar** (Gini 0.7891, DI 1.43, T 108.9) | 09-23 |
| Dashboard_KPI, _Clasificacion y _Betweenness (Red Actual) | 10-14 | 09-23 |
| Mapas QGIS Clasificacion_Garibelt: Cobertura, Fuerza Capilar y Betweenness | 10-11 | 09-24 |

Los pies de figura de la tesis todavía dicen "Corrida: 2026-09-02", "2026-09-24" y "2026-04-18".

---

## 11. Figuras por regenerar: archivo, corrida y valores visibles

| § | Figura | Versión vigente en GIS | Copia en TES | Valores clave vigentes |
|---|---|---|---|---|
| 5.3.1 | `fig01_impedancia.png` | ❌ no existe | 06-18 (corrida 04-16) | velocidades de P5.1 |
| 5.3.2 | Cobertura alcaldía / sistema (Tableau) | 10-13 | 09-15 | C(141) 4.41 %; C sin cambio |
| 5.3.2 | Mapa_Cobertura_Red_Total / _Mapa_Calor (QGIS) | 09-14 (anterior al 10-05) | 09-15 | dominio 141 |
| 5.3.3 | FC: gráfica, mapa y dashboard | 10-12 / 10-13 | 09-15 | mediana 7; top Luis Murillo 41; hub 130 |
| 5.3.4 | DI: Mapa_DF, gráfica y dashboard | 10-12 / 10-13 | 09-15 | media 1.701; máx. 4.42 |
| 5.3.4 | `NB04_mapa10_caso07.png` | ❌ no existe | 06-18 | caso 7: 43.13 km, DI 1.87 |
| 5.5.1 | Fig. 5.15, T promedio | 10-13 | 09-16 | 113.91 frente a 85 |
| 5.5.2 | B(v): nodos, sistema y dashboard | 10-13 | 09-11 / 09-15 | Tacubaya 0.3242 (suma por nombre) |
| 5.6 | Dashboard Espectro | ❌ falta re-exportar | 09-23 | P10.1 |
| 5.6 | KPI, Clasificación y Betweenness Garibelt | 10-14 | 09-23 | P10.1 y P8 |
| 5.6 | Mapas Garibelt (QGIS) | 10-11 | 09-24 | P10.1 |

Para el #30: G1 sin Interurbano, G2 con la etiqueta de la ENOE (ver P7.4) y G3 con la leyenda "isócronas" (ver P2.5) siguen pendientes. El texto "isócronas" sigue vivo en `garibelt_red_actual.qgz`.

---

## 12. Otras notas: VERIFICACION_VFTMODEL, CHECK0 y Seminario

### VERIFICACION_VFTMODEL.md

| CHECK | Estado | Respuesta |
|---|---|---|
| 1. α de Cablebús | ✅ código / ❌ tesis | Llega exclusivo, con α 0 y CF 1.000. La tesis todavía dice "Confinado 1.152" (`5-2:82`, `5-4-1:38`), también para Mexicable. |
| 2. Normalización de B(v) | ✅ | `betweenness_centrality(normalized=True)`, Brandes exacto sin muestreo. Máximo vigente: 0.223204. |
| 3. Figura frente a cuadro | 🟡 | Resuelto en el repo; la tesis sigue con la figura del 09-11. Ver P8. |
| 4. DI < 1 | ✅ | El reinicio de `dist_acumulada` se eliminó. 0 pares con DI < 1. El test aún acepta DI ≥ 0.95. |
| 5. Velocidad libre | ✅ dato / ❌ cuadro | Ver P5. Los fallbacks de 20 y 16 km/h no se aplican. |
| 6. ΔE y desconectados | ❌ | Ver P9. |
| 7. 141 frente a 76 | 🟡 | La API da los dos dominios. Las exportaciones en disco siguen con 141 filas. |
| 8. Tren Suburbano | ✅ | 6 trips y 7 stops en el GTFS; 12 aristas; 7/7 en la gigante. |
| 9. β TomTom | 📝 | Ver P6. |
| 10. Porcentaje modal | 🟡 | 7.28 % con la lista del texto; ver P1.3. |
| 11. Espectro | 🟡 | La tabla de la tesis tiene valores obsoletos. Ver P10. |

### CHECK0_DIAGNOSTICO_DATOS.md

| Ítem | Estado | Respuesta |
|---|---|---|
| T-01 Cablebús confinado con CF 1.0 | ✅ dato / ❌ tesis | `3-3-6-Friccion-Vial.tex:23` llama "confinados" a sistemas con CF 1.0; en el código, "confinado" significa α = 0.2. |
| T-02 MB 14.1 frente a 16.3 | ✅ dato / ❌ tesis | La efectiva es 16.3; el cuadro dice 14.1. |
| T-03 Caso 3, 22 frente a 16.3 km/h | ✅ texto | Ver los hallazgos de los anillos más abajo. |
| V-01 Interurbano a 160 km/h | ✅ | Va a 70 km/h. Tiene 0 de 5 nodos en la gigante, así que no entra en T ni en B(v). |
| V-02 TROLE elevado | ✅ | L10 es confinado, a 25 km/h, con 29 aristas. |
| V-03 SUB con 3 aristas | ✅ | Ahora tiene 12. |
| ACHECK-01 a 04 | ✅ | Corregidos. Siguen tramos de un solo sentido en Interurbano, Mexicable y CBB L3 (N-1, N-2, Apimetro#71). |

**Hallazgos nuevos sobre los anillos de los escenarios.** Salen de `:8083` y `:8084`, `geojsonLinea` y `geojsonEstacion`:
- **El Anillo MB es "confinado".** Usa 16.3 km/h con CF 1.152, así que su velocidad efectiva es de unos 14.15 km/h. Su frecuencia es de 5 min.
- **El Anillo Metro corre a 36 km/h,** exclusivo, con frecuencia de 3 min. El Cap. 3 dice 35 km/h.
- **Los dos anillos comparten las mismas 94 estaciones,** con coordenadas idénticas. La diferencia de paradas cada 600 m frente a cada 1,200 m que describe el Cap. 3 **no está implementada**.

### Notas de seminario

**Cap. 5: observaciones que ya tienen una P**

| Observación | P |
|---|---|
| M1 | P0 y P1.4 |
| C2, C6 | P1 |
| C3 | P1.2 |
| C4 | P5 |
| M4 | P2 |
| F3 | P2.5 |
| M6 | P3 |
| R2 (transbordos del mismo sistema) | P3.3 |
| M7 | P4 |
| M8 | P4.3 |
| M9 | P4.6 |
| M10 | P6 |
| M11 | P7 |
| F5 | P7.4 |
| C8 | P8 |
| M13 | P9 |
| C9 | P10 |

**Cap. 5 sin P asociada**
- **C1, estado de E.** ❌ ΔE no está implementado; "Calculado" no es correcto.
- **M3, buffer frente a isócrona.** ✅ El código usa un buffer circular de 800 m, no isócronas por red (`VFT/src/core/algorithms/spatial/spatial_coverage.py:61,91`).
- **M5, cobertura poblacional.** ❌ No existe. La capa de manzanas no tiene campos de población. Lo más cercano es la C por área.
- **C5, Interurbano.** ✅ Sí está en el grafo, con 5 nodos y 4 aristas, pero ninguno en la gigante. El grafo tiene 12 sistemas.
- **M12.** ✅ Ver CHECK-2.
- **No son de datos:** R1, M2 y R2 en la parte de headway. 📝

**Cap. 3**
- **C5, número de sistemas.** ❌ El texto dice "once"; los datos tienen 12.
- **C3, CETRAM en el top 10 de B(v).** ✅ Ninguno está. Tacubaya, el #1, no figura en la lista de CETRAM del texto. Fuente: `GAR/comparativo/bv_comparativo.csv`.

| CETRAM | Mejor nodo | B(v) | Lugar |
|---|---|---|---|
| Pantitlán | Metro | 0.0555 | #100 |
| Tasqueña | CC (CETRAM) | 0.0323 | #198 |
| Indios Verdes | MB | 0.0163 | #351 |
| Cuatro Caminos | CC | 0.0049 | #1,271 |

- **M8, T y −24 %.** ✅ MB −4.92 min (−4.3 %) y Metro −11.99 min (−10.5 %), frente al −24 % de la Tabla 3.5.
- **M9, Tabla 3.8.** ✅ No está calculada. Pantitlán tiene 0.0555 (#100) y Pino Suárez 0.0851 (#41).
- **M10, ΔE = 36 % en Pantitlán.** ❌ Nunca se calculó. El rango real del 09-02 fue de 0.58 % a 2.58 %.
- **M11, E = 1/T.** ❌ Ver P9. Latora-Marchiori no está en el `.bib`.
- **C8, calibración con la Google API.** ✅ No hay código que la use. La espera es `FALLBACK_FRECUENCIA/2` e ignora `frecuencia_minutos` de Apimetro (Issue #32; `graph_builder.py:37-40,311-312`).
- **M2, Cᵢ por percentiles.** 🟡 El código lo confirma: 0.25 queda justo en el corte. No hay referencia externa.
- **M7, cortes 0.25 / 0.50 / 0.75.** ❌ No hay sensibilidad (#30). Márgenes vigentes:
  - Cᵢ está en el corte exacto.
  - T de la red actual está a 0.054 de Idóneo.
  - T de MB está a 0.0025 de Idóneo.
- **M6, Gini alto por construcción.** ✅ La premisa no se cumple: solo 696 de 10,610 nodos (6.6 %) tienen B = 0. La mediana es 0.000616.
- **C9, Cap. 6.** 📝 Tiene unas 256 palabras. Los datos comparativos ya existen.
- **C2, número de indicadores.** 📝 El perfil tiene 5 dimensiones.
- **R1, R2, C1, F1–F3, M13 y M12.** 📝 Redacción o bibliografía.

---

## 13. Discrepancias entre notas y datos

1. `RESULTADOS_RECORRIDA.md` §1 y `VERIFICACION_VFTMODEL.md` §C atribuyen 45,679 aristas a la corrida del 09-02. Esa corrida tuvo 45,497; las 45,679 son de la del 04-18.
2. `VERIFICACION_VFTMODEL.md` CHECK-3 dice que la figura de B(v) es de "otra corrida". Es la misma corrida, agregada por nombre.
3. `RESULTADOS_RECORRIDA.md` §6.1 trae el Gini 0.8009 de la corrida intermedia. El vigente es 0.8007.
4. `RESULTADOS_RECORRIDA.md` §8.3 dice que los CSV en disco son anteriores a los fixes. Las exportaciones del 10-05 ya traen los valores de §7.
5. `RESULTADOS_RECORRIDA.md` §9 dice "42 de los 76 municipios" con 0 %. Son 42 de 60 municipios.
6. `ESTADO_RECURSOS.md` §4 dice "101 de 141 con 0 %". La red actual tiene 102 y MB y Metro tienen 101.
7. `ESTADO_RECURSOS.md` da como corregido el texto de cobertura de Red Actual en QGIS, pero `garibelt_red_actual.qgz` conserva "ZMVM 141", "isócronas" y "0.055".
8. `ANALISIS_PRELIMINAR.md` y `SUPOSICIONES_ANALITICAS.md` siguen con los valores de septiembre: T 0.748 y MB/Metro en Idóneo.
9. Hay muestras distintas de DI: el texto usa 100 pares, `df_distribucion` 200 y el Espectro 500.
10. Las 5,552 aristas de servicio reemplazadas por transbordos no aparecen en ninguna nota. Es un hallazgo derivado.
11. Los comentarios de `impedance.py` sobre derecho de vía no coinciden con los datos de Apimetro (#27).
12. "Top 20 Nodos" en la figura de B(v) no son nodos: es la suma por nombre, limitada a 2,000 nodos.
