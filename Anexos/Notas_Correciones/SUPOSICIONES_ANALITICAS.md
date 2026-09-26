# Suposiciones Analíticas — Clasificación Garibelt ZMVM
## Segunda Lectura Preliminar
**Fecha:** 2026-09-24 | **Estado:** Preliminar — requiere verificación con literatura y datos externos

---

## Contexto metodológico

Las siguientes 7 suposiciones se derivan del análisis computacional de los 5 indicadores
Garibelt sobre 3 escenarios topológicos (Baseline 2025, MB/BRT hipotético, METRO hipotético).
Son hipótesis de trabajo orientadas al desarrollo de la tesis — **no son conclusiones**.
Cada suposición tiene una sección de verificación pendiente marcada con `[VERIFICAR]`.

Datos base de referencia: ver `ANALISIS_PRELIMINAR.md` en esta misma carpeta.

---

## S1 — Nodos aceptable como esqueleto de transferencia informal (Cᵢ · Baseline)

**Suposición:**
Los ~95 nodos en banda aceptable (fc_total 21–41) son los CETRAMs existentes o nodos
de transferencia informal que operan como tal sin infraestructura formal. Su distribución
geográfica delimita el "esqueleto de transferencia real" de la red al 2025.

**Base de datos:**
- `fc_puntos_garibelt.geojson` — campo `fc_banda = 'aceptable'` (~95 nodos)
- Distribución: crítico=84.9%, débil=14.1%, aceptable=0.9%, idóneo=0.0%

**Implicación para la tesis:**
Si los nodos aceptable coinciden con CETRAMs formales → confirma que el modelo
captura la infraestructura de transferencia real. Si hay nodos aceptable sin CETRAM
asignado → evidencia de equipamiento informal no reconocido institucionalmente.

**[VERIFICAR — ver sección Tareas para Agente]**

---

## S2 — Vulnerabilidad estructural por red monocapilar (Cᵢ · Baseline)

**Suposición:**
Una red donde 84.9% de nodos es monocapilar (fc≤7) produce zonas de vulnerabilidad
territorial donde la falla de una sola línea incomunica completamente un área.
Las zonas de máximo riesgo son aquellas donde en un radio de 5km no existe ningún
nodo en banda aceptable o idóneo.

**Base de datos:**
- `fc_puntos_garibelt.geojson` — distribución espacial de bandas
- Mapa QGIS: capa `fc_puntos_garibelt`, puntos críticos = masa oscura en periferia

**Zonas de riesgo supuestas (pendiente confirmación espacial):**
- Municipios EdoMex frontera norte (Tlalnepantla, Ecatepec)
- Corredor oriente CDMX (Iztapalapa exterior)
- Periférico sur-poniente (antes del anillo)

**Implicación para la tesis:**
Argumento para incluir la prueba de robustez (backlog VFTModel) como siguiente fase
de investigación. Los datos actuales permiten identificar zonas probables.

**[VERIFICAR — ver sección Tareas para Agente]**

---

## S3 — Candidatos CETRAM de siguiente generación (B(v) · Escenario METRO)

**Suposición:**
Los tres nuevos nodos top-5 de B(v) en el escenario METRO acumulan intermediación
topológica alta sin infraestructura de transferencia planificada. Son los candidatos
CETRAM naturales de la siguiente generación de la red.

**Nodos candidatos:**
| Nodo | B(v) METRO | Rango | B(v) Baseline |
|---|---|---|---|
| Periférico Oriente/Tláhuac | 0.145 | #2 | No top-5 |
| Rómulo O'Farril | 0.122 | #4 | No top-5 |
| Luis Cabrera | 0.121 | #5 | No top-5 |

**Implicación para la tesis:**
Si ninguno está contemplado como CETRAM en PDUs → evidencia de brecha de
planificación entre la expansión topológica hipotética y la infraestructura real.

**[VERIFICAR — ver sección Tareas para Agente]**

---

## S4 — El beneficio temporal del anillo es geográficamente selectivo (T · MB vs METRO)

**Suposición:**
La mejora de T en METRO (−10.8 min, −9.9%) sin cambio en C ni Cᵢ indica que
el beneficio temporal del anillo es geográficamente selectivo: solo los viajes
con origen-destino en la corona periférica se benefician. Los viajes internos
al núcleo central no mejoran porque el anillo no atraviesa ese espacio.

**Base de datos:**
- `df_distribucion_baseline/mb/metro.csv` — pares O-D con tiempos
- Datos de referencia: T baseline=108.92, MB=104.74, METRO=98.12

**Implicación para la tesis:**
El anillo periférico no es una solución universal de movilidad — es una solución
territorial específica para la corona metropolitana. Su implementación debe ir
acompañada de medidas para el núcleo si el objetivo es mejorar la red globalmente.

**[VERIFICAR]** Segmentar la muestra de 200 pares O-D por zona geográfica
(núcleo vs. corona) y comparar mejoras diferenciales entre escenarios.
No requiere datos externos, solo análisis adicional sobre CSVs existentes.

---

## S5 — DI y T miden dimensiones ortogonales de eficiencia (DI · Escenario METRO)

**Suposición:**
El retroceso del DI en METRO (rutas eficientes DI<1.3: 30.5%→24.5%) coexiste
con la mayor mejora de T (−10.8 min). Esto sugiere que DI y T miden dimensiones
ortogonales: DI mide desviación geométrica, T mide tiempo absoluto.
El anillo genera rutas "largas pero rápidas" — ineficientes geométricamente
pero superiores temporalmente.

**Base de datos:**
| Categoría DI | Baseline | MB | METRO |
|---|---|---|---|
| eficiente (DI<1.3) | 30.5% | 31.0% | 24.5% |
| alto (DI>2.0) | 22.5% | 24.5% | 29.0% |
| DI máximo | 4.32 | 4.44 | 5.20 |

**Implicación para la tesis:**
Si se confirma la ortogonalidad DI-T, el indicador Garibelt necesita un índice
compuesto que pondere ambos. Una ruta que tarda menos pero rodea más puede ser
preferible operacionalmente, especialmente en redes de alta velocidad.

**[VERIFICAR]** Correlación Pearson entre `factor_desviacion` y tiempo_viaje
estimado por par O-D en escenario METRO. Requiere análisis adicional sobre
`df_distribucion_metro.csv`.

---

## S6 — El anillo no resuelve la última milla (C · Todos los escenarios)

**Suposición:**
La Accesibilidad C permanece crítica en los 3 escenarios (C≈0.055–0.056).
Ningún modo troncal mejora la cobertura territorial porque el problema no
es la línea troncal sino la red capilar de acceso. Mejorar C requiere política
de última milla (microbús, ciclovía, feeder BRT), no infraestructura troncal.

**Base de datos:**
- `cobertura_alcaldias_baseline/mb/metro.csv` — 141 demarcaciones
- 102 de 141 demarcaciones (72%) con cobertura=0% en todos los escenarios

**Implicación para la tesis:**
Argumento central: el anillo periférico es condición necesaria pero no suficiente
para mejorar la accesibilidad territorial de la ZMVM. Se requiere una red
alimentadora densa que conecte las estaciones del anillo con los barrios adyacentes.

**[VERIFICAR — ver sección Tareas para Agente]**
Ciudades de referencia: Bogotá (TransMilenio + alimentadores), Seoul (Ring lines).

---

## S7 — Redistribución ≠ eliminación de concentración (B(v) · Escenario METRO)

**Suposición:**
El Gini de B(v) sube ligeramente en METRO (0.789→0.798) mientras Tacubaya cae
−28.5%. La concentración topológica no desaparece — se traslada a nodos
periféricos con menor infraestructura de soporte. El anillo crea nueva
vulnerabilidad periférica al tiempo que descomprime el centro.

**Base de datos:**
| Escenario | Gini B(v) | Tacubaya B(v) |
|---|---|---|
| Baseline | 0.7891 | 0.2179 |
| MB | 0.7885 | 0.2131 |
| METRO | 0.7977 | 0.1557 |

**Implicación para la tesis:**
La desconcentración topológica del centro genera nueva concentración periférica.
Los nuevos nodos críticos del anillo (S3) tienen menor equipamiento y menor
capacidad de absorción de demanda que los nodos históricos del centro.
Esto es coherente con la teoría del transporte anillar: el anillo redistribuye,
no elimina, la necesidad de nodos de transferencia.

**[VERIFICAR — ver sección Tareas para Agente]**

---

## Resumen orientador

| # | Indicador | Escenario | Argumento central |
|---|---|---|---|
| S1 | Cᵢ | Baseline | Esqueleto de transferencia informal no documentado |
| S2 | Cᵢ | Baseline | Vulnerabilidad territorial por monocapilaridad |
| S3 | B(v) | METRO | CETRAMs de siguiente generación en periferia |
| S4 | T | MB vs METRO | Beneficio geográficamente selectivo |
| S5 | DI + T | METRO | Eficiencia geométrica vs. temporal como dimensiones ortogonales |
| S6 | C | Todos | Troncal no resuelve última milla |
| S7 | B(v) | METRO | Redistribución de concentración, no eliminación |

---

---

# SECCIÓN PARA AGENTE DE VERIFICACIÓN

> Esta sección está dirigida a un agente de investigación bibliográfica y datos.
> Las tareas siguientes no requieren modificar código — son búsquedas de datos
> y literatura para respaldar o refutar las suposiciones S1, S2, S3, S6 y S7.

---

## TAREA A — Catálogo de CETRAMs (para S1 y S3)

**Objetivo:** Obtener una lista georreferenciada de los CETRAMs existentes en CDMX
y, si existe, de los municipios del Estado de México.

**Preguntas a responder:**
1. ¿Cuántos CETRAMs existen en CDMX? ¿Cuántos en EdoMex?
2. ¿Están georreferenciados (coordenadas o polígono)?
3. ¿Alguno de estos 3 nodos coincide con un CETRAM existente o planificado?
   - Periférico Oriente / Tláhuac (zona sur-oriente CDMX)
   - Rómulo O'Farril (zona sur-poniente, Álvaro Obregón/Magdalena Contreras)
   - Luis Cabrera (zona sur, Tlalpan)
4. ¿Existe algún plan o proyecto de CETRAM en esas ubicaciones en PDUs vigentes?

**Fuentes sugeridas:**
- SEMOVI CDMX — catálogo de infraestructura de transporte
- Portal de datos abiertos CDMX (datos.cdmx.gob.mx)
- Programa de Desarrollo Urbano de las alcaldías correspondientes
- Plan de Movilidad ZMVM / COMETRAVI

---

## TAREA B — Literatura sobre redes anillares y redistribución de centralidad (para S7)

**Objetivo:** Encontrar 2–3 referencias académicas que respalden o refuten la suposición
de que los anillos de transporte redistribuyen (no eliminan) la concentración topológica.

**Hipótesis a buscar en literatura:**
- Anillos periféricos de transporte como redistribuidores de intermediación (B(v))
- Casos de estudio: ¿en qué ciudades el anillo redujo la B(v) del nodo central?
- ¿Se documenta el surgimiento de nuevos nodos críticos en la periferia tras implementar un anillo?

**Autores/obras de referencia conocidas:**
- Jean-Paul Rodrigue — *The Geography of Transport Systems*
- David Levinson — redes de transporte y centralidad
- Karst Geurs / Bert van Wee — accesibilidad territorial

**Formato esperado de respuesta:**
Lista de referencias con: autor, año, título, revista/editorial, doi o URL,
y una línea de cómo soporta o refuta S7.

---

## TAREA C — Literatura sobre última milla y redes troncales (para S6)

**Objetivo:** Encontrar 2–3 referencias que documenten que la implementación de
infraestructura troncal sin red alimentadora no mejora la accesibilidad territorial.

**Casos de referencia para buscar:**
- Bogotá TransMilenio: impacto en accesibilidad con y sin alimentadores
- Seoul Metro Ring: integración tarifaria y red alimentadora
- Ciudad de México Metrobús: estudios de cobertura antes/después de implementación

**Formato esperado de respuesta:**
Igual que TAREA B: lista de referencias con línea de aplicabilidad.

---

## TAREA D — Datos de robustez y vulnerabilidad de red (para S2)

**Objetivo:** Buscar metodologías y datos comparativos para contextualizar
la vulnerabilidad de una red donde 84.9% de nodos es monocapilar.

**Preguntas a responder:**
1. ¿Existe algún índice estándar de robustez de red de transporte en la literatura?
   (más allá de la eliminación secuencial de nodos)
2. ¿Hay estudios de robustez de la red de transporte de CDMX publicados?
3. ¿Qué porcentaje de nodos monocapilares es considerado "red frágil" en la literatura?

**Formato esperado de respuesta:**
Igual que TAREA B.

---

*Generado por análisis computacional VFTModel v1 + Apimetro GTFS-CDMX.*
*Escenarios MB y METRO son hipotéticos, sin validación operacional ni encuesta O-D.*
*Fecha: 2026-09-24*
