# Contexto del Capítulo 6 — Escenario Hipotético: Anillo Periférico de Alta Capacidad

**Última actualización:** 2026-10-25
**Issue:** #25 (absorbe #14, #20 y #22) · **Corrida vigente:** 2026-10-04 (VFTModel post Fix #23)
**Rama:** `Feature-version-alpha`

Archivo de trabajo para retomar el capítulo entre sesiones. No se compila.

---

## 0. RETOMAR AQUÍ (sesión 2026-10-24)

**Siguiente paso:** redactar **§6.5 Conclusiones del Escenario** y luego el **Cap. 7** con la
estructura aprobada (abajo). Antes, confirmar que el usuario ejecutó los 4 commits entregados.

**Flujo acordado (sin cambios):** parte por parte; 1 opción (o 2–3 si hace falta) con score
por párrafo (nada ≥ 0.20); esperar aprobación; el usuario compila y hace los commits
(sin Co-Authored-By). Escribir `.tex` con Edit/Python, no con `cat >>`. Tono: lectura
urbana, pocas cifras, intervalos en lugar de adjetivos de banda (#33); en cada indicador,
«qué mide → por qué cambia con el anillo»; mapas y dashboards en el cuerpo y a página
completa en el Anexo G (gráficas de `Figures/Cap6/` solo en el cuerpo).

### Logrado el 2026-10-24
- §6.3.3 T completa (G3, G4, G8; contraste con `tab:tiempo-promedio`; límites; interpretación).
- §6.3.2 FC: G1 y G2 ya son figuras reales. Gráficas en `Figures/Cap6/TiempoViajePromedio/` (PNG).
- §6.3.4 B(v) completa: mecanismo (lectura especulativa del reacomodo de caminos), `tab:anillo-bv`,
  Caso 2 (relevo MB↔RTP en Periférico Sur), Caso 3 (cadena TL → L2 → Mixcoac; 9/10 del anillo),
  Redistribución (unigráfica top 10, QGIS 4 paneles, G6, G5/Gini), contraste con `tab:betweenness`,
  5 límites, interpretación.
- §6.4 Espectro MJG completa (D.1–D.7): `tab:anillo-espectro` (tabularx; sin DI; C con 76),
  perfil (2 unigráficas), Casos 2–3 (Dashboard_Espectro_* y _Clasificacion_*), clasificación por
  nodo (banda dominante = intervalo del mínimo entre FC y B(v) normalizadas min–max por caso;
  G7, 3 mapas, cambio de banda), comparación global (Dashboard_Comparativo_KPI) y límites,
  interpretación.
- Cap. 3: párrafo de **banda dominante** al final de `subsubsec:garibelt-procedimiento` (3-3-9-2).
- Anexo G: G.5 (3 mapas B(v)), G.6 (4 mapas banda dominante), **G.7 (10 recursos Tableau)** a
  página completa e **índice** `tab:anx-g-indice` (longtable) al inicio; todos los pies del
  cuerpo remiten al anexo. 24 figuras en el anexo.
- Cap. 1 alineado: objetivo 5 (Caso 2 = Metrobús, Caso 3 = Metro); 1-5 Fase 3 (MB confinado
  16.3 km/h, Metro exclusivo 36 km/h, mismas estaciones; C, FC, T, B(v); «DI solo red actual»)
  y Fase 4. 5-4-2:36 remite a §6.3.3. **La hipótesis NO se modifica**: se contrasta en el Cap. 7.
- Issues creados: **#40** (formato: archivos > 120 líneas en §6.3 y Cap. 3, baja prioridad) y
  **#41** (limpieza de rótulos de figuras del Cap. 6, fase «limpia y poda»).
- `make checar`: 569 labels, 0 duplicados; única ref. sin label: `sec:anillo-interpretacion`.

### Commits entregados al usuario (por confirmar)
1. `feat(cap6): §6.4 Espectro MJG comparativo…` (6-4)
2. `docs(cap3): definición de banda dominante…` (3-3-9-2)
3. `feat(anexos): Anexo G.6–G.7…` (Anexo G + 6-3-5)
4. `fix(cap1): objetivo 5 y Fases 3–4…` (1-3, 1-5, 5-4-2)

### Estructura APROBADA para lo que falta
**Cap. 6 — §6.5 Conclusiones del Escenario** (2–3 pp; cumple la tarea del asesor «conclusiones
del Cap. 6 + Metro más favorable»):
- Renombrar `6-5-Interpretacion.tex` → `6-5-Conclusiones-Escenario.tex`; `\section{Conclusiones del
  Escenario}`, `\label{sec:anillo-conclusiones}`; actualizar `\input` de `1-Analisis-Red-Anillo.tex`
  y la frase de `6-1:30-31` («la sección~\ref{sec:anillo-interpretacion} los lee desde el urbanismo»).
- Entrada · 6.5.1 Acercar no es conectar: el anillo en los contornos (T por demarcación: oriente
  Edomex = Cuarto Contorno en ambos; Metro suma el sur = Tercer Contorno; C casi igual; 41
  municipios sin cobertura fuera de alcance; `fig:semovi-contornos`) · 6.5.2 De red radial a
  anillo-radial: reparto de la centralidad (pregunta secundaria 1; Moscú, Melbourne) · 6.5.3 Nodos
  de transbordo como CETRAM de nueva generación (POT, Constitución de 1917, Rómulo O'Farril,
  Barranca del Muerto, Luis Cabrera, Canal Nacional; alta B(v), FC ≈ 6 → alimentadoras/última
  milla; tono de recomendación) · 6.5.4 Modo y derecho de vía: el Caso 3 es el más favorable
  (MB = relevo de la RTP; Metro cambia la estructura; §2.2 sesgo vial/rechazo al Metro) · cuadro
  de síntesis por caso.
- Decisiones: P-2 solo citas ya presentes en la tesis · P-3 cuadro de síntesis sí · P-4 mapa de
  síntesis nuevo en Transport-gis (dar especificación; `\graficapendiente`) · P-5 CETRAM como
  recomendación · P-6 NO usar el hallazgo especulativo de transbordos.
**Cap. 7** (1–2 pp, estructura obligatoria del asesor, #23): `7-Conclusiones/1-Conclusiones.tex`
padre (`\chapter`, `\label{ch:conclusiones}`, 3 `\input`) + `7-1-Resumen-Resultados.tex`
(contraste de pregunta e hipótesis: T baja −4.1/−10.1 %; B(v) Tacubaya baja pero Gini sube →
parcial; DI no evaluable en escenarios) · `7-2-Contribuciones.tex` (cadena replicable Apímetro →
VFTModel → Transport-gis; Clasificación Garibelt) · `7-3-Trabajo-Futuro.tex` (lista acumulada §5).

### §6.5 redactada (2026-10-25)
`6-5-Conclusiones-Escenario.tex` (renombrado con `git mv`), `sec:anillo-conclusiones`; `\input`
y cabecera de `1-Analisis-Red-Anillo.tex` y frase de `6-1:30-31` actualizados. Opciones elegidas:
entrada B; 6.5.1 A/A/A; 6.5.2 A/B/A; 6.5.3 A/A; 6.5.4 A/A; síntesis A. `make checar`: 578 labels,
0 duplicados, 0 refs sin label.
- ✅ Programa Maestro del Metro (2026-10-25), al final de §6.5.2: `subsubsec:anillo-pm-1980`
  (antecedente, `fig:anillo-pm-1982-1983` a página completa, `tab:anillo-pm-corredores` = T-5,
  `tab:anillo-pm-parametros` = T-4) y `subsubsec:anillo-pm-2010` (red equilibrada,
  `tab:anillo-pm-depuracion`, límite del D.F., argumento saltón, enfoques complementarios).
  Cita `ddf1985programa` (DDF/COVITUR, segunda revisión, versión 1985). Anexo G.8
  `fig:anx-g-pm-1982-1983` (PlanMaestro10, otra toma de E-5/E-6) + renglón en el índice.
  Las fotos `PlanMaestro2010/` son el horizonte 2010 del mismo documento (pp. 63–66).
  Opcional sin decidir: E-12 y E-13 (`PlanMaestro2010-2/-3`) en el anexo.
- 6.5.2 P1 resuelto con «…solo eje, porque Tacubaya…» (0.122). Ningún párrafo de §6.5 ≥ 0.20.
- **Mapa de síntesis — DESCARTADO para la versión Alfa (2026-10-25):** requeriría otro dashboard;
  §6.5.5 remite ahora a `fig:anillo-t-demarcacion`, `fig:anillo-bv-comparativo` y
  `fig:anillo-banda-cambio`. Especificación conservada por si se retoma:
  QGIS, dos paneles a la misma escala (A = Caso 2, B = Caso 3); salida
  `Figures/Mapas/Qgis_Resources/Comparativo_CG/Comparativo_Garibelt_Sintesis` (PDF vectorial + PNG).
  Coropleta: media de `delta_mb_min` / `delta_metro_min` por demarcación de
  `VFTModel/notebooks/ASSETS/t_distribucion/t_comparativo_origen.csv`, mismas clases en ambos
  paneles (0–5, 5–10, 10–20, 20–40, > 40 min), achurar demarcaciones con n ≤ 17. Trazo del API-I con
  las 94 estaciones. Símbolos: estaciones del anillo en el top 10 de B(v) de cada caso
  (`comparativo/bv_comparativo.csv`, `es_nodo_anillo`, `rank_*`), tamaño por B(v); Tacubaya con su
  cambio (−3.1 % / −29.7 %). Etiquetas en el panel B: Periférico Oriente/Tláhuac, Constitución de
  1917/Periférico, Canal Nacional, Rómulo O'Farril, Barranca del Muerto/Periférico, Luis Cabrera.
  Contornos SEMOVI solo si existe la capa. Rótulos: «Caso 2 (Anillo MB)», «Caso 3 (Anillo Metro)»,
  «Cambio del tiempo medio del nodo (min)», «Centralidad de intermediación B(v)»; sin «Escenario
  Metro» ni «Ranking».
- Hallazgo para #39: `fig:semovi-contornos` pinta Tlalpan y Xochimilco como Segundo Contorno;
  `1-4:151-153` los llama Tercer Contorno. §6.5.1 dice «que el Capítulo 1 identifica con el Tercer Contorno».

### Pendientes abiertos (además de §6.5 y Cap. 7)
- Al cerrar el capítulo: actualizar **#34** (dominio CDMX; rehacer §6.3.1, §6.4, §5.6 si se
  confirma; hoy especulativo), **#25** (checklist), **#35** (contingencias en T y B(v), L5, L6),
  **#39** (ΔE del objetivo 3; nombre del DI Cap. 3 vs Cap. 5; consistencia), **#32** (T_b fijo).
- `6-1:211` «como se observa en la Figura~\ref{fig:propuesta-anillo-cuadrantes}» apunta hacia
  adelante (§6.2.1); añadir remisión.
- 3 párrafos antiguos en aviso: 6-1 glosario (0.276), 6-1 Limitación 3 (0.235), 6-2 §6.2.2 (0.235).
- Reportar a VFTModel el snapping por sistema (§7) y el nodo «314 Memorial New's Divine».
- Opcional: copiar los PDF vectoriales de las gráficas de Transport-gis a `Figures/Cap6/…`;
  commit del cuaderno `graficas_cap6.ipynb` en Transport-gis.
- Verificar en el PDF: `tab:anillo-espectro` sin overfull; índice del Anexo G; G.7 girado.
- Sin cambios: #14 (remisiones a §6.1.1), citas `p.~XX`, propagar API-I (opcional), #40, #41.

## 1. Estado de los archivos

| Archivo | Sección | Estado |
|---|---|---|
| `1-Analisis-Red-Anillo.tex` | Índice del capítulo | ✅ cabecera y `\input` al día |
| `6-1-Corredor-Anillar.tex` | §6.1 El Corredor Anillar como Propuesta | ✅ redactada |
| `6-2-Escenario-Procesamiento.tex` | §6.2 Escenarios y Procesamiento | ✅ redactada |
| `6-3-Indicadores-Escenario/6-3-Indicadores-Escenario.tex` | §6.3 Indicadores de la Red con Anillo (`sec:anillo-indicadores`) | ✅ entrada con la clave de lectura (2026-10-22) |
| ~~`6-3-1-Escenarios.tex`~~ | Integrado en §6.2.1 (opción B, 2026-10-22) | 🗑️ borrado (también el huérfano `0-6-3-1-Escenarios.tex`) |
| `6-3-Indicadores-Escenario/6-3-2-Cobertura.tex` | §6.3.1 C | ✅ redactada 2026-10-22; 2 mapas en cuerpo + Anexo G.2 · ⚠️ #34 pendiente al final |
| `6-3-Indicadores-Escenario/6-3-3-FuerzaCapilar.tex` | §6.3.2 FC | ✅ completa; mapas en cuerpo + Anexo G.3; G1 y G2 integradas (2026-10-24) |
| `6-3-Indicadores-Escenario/6-3-4-TiempoViaje.tex` | §6.3.3 T | ✅ completa 2026-10-24 (G3, G4, G8; extendido en Anexo G.4) |
| `6-3-Indicadores-Escenario/6-3-5-Centralidad.tex` | §6.3.4 B(v) | ✅ completa 2026-10-24 (mapas y dashboards en cuerpo; Anexo G.5 y G.7) |
| `6-4-EspectroComparativo.tex` | §6.4 Espectro MJG comparativo (`sec:anillo-espectro`) | ✅ completa 2026-10-24 (D.1–D.7; Anexo G.6 y G.7) |
| `6-5-Conclusiones-Escenario.tex` | §6.5 Conclusiones del Escenario (`sec:anillo-conclusiones`) | ✅ redactada 2026-10-25 · ⏳ Plan Maestro 1983 DF y mapa de síntesis (Transport-gis) |
| `../Anexos/G-Visualizaciones-Anillo.tex` | Anexo G (`anx:visualizaciones-anillo`) | ✅ índice `tab:anx-g-indice` · G.1 propuesta (3) · G.2 cobertura (2) · G.3 FC (2) · G.4 cuadro T · G.5 B(v) (3) · G.6 banda dominante (4) · G.7 Tableau (10) |

`make checar` (2026-10-23): 502 labels; 2 duplicados que vienen SOLO del archivo huérfano
`6-3-Indicadores-Escenario/0-6-3-1-Escenarios.tex` (borrarlo o comentar sus `\label`); faltan
`sec:anillo-espectro` y `sec:anillo-interpretacion` (se resuelven al escribir §6.4 y §6.5).
Última compilación del usuario: exitosa (antes de aplicar la parte 2 de T; recompilar).

### Contenido ya redactado

- **§6.1** (`sec:corredor-anillar`): entrada del capítulo (3 casos, alcance) y orden del
  capítulo · §6.1.1 definición operativa (4 condiciones) + contraste radial/anillar con el
  costo en DI (`tab:radial-anillar`) · §6.1.2 Periférico solo vehicular, RTP 57-A/57-C en vía
  compartida (CF 1.380 → 8.0 km/h), diagnóstico del Cap. 5, localización metropolitana
  (66 estaciones en 13 alcaldías + 28 en 4 municipios) y `fig:propuesta-anillo` ·
  §6.1.3 segmentos (`tab:segmentos-anillo`) y cuadrantes · §6.1.4 Limitaciones del Modelo
  (condiciones físicas, dimensión social, 4 segmentos y nombre **API-I**, anillo exterior).
- **§6.2** (`sec:anillo-escenarios`): entrada (mismo procedimiento, solo cambia el anillo) ·
  §6.2.1 parámetros (`tab:anillo-parametros`) · §6.2.2 procesamiento en contenedores Docker
  aislados (`tab:anillo-procesamiento`) · §6.2.3 grafo con anillo (`tab:anillo-grafo`).

---

## 2. Decisiones del autor (no reabrir)

| Tema | Decisión |
|---|---|
| Casos | **Caso 1** = red actual · **Caso 2 = Anillo MB** · **Caso 3 = Anillo Metro** |
| Nombre de la propuesta | **Anillo Periférico Interior (`\textsc{api-i}`)**; segmentos Periférico Interior Norte/Oriente/Sur/Poniente. «API» choca con `\api` |
| DI | No se analiza en el Cap. 6 (solo red actual, §5.3.4) |
| Dominio de C | Las figuras usan 141 demarcaciones (0.055 → 0.056); se dejan así (C6-1) |
| Top 10 de B(v) | Comparativos = orden por nodo; `Dashboard_Betweenness_*` = 10 nombres por suma de B(v) (como `tab:bv-top10-agregado`). No se contradicen; decirlo en el pie |
| Conteo de nodos | Dato mayor de la corrida vigente: 11,209 nodos; gigante 10,707 (95.52 %) |
| Literatura | No hace falta literatura de apoyo: es una propuesta |
| Nomenclatura en figuras | Pies y texto con los términos del repositorio; las discrepancias de rótulos se anotan y se entregan como comentario de issue menor |
| Anexo G | Solo recursos de secciones ya redactadas; mapas a página completa (`[p]`, `angle=90`, `height=0.82\textheight`) |
| Figuras en §6.3 | Se deciden caso por caso; no preocuparse por la extensión |
| Esquema por indicador | Entrada · Caso 2 · Caso 3 (o «Casos 2 y 3» si coinciden) · lectura comparativa |
| Penalización T_b | No dar los intervalos de los anillos (3 y 5 min) — ver pendiente #32 |
| Términos | Ajustes de términos y propagación del nombre API-I: opcionales, al terminar todo el documento |

---

## 3. Preguntas de §6.3.1 — RESPONDIDAS (2026-10-22)

Respuestas del autor, aplicadas en §6.2.1 `subsec:anillo-parametros` (opción B):
- 1–2: ambos casos usan un transporte público masivo teórico, con la velocidad y el
  derecho de vía de un sistema existente, sin condiciones técnicas ni geográficas.
- 3: los indicadores se comparan contra el Caso 1 (red actual, Periférico como opera hoy).
- 4: el Caso 2 conserva la velocidad efectiva del **Mexibús** (confinado, CF 1.152 ≈ 14.2 km/h)
  como supuesto especulativo, porque el Periférico cruza la CDMX y el Edomex. Sin nueva corrida (#35).
- Bandas Garibelt en el texto nuevo del Cap. 6: sin adjetivos, solo valor o intervalo (#33).
- VFTModel no usa la capacidad: el texto no la menciona como variable del cálculo.

§6.2.1 ahora tiene: preguntas por caso, cuadro único `tab:anillo-parametros` (con Caso 1),
`fig:propuesta-anillo-cuadrantes-mb` y `fig:propuesta-anillo-cuadrantes`. Ya no existen
`subsec:anillo-escenarios-casos` ni `tab:anillo-casos`.

### Preguntas originales (referencia)

1. ¿Por qué un **Caso 2 con Metrobús**? (costo, plazo, experiencia BRT de la ciudad, vía confinada sobre el Periférico…)
2. ¿Por qué un **Caso 3 con Metro**? (capacidad, velocidad, vía exclusiva, integración con el STC…)
3. ¿Qué debería comparar el lector entre los dos casos antes de ver los indicadores?
4. (Si aplica) Por qué el Anillo MB se registró con vía **confinada** (CF 1.152) y no exclusiva como el Metrobús actual.

Estructura acordada de §6.3.1: entrada (dos casos, mismo trazo) · Caso 2 (razones, vía
confinada, `Propuesta_Anillar_Extendido_MB`) · Caso 3 (razones, vía exclusiva,
`Propuesta_Anillar_Extendido_Metro`, ya en el archivo con `fig:propuesta-anillo-cuadrantes`)
· cuadro comparativo urbano sin adelantar resultados. Al redactarla, revisar la frase de
§6.1.3 «como se observa en la Figura…» (ahora apunta hacia adelante).

---

## 4. Cifras vigentes de los tres casos (corrida 2026-10-04)

| Indicador | Caso 1 | Caso 2 (MB) | Caso 3 (Metro) |
|---|---|---|---|
| Nodos / aristas | 11,115 / 45,517 | 11,209 / 46,002 | 11,209 / 45,993 |
| Componente gigante | 10,610 (95.46 %) | 10,707 (95.52 %) | 10,707 (95.52 %) |
| C (ZMVM 76) | 13.29 % | 13.43 % | 13.43 % |
| C (141, figuras) | 0.055 | 0.056 | 0.056 |
| FC mediana | 7 → 0.250 Débil | igual | igual (13 nodos cambian entre MB y Metro) |
| T (min) | 113.91 → 0.696 | 108.99 → 0.7475 (a 0.0025 de Idóneo) | 101.92 → 0.822 Idóneo |
| Gini B(v) | 0.8007 (0.199) | 0.8012 (0.199) | 0.8134 (0.187) |
| Tacubaya B(v) | 0.2232 | 0.2163 (−3.1 %) | 0.1569 (−29.7 %) |
| Anillo en el top | — | 0 de 10 · 0 de 50 | 9 de 10 · 40 de 50 |
| Cambio de banda dominante | — | 10 nodos | 21 nodos |

Fuentes: `Anexos/Notas_Correciones/Revisiones-Capas-Externas/RESPUESTAS_PREGUNTAS_ISSUES.md`
(P7.1, P10.1), `RESULTADOS_RECORRIDA.md` §7 y §9.2, y
`Transport-gis-zmvm-mjg/tableau/exports/data/garibelt/` (`comparativo/`, `escenario-*`).
`ANALISIS_PRELIMINAR.md` y `SUPOSICIONES_ANALITICAS.md` son de septiembre: **obsoletos**.

Parámetros: Anillo MB = confinado, 16.3 km/h, CF 1.152 → 14.2 km/h (como Mexibús);
Anillo Metro = exclusivo, 36 km/h (como Metro). 94 estaciones compartidas, 4 líneas, 8 ramales.

---

## 5. Pendientes

### Del capítulo
- [x] §6.3.1 Escenarios (2026-10-22)
- [ ] §6.1.3 (`6-1:210`): «como se observa en la Figura…» apunta hacia adelante; añadir «(§6.3.1)» (pendiente de aprobación)
- [x] §6.3.1–§6.3.4 indicadores por caso (2026-10-24)
- [x] §6.4 Espectro MJG comparativo (2026-10-24) · [ ] §6.5 Conclusiones del Escenario · [ ] Cap. 7
- [x] Anexo G: recursos de §6.1–§6.4 e índice (2026-10-24)
- [ ] #14: que los usos de «corredor anillar» en Cap. 1–5 remitan a §6.1.1 (10 sitios)

### Revisión final de congruencia (al terminar el Cap. 6)
- [x] Casos 2/3 invertidos en `1-3-Objetivos.tex` y `1-5-Metodo-Metodologia.tex` — corregido 2026-10-24 (hipótesis sin cambios, se contrasta en el Cap. 7).
- [ ] #32: Cap. 3 (`3-3-5`) y Cap. 5 (`5-4-2`) dicen que T_b depende del intervalo de cada sistema; VFTModel usa un valor fijo.
- [ ] Nombre del DI: Cap. 3 «Índice de Ruta Directa» vs Cap. 5 «Factor de Desviación».
- [ ] Citas con `p.~XX`: `1-1:34`, `1-4:46`, `1-4:98`.
- [ ] Nodo MB «314 Memorial New's Divine» (2 registros): posible registro defectuoso de Apímetro.
- [ ] (Opcional) Propagar «Anillo Periférico Interior (API-I)» en §6.1 y otros capítulos.

### Comentario de issue menor (rótulos de figuras) — entregado al usuario el 2026-10-18
Lista completa en la memoria `project_pendientes_limpieza_mapas`; resumen:
«Espectro Garibelt» → Espectro MJG; «Cᵢ — Alimentación Capilar» → Fuerza Capilar (FC);
«Ranking» → jerarquía/orden; «ref. CDMX 85 min» → tiempo de referencia del modelo;
bandas sin tilde; «ZMVM 2025»/«2026»; «Escenario Metro/MB» → Caso 3 / Caso 2;
nota Sur-Poniente del mapa extendido menciona el Tren Ligero.

### Hallazgo especulativo (NO usar todavía)
Por proximidad ≤ 85 m (regla Q1), varias estaciones de transbordo del anillo no enlazan
con el Metro: Barranca del Muerto 207 m, San Pedro de los Pinos 331 m, Cuatro Caminos
506 m, Constitución de 1917 155 m (solo Cablebús a 6 m), Canal de San Juan 162 m;
Atlalilco a 2.1 km (¿coordenada?). Solo enlazan Periférico Oriente/Tláhuac y Río de los
Remedios. Confirmar con el agente de VFTModel antes de cualquier uso.

### Para el Cap. 7 (#23), trabajo futuro acumulado
Isócronas con población (C) · calibración de T_b · contraste de velocidades por ruta ·
ΔE con Latora-Marchiori · sensibilidad de cortes Garibelt, α y β · **dimensión social de
la propuesta** · **Anillo Periférico Exterior**.

---

## 6. Estado del repositorio (2026-10-18; ver §0 para 2026-10-23)

Sin commit todavía (los ejecuta el usuario; `git add/commit` están bloqueados para el agente):

1. `fig(cap6): mapas base, dashboards por escenario y comparativos del anillo (#25)`
2. `feat(cap6): estructura del capítulo y §6.1–§6.2 redactadas (#25 #14)` (incluye el glosario y este `CONTEXTO_CAP6.md`)
3. `feat(anexos): Anexo G de recursos visuales del API-I (#25)` (incluye `tesis.tex`)

Fuera de los commits: `tesis_3-Conceptos-Indicadores.pdf` y `tesis_5-Analisis-Red-Actual.pdf`
(salidas de `make solo`; sugerido agregar `tesis_*.pdf` a `.gitignore`).

Issues abiertos en GitHub: #25 (Cap. 6), #23 (Cap. 7), #11 (E-02, E-03, E-04, E-09), #26 (Anexo C y rótulos G1–G3),
#32 (T_b) y #33–#39 (Revisión-3 del asesor, 2026-10-19; se atienden después de cerrar el Cap. 6).

---

## 7. §6.3.2 FC, Casos 2 y 3 — APLICADO 2026-10-23 (se conserva como referencia)

Aprobado en redacción; no se aplica hasta explicar por qué 13 nodos cambian de FC entre MB y Metro
(revisión con el grafo en memoria de VFTModel cuando el autor lo indique). La gráfica
`fig:anillo-fc-estaciones` la genera Transport-gis-zmvm-mjg. Al aplicar: agregar al Anexo G
`fig:anx-g-fc-mb` y `fig:anx-g-fc-metro` a página completa.


### Causa de los 13 nodos con FC distinta (verificada 2026-10-23)

Grafos reconstruidos en memoria con el código de VFTModel contra Apímetro :8083 (MB) y :8084 (Metro):
11,209 nodos; 46,002 / 45,993 aristas (= corrida vigente). Los 13 nodos difieren solo en aristas
`transit`, nunca en transbordos. Causa: **Fase 2 de `graph_builder.py` (KDTree por sistema, 50 m)**.
Cada ruta toma como parada cualquier estación **de su mismo sistema** a ≤ 50 m del trazo.
- Caso 2 (anillo = MB): las líneas MB existentes toman estaciones del anillo como paradas y el trazo del
  anillo toma estaciones MB existentes (Periférico Sur ↔ Villa Olímpica, Perisur, Cuicuilco, Jardines
  del Pedregal; Muyuguarda/Cafetales ↔ Muyuguarda, Cañaverales; Constitución de Apatzingán ↔ CCH Oriente;
  Río de los Remedios MB/Periférico ↔ 314 Memorial, El Coyol; Alameda Oriente, Cd. Nezahualcóyotl ↔ Calle 6…).
- Caso 3 (anillo = METRO): solo la Línea B en Río de los Remedios Metro/Periférico (↔ Múzquiz).
- Efecto de interposición: en el Caso 2, El Coyol–Río de los Remedios (MB existente) pasa por la estación
  del anillo; en el Caso 3 la arista directa se conserva.
- Posible efecto también en T y B(v) del Caso 2 (el anillo MB queda integrado a líneas MB existentes).
Párrafo propuesto para el Caso 3 (score 0.152), pendiente de aprobación:

```latex
La diferencia viene de una regla del modelo y no de la operación de cada
sistema. Al construir el grafo, el \texttt{VFTModel} une cada ruta con las
estaciones de su mismo sistema que quedan a unos 50~m o menos de su trazo
(§\ref{sec:grafo-topologico}). En el Caso~2 las estaciones del anillo
pertenecen al Metrobús, así que las líneas de Metrobús que pasan junto a ellas
las toman como paradas propias; a su vez, el trazo del anillo toma como paradas
a estaciones de Metrobús cercanas, como Perisur y Villa Olímpica junto a
Periférico Sur, o CCH Oriente junto a Constitución de Apatzingán. En el Caso~3
las estaciones del anillo son del Metro y la misma regla solo las une con
líneas del Metro, algo que en este trazo ocurre únicamente en Río de los
Remedios, donde la Línea~B toma como parada a la estación del anillo. Por eso
Periférico Sur, Muyuguarda/Cafetales y Río de los Remedios tienen más
conexiones con el Anillo MB que con el Anillo Metro.
```

```latex
\subsubsection{Caso~2: Anillo MB}

En el Caso~2 se suman 99 nodos con tres o más conexiones: las 94 estaciones del
anillo y cinco paradas de Corredores Concesionados sobre el Periférico que, al
enlazarse con ellas, dejan de estar casi aisladas. Como se observa en la
Figura~\ref{fig:anillo-fc-mb}, el cambio queda sobre el trazo y no altera el
patrón de la red, cuyos nodos con más conexiones siguen en la Calzada de
Tlalpan. Las estaciones del anillo con más conexiones están en el oriente y el
poniente: Constitución de Apatzingán, en Iztapalapa, y Desierto de los Leones y
Tarasquillo, en Álvaro Obregón. Alrededor del anillo, 142 nodos existentes
ganan conexiones; 17 pasan del rango de 3 a 12 al de 13 a 21, y tres paradas
del oriente, entre ellas Periférico--Tepalcates y Calzada Ermita
Iztapalapa--Metro Constitución de 1917, pasan al de 22 a 31.

\begin{figure}[H]
    \centering
    \includegraphics[width=\textwidth]{%
        Figures/Mapas/Qgis_Resources/RedConAnillo/Escenario_MB/Clasificacion_Garibelt/Clasificacion_Garibelt_Fuerza_Capilar_MB}
    \caption[Fuerza Capilar por nodo en el Caso~2]{%
    Fuerza Capilar ($FC$) por nodo en el Caso~2 (Anillo MB). Los rangos de la
    leyenda corresponden a 3--12, 13--21, 22--31 y 32--41 conexiones. La
    nota del mapa da una mediana de 8 porque solo cuenta los nodos con tres o
    más conexiones; la de todos los nodos, que usa el Espectro MJG, es 7.
    Versión a página completa en la Figura~\ref{fig:anx-g-fc-mb}.
    Corrida: 2026-10-04.}
    \label{fig:anillo-fc-mb}
    \fuentefigura{Elaboración propia con \textbf{QGIS};
    datos: \texttt{Apímetro} y \texttt{VFTModel}~\citep{cabrera2025apimetro, cabrera2026VFTModel}.}
\end{figure}

\subsubsection{Caso~3: Anillo Metro}

El Caso~3 da casi el mismo resultado, como se observa en la
Figura~\ref{fig:anillo-fc-metro}. Las estaciones nuevas, las paradas que ganan
conexiones y el patrón de la red son prácticamente los del Caso~2. Entre los
dos casos solo cambia el número de conexiones de 13 nodos, todos sobre el
Periférico o junto a él. Los más visibles son Muyuguarda/Cafetales, en
Xochimilco, y Alameda Oriente, en Venustiano Carranza, que en el Caso~3 tienen
menos conexiones que en el Caso~2 y bajan al rango de 3 a 12. Los nodos
existentes que ganan conexiones son 138, cuatro menos que con el Anillo MB. La
Figura~\ref{fig:anillo-fc-estaciones} compara las estaciones del anillo con más
conexiones en los dos casos.

\begin{figure}[H]
    \centering
    \includegraphics[width=\textwidth]{%
        Figures/Mapas/Qgis_Resources/RedConAnillo/Escenario_Metro/Clasificacion_Garibelt/Clasificacion_Garibelt_Fuerza_Capilar_Metro}
    \caption[Fuerza Capilar por nodo en el Caso~3]{%
    Fuerza Capilar ($FC$) por nodo en el Caso~3 (Anillo Metro). Los rangos de
    la leyenda corresponden a 3--12, 13--21, 22--31 y 32--41 conexiones. La
    nota del mapa da una mediana de 8 porque solo cuenta los nodos con tres o
    más conexiones; la de todos los nodos, que usa el Espectro MJG, es 7.
    Versión a página completa en la Figura~\ref{fig:anx-g-fc-metro}.
    Corrida: 2026-10-04.}
    \label{fig:anillo-fc-metro}
    \fuentefigura{Elaboración propia con \textbf{QGIS};
    datos: \texttt{Apímetro} y \texttt{VFTModel}~\citep{cabrera2025apimetro, cabrera2026VFTModel}.}
\end{figure}

\begin{figure}[H]
    \centering
    \input{Figures/TiKz_Libraries/Diagramas/anillo-fc-estaciones}
    \caption[Estaciones del anillo con más conexiones]{%
    Conexiones de las siete estaciones del \textsc{api-i} con 13 o más en
    alguno de los dos casos. La línea punteada marca la mediana de la red
    (7 conexiones). Corrida: 2026-10-04.}
    \label{fig:anillo-fc-estaciones}
    \fuentefigura{Elaboración propia con datos de \texttt{VFTModel}
    \citep{cabrera2026VFTModel}.}
\end{figure}

\subsubsection{Interpretación por Caso}

\textbf{Caso~2 (Anillo MB).} La mejora es local y pequeña. El anillo agrega 94
puntos de transbordo con pocas conexiones y da dos conexiones más a 142 paradas
de superficie cercanas, sobre todo en el oriente. Ningún nodo empeora, pero
tampoco aparece un nuevo concentrador, y la Fuerza Capilar de la red queda en
0.250, igual que en la red actual.

\textbf{Caso~3 (Anillo Metro).} El efecto es el mismo y un poco menor: 138
paradas ganan conexiones y dos estaciones del anillo quedan con menos
conexiones que en el Caso~2. Cambiar el \brt{} por un Metro no mejora la
alimentación capilar, porque la velocidad, que es lo que separa a los dos
casos, no forma parte de este indicador.
```

---

## 8. §6.3.3 T — hallazgos para otro ítem (#35 / #39), 2026-10-23

La tesis no declara que T sea solo un escalar y en dos sitios promete más:
- `5-4-2-PenalizacionTransferencia.tex:35-36`: «…tiempo de viaje promedio de la red y su distribución territorial» (no existe).
- `1-5-Metodo-Metodologia.tex:139-141`: análisis espacial con «tiempos de traslado elevados» por zona (T no es espacial).
- `1-5:148-152`: compara DI, T y B(v) en los Casos 2–3 (DI quedó fuera del Cap. 6).
- §5.5.1 no declara que T es un valor único sin desglose.
La parte 1 de §6.3.3 ya declara el alcance dentro del Cap. 6. Cálculo opcional de la
distribución de t_ij: prompt entregado al agente de VFTModel (2026-10-23).

### Distribución de T calculada (2026-10-23) — `VFTModel/notebooks/ASSETS/t_distribucion/`
Cuaderno `08_Distribucion_T.ipynb`; controles OK (nodos, aristas y media = T oficial).
- T común (10,610 nodos): 113.91 / 109.21 / 102.40 (−4.70 = −4.1 %; −11.50 = −10.1 %).
- Mediana 99.6 / 96.2 / 89.7 · P90 202.8 / 189.9 / 176.9 · >180 min 14.3 / 11.9 / 9.4 % · máx 595.3 / 578.5 / 552.3.
- Los 10,610 orígenes comunes mejoran en ambos casos (ninguno empeora); Δ mediano −3.1 (MB) / −7.6 (Metro).
- Mayor mejora media por demarcación (MB / Metro): Nezahualcóyotl −43.9 / −59.7 (n=79), Chimalhuacán −31.8 / −44.6 (n=11),
  Ecatepec −30.6 / −38.3 (n=110); Metro también Magdalena Contreras −27.3, Naucalpan −23.6, Tlalpan −20.2.
  Menor: Cuauhtémoc −2.7 / −5.1, Azcapotzalco −2.6 / −4.7 (y municipios con n ≤ 17).
- Implica corregir el último párrafo de la parte 1 (ya no es «solo un escalar»).
