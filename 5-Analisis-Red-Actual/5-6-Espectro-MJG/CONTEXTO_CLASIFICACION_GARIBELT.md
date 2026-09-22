# §5.6 Diagnóstico Territorial — Clasificación Garibelt
## Nota de contexto y plan editorial — 2026-09-18

---

## Qué es la Clasificación Garibelt

Un **tablero de diagnóstico topológico** que compila los 5 indicadores de las Fases 1–3 del VFTModel sin agregarlos en un escalar único. Cada dimensión se normaliza a [0, 1] con un método específico a su naturaleza estadística y se clasifica en una de 4 bandas. El producto final es **El Espectro MJG**, una tabla descriptiva que muestra las fortalezas y debilidades estructurales de la red.

### Filosofía de diseño
La normalización sirve exclusivamente como **calibración matemática** para llevar dimensiones inconmensurables a una escala de lectura común. No es preparación para sumar. El instrumento es un espectro diagnóstico, no un ranking.

---

## Escala Garibelt — 4 bandas

| Banda | Rango normalizado | Interpretación urbana |
|---|---|---|
| Crítico   | [0.00, 0.25) | Deficiencia estructural severa. Intervención prioritaria. |
| Débil     | [0.25, 0.50) | Rendimiento por debajo de la mediana. Área de mejora. |
| Aceptable | [0.50, 0.75) | Desempeño adecuado para la función urbana. |
| Idóneo    | [0.75, 1.00] | La red es estructuralmente apta en esta dimensión. |

---

## Las 5 dimensiones — Espectro MJG v1

| # | Dimensión | Indicador | Símbolo | Normalización | Referencia |
|---|---|---|---|---|---|
| 1 | Accesibilidad | Cobertura Espacial | $C$ | Literature Standard (0–80%) | Estándar peatonal urbana |
| 2 | Conectividad capilar | Fuerza Capilar | $C_i$ | Empirical Percentile (Q1–Q3) | Percentiles del propio dataset |
| 3 | Eficiencia de ruta | Índice de Ruta Directa | $DI$ | Theoretical Bounds (1.0–2.5) | DI=1 óptimo; DI≥2.5 crítico |
| 4 | Fluidez global | Tiempo Promedio de Viaje | $T$ | Reference-based (85–180 min) | INEGI/ENOE CDMX |
| 5 | Centralidad crítica | Intermediación (Gini) | $B(v)$ | Empirical Gini (1 − Gini) | Monopolio topológico |

### Indicadores excluidos en v1
| Indicador | Razón |
|---|---|
| $W_{s,h}$ — Penalización Transferencia | Implementación parcial (v2) |
| $\Delta E$ — Robustez Geométrica | Requiere múltiples corridas; Fase 4 pendiente |

---

## Valores reales ZMVM 2026 (Notebook 06)

- Grafo: 11,115 nodos | 45,497 aristas | SCC gigante: 10,561 nodos (95%)
- $T$ = 108.92 min
- $B(v)$ top: Tacubaya = 0.2179
- $DI$ top: 3.51 (sample 500 O-D)
- $C_i$ top: FC = 92

---

## Andamiaje bibliográfico — argumento por argumento

### Argumento 1: Por qué NO un escalar único (no-agregación)
**Hossain et al. (2024)** — *Limitations and considerations of using composite indicators in hazard vulnerability assessments*. Scientific Reports 14.
- La normalización sirve para llevar dimensiones a escala común, no para fusionarlas.
- El problema de **compensabilidad**: una dimensión alta oculta fallas catastróficas en otra.
- La vulnerabilidad debe tratarse como espectro donde las debilidades críticas mantienen su jerarquía de prioridad.

**Deng et al. (2023)** — *Interconnectedness enhances network resilience of multimodal public transport networks*. Scientific Reports 13.
- Paradigma **Safe-to-Fail**: evaluar la red como espectro de interoperabilidad, no como aprobado/reprobado.
- El Gini sobre métricas de centralidad detecta el grado de monopolio topológico.
- La distribución de carga (no el promedio) indica propensión a fallas en cascada.

### Argumento 2: Para qué sirve la normalización
**Kujala et al. (2018)** — *A collection of public transport network data sets for 25 cities*. Scientific Data 5.
- Normalizar datos GTFS heterogéneos habilita el cálculo de indicadores comparables.
- Con 25 ciudades disponibles, los autores NO construyeron un índice compuesto — produjeron un **perfil multidimensional**.
- El fin de normalizar es el análisis granular, no emitir una calificación global.

### Argumento 3: Por qué métodos de normalización distintos por dimensión
**Talukder et al. (2017)** — *MAUT as a Tool to Develop Index and Dashboard for Goal 2 of SDGs*. Environmental and Sustainability Indicators.
- Marco OCDE Paso 5: cada dimensión requiere el método que respete sus propiedades estadísticas.
- Usar tipos distintos (percentil, referencia externa, límite teórico) es exigencia de buenas prácticas, no arbitrariedad.
- Paso 10 (Visualización): el tablero (dashboard) es la forma de presentación que preserva la transparencia analítica para formulación de políticas.

### Argumento 4: De dónde vienen las 5 dimensiones elegidas
**Bocarejo & Oviedo (2012)** — *Transport accessibility and social inequities: a tool for identification of mobility needs*. Journal of Transport Geography 24.
- La accesibilidad tiene 4 componentes inconmensurables por naturaleza:

| Componente B&O (2012) | Indicadores del Espectro MJG |
|---|---|
| Transporte (infraestructura, topología) | $T$, $DI$, $B(v)$ |
| Uso de suelo (distribución territorial) | $C$ (cobertura 800m) |
| Temporal (frecuencias, horarios) | $C_i$ (fuerza capilar — grado nodal refleja oferta) |
| Individual/social | Fuera del alcance v1 |

---

## Párrafo de defensa (extracto para usar en el texto)

> "La decisión metodológica de no agregar las dimensiones de la Clasificación Garibelt en un índice único no es una limitación del estudio, sino un diseño fundamentado en el estado del arte. Hossain et al. (2024) advierten sobre el sesgo de compensabilidad en índices compuestos, donde una alta eficiencia podría ocultar vulnerabilidades estructurales severas. Por ello, siguiendo el enfoque de perfiles descriptivos propuesto por Kujala et al. (2018) para datos GTFS, y el modelo de evaluación de resiliencia desagregada de Deng et al. (2023), este instrumento emplea la normalización únicamente como mecanismo de calibración matemática. El resultado es un tablero diagnóstico — un espectro y no un ranking — que preserva la información crítica necesaria para priorizar la política pública en el Tercer y Cuarto Contorno de la ZMVM."

---

## Estructura de archivos del §5.6

```
5-Analisis-Red-Actual/
  5-6-Clasificacion-Garibelt/
    CONTEXTO_CLASIFICACION_GARIBELT.md  ← este archivo
    5-6-Diagnostico.tex                 ← padre: \section + intro + \input de los 3
    5-6-1-Fundamento.tex                ← argumentación metodológica (5 papers)
    5-6-2-Clasificacion.tex             ← instrumento: tabla dims + normalización
    5-6-3-Espectro-MJG.tex              ← resultados: tabla descriptiva + lectura
```

---

## Lo que debe añadirse en Cap. 3 ANTES de §5.6

| Archivo | Qué agregar |
|---|---|
| `3-1-1-Glosario-Base.tex` | `\subsubsection{Clasificación Garibelt}` — definición + tabla de 4 bandas |
| `3-3-Indicadores-Formula.tex` | `\subsection{Clasificación Garibelt}` — 5 dims, tabla normalización, exclusiones v1 |

---

## Entradas a agregar en referencias.bib

| Clave | Referencia |
|---|---|
| `kujala2018` | Kujala R. et al. (2018). Scientific Data 5, 180089. DOI: 10.1038/sdata.2018.89 |
| `hossain2024` | Hossain N. et al. (2024). Scientific Reports 14. DOI: 10.1038/s41598-024-69874-y |
| `talukder2017` | Talukder B. et al. (2017). Environmental and Sustainability Indicators. DOI: 10.1016/j.ecolind.2017.05.049 |
| `deng2023` | Deng W. et al. (2023). Scientific Reports 13, 11634. DOI: 10.1038/s41598-023-38827-0 |
| `bocarejo2012` | Bocarejo J.P. & Oviedo D.R. (2012). Journal of Transport Geography 24, 142–154. DOI: 10.1016/j.jtrangeo.2011.12.004 |
