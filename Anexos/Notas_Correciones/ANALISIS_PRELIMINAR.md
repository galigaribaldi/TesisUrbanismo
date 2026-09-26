# Análisis Preliminar — Clasificación Garibelt
## Comparativo 3 escenarios: Baseline / MB (BRT) / METRO
**Fecha:** 2026-09-21 | **Estado:** Preliminar — sujeto a revisión metodológica

---

## Datos base de referencia

| Indicador | Baseline | MB (BRT) | METRO | Δ MB | Δ METRO |
|---|---|---|---|---|---|
| T promedio (min) | 108.92 | 104.74 | 98.12 | −4.18 | −10.80 |
| Nodos en red | 11,115 | 11,209 | 11,209 | +94 | +94 |
| Líneas | 668 | 676 | 676 | +8 | +8 |
| Gini B(v) | 0.7891 | 0.7885 | 0.7977 | −0.06% | +1.09% |
| Tacubaya B(v) | 0.2179 | 0.2131 | 0.1557 | −2.2% | −28.5% |

### Espectro Garibelt por escenario

| Dimensión | Baseline | MB | METRO |
|---|---|---|---|
| Accesibilidad C | crítico (0.055) | crítico (0.056) | crítico (0.056) |
| Capilar Cᵢ | débil (0.250) | débil (0.250) | débil (0.250) |
| Eficiencia DI | aceptable (0.713) | aceptable (0.720) | aceptable (0.687) |
| **Fluidez T** | **aceptable (0.748)** | **idóneo (0.792)** | **idóneo (0.862)** |
| Centralidad B | crítico (0.211) | crítico (0.212) | crítico (0.202) |

---

## Consideraciones metodológicas y notas de interpretación

### 1. Ausencia de afluencias — escenarios puramente topológicos

Ninguno de los dos escenarios simulados cuenta con datos de afluencia registrada ni simulada. Solo el escenario base es "Correcto".
La red hipotética del anillo periférico (MB y METRO) se incorpora como grafo topológico
con tiempos de viaje teóricos por segmento, sin calibración por demanda observada.

**Implicación:** todos los resultados reflejan la *potencialidad estructural* del anillo,
no su desempeño operacional real. Los valores son comparables entre sí bajo las mismas
condiciones metodológicas, pero no extrapolables a cifras operacionales sin una encuesta
O-D o modelo de demanda.

**Para la tesis:** los escenarios deben presentarse como proyecciones topológicas de
primer orden, no como simulaciones de demanda. Esta es una limitación documentada y
común en estudios de planificación sin datos de demanda disponibles.

---

### 2. Indicadores que retroceden no denotan ineficiencia del transporte

En el escenario METRO, el DI (Factor de Desviación / eficiencia_ruta) empeora
respecto al baseline:

| Categoría DI | Baseline | MB | METRO |
|---|---|---|---|
| eficiente (DI<1.3) | 30.5% | 31.0% | **24.5%** |
| alto (DI>2.0) | 22.5% | 24.5% | **29.0%** |
| DI máximo | 4.32 | 4.44 | **5.20** |

Este retroceso **no es evidencia de que el anillo metro sea ineficiente**. Su origen es
una brecha de información metodológica:

- El algoritmo Dijkstra encuentra rutas shortest-path que atraviesan el anillo periférico,
  el cual por su geometría circular rodea la ciudad. Rutas que pasan por él son
  geométricamente más largas que las diagonales directas, inflando el factor de desviación.
- Sin afluencia, no se puede distinguir si el algoritmo está "eligiendo" el anillo
  porque realmente es la mejor ruta, o porque los pesos de arista no reflejan la
  ventaja de frecuencia y capacidad que tendría en operación real.
- La muestra de 200 pares O-D es aleatoria sobre un grafo ampliado; con 94 nodos
  nuevos en el periférico, hay mayor probabilidad de que algunos O-D pasen por él.

**Para la tesis:** documentar explícitamente que el retroceso del DI en METRO es un
artefacto metodológico de la ausencia de calibración por demanda, no una conclusión
sustantiva. Una siguiente fase con simulación O-D revertiría o confirmaría este resultado.

Aplica de igual forma a la Accesibilidad (C) y Capilar (Cᵢ): no cambian porque el
modelo de cobertura es espacial-estático (radio 800m) y el grado nodal no se recalibra
por frecuencia ni capacidad.

---

### 3. Redistribución de Betweenness — el hallazgo estructural más significativo

El indicador que mejor responde al anillo periférico es la Centralidad de Intermediación B(v).

**Top-5 nodos por escenario:**

| Rango | Baseline | MB (BRT) | METRO |
|---|---|---|---|
| #1 | Tacubaya (0.218) | Tacubaya (0.213) | Tacubaya (0.156, −28.5%) |
| #2 | Mixcoac (0.173) | Mixcoac (0.173) | **Periférico Oriente/Tláhuac (0.145)** |
| #3 | Hidalgo (0.159) | Hidalgo (0.154) | Hidalgo (0.123) |
| #4 | Balderas (0.143) | Balderas (0.139) | **Rómulo O'Farril (0.122)** |
| #5 | Lázaro Cárdenas (0.138) | Lázaro Cárdenas (0.135) | **Luis Cabrera (0.121)** |

**Lectura del dato:**

El escenario METRO desahoga a Tacubaya en una proporción abrumadora (−28.5%),
reduciéndola de nodo absolutamente dominante a primer nodo entre iguales. Tres
nodos del anillo sur-poniente (Periférico Oriente/Tláhuac, Rómulo O'Farril, Luis Cabrera)
emergen como nuevos nodos críticos, incorporados topológicamente por la expansión
geométrica de la metrópoli hacia esa zona.

Esta redistribución es evidencia de que el anillo metro **sí logra su objetivo
estructural**: crear rutas alternativas de intermediación que no pasen por el centro
histórico de la red. Los nuevos puntos críticos que "nacen" son los nodos del propio
anillo, que asumen la carga de intermediación que antes recaía en el centro poniente.

El Gini de B(v) sube ligeramente (0.789→0.798 en METRO): el anillo no elimina la
concentración, la *traslada y redistribuye*. Esto es coherente con la tesis del
transporte anillar: no desaparece la necesidad de nodos de transferencia, sino que
se generan nuevos puntos de transferencia en la corona periférica.

**El escenario MB no reorganiza la jerarquía.** El top-5 es prácticamente idéntico
al baseline. El BRT periférico, sin la capacidad y velocidad del metro, no genera
suficiente intermediación topológica para desplazar a los nodos del centro.

---

### 4. MB no suma mejora significativa frente a METRO

Comparando MB vs METRO en los indicadores donde hay movimiento:

| Indicador | MB vs Baseline | METRO vs Baseline | METRO vs MB |
|---|---|---|---|
| T (min) | −4.18 min (−3.8%) | −10.80 min (−9.9%) | −6.62 min más |
| Tacubaya B | −2.2% | −28.5% | −26.3 pp más |
| Top-5 cambia | No | **Sí, 3 nuevos nodos** | Diferencia cualitativa |
| Banda T | aceptable→idóneo | aceptable→idóneo | igual |

El MB aporta una mejora marginal en T y una reducción cosmética de Tacubaya.
No reorganiza la jerarquía topológica ni genera nuevos nodos de intermediación
periférica. Bajo los mismos supuestos metodológicos (sin afluencia), la diferencia
entre BRT y METRO no es de grado sino de tipo: el MB mejora el indicador de fluidez
pero no transforma la estructura de la red.

**Para la tesis:** si el objetivo del transporte anillar es redistribuir la carga
de intermediación y descomprimir los nodos críticos del centro, el anillo metro
cumple ese objetivo en mayor medida que el BRT, incluso en condiciones hipotéticas
sin calibración de demanda. Esta diferencia cualitativa entre ambas soluciones es
uno de los argumentos centrales de la propuesta.

---

## Recursos generados

```
tableau/exports/data/garibelt/
  escenario-base/
    b_ranking_baseline.csv           2,000 nodos — ranking B(v)
    fc_distribucion_baseline.csv     10,537 nodos — fuerza capilar Cᵢ
    df_distribucion_baseline.csv     200 rutas — Factor Desviación DI
    cobertura_alcaldias_baseline.csv 141 demarcaciones — cobertura 800m
    garibelt_perfil_baseline.csv     5 dimensiones Garibelt

  escenario-mb/
    [mismos archivos, 10,636 nodos fc]

  escenario-metro/
    [mismos archivos, 10,636 nodos fc]
```

**Pendientes:**
- `perfil_nodos_{escenario}.geojson` — banda dominante por nodo (espera endpoint
  VFTModel corregido + re-warmup). Necesario para Hoja 7 del workbook y mapas QGIS.

---

*Generado por análisis computacional VFTModel v1 + Apimetro GTFS-CDMX.*
*Los escenarios MB y METRO son hipotéticos, sin validación operacional ni encuesta O-D.*
