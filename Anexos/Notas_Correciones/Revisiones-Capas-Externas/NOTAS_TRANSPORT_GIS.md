# Notas para Transport-gis-zmvm-mjg — rótulos, corridas y figuras de la tesis

**Abierto:** 2026-11-04 · **Origen:** cierre del Cap. 7 (#23) y preparación de #33 / #34
**Propósito:** archivo raíz de pautas para el agente de `Transport-gis-zmvm-mjg`
(Tableau, QGIS y cuadernos). La tesis fija la pauta de rótulos; Transport-gis
regenera las figuras; después la tesis ajusta los pies.

**Regla de dependencia:** Apímetro → VFTModel (corrida) → Transport-gis (figuras)
→ Tesis (pies y texto). Ninguna figura se rotula con una corrida que no usó.

---

## 1. Convenciones de rótulo de la Clasificación Garibelt (#33)

Decisiones del autor (2026-11-04):

| Clave | Decisión |
|---|---|
| **D33-1** | Los cuatro tramos de la escala se rotulan **solo con números**, sin calificativos. |
| **D33-2** | La palabra **«banda» se sustituye por «intervalo»** en títulos, leyendas y notas. |

**Rótulos de leyenda** (punto decimal, como el resto de la tesis):

| Antes | Después |
|---|---|
| Crítico / critico / crítica | `0.00–0.25` |
| Débil / debil | `0.25–0.50` |
| Aceptable / aceptable | `0.50–0.75` |
| Idóneo / idoneo | `0.75–1.00` |

- Cierre de los intervalos (para la nota de la leyenda, si cabe):
  [0.00, 0.25) · [0.25, 0.50) · [0.50, 0.75) · [0.75, 1.00].
- Se **conserva la rampa de color** actual; solo cambia el texto.
- Títulos y campos: «Banda dominante» → «Intervalo dominante»; «Cambio de
  banda» → «Cambio de intervalo»; «Transición de banda» → «Transición de
  intervalo»; «Escala Garibelt» se conserva.
- Quitar de notas y tooltips frases como «banda crítica», «0.055 — banda
  crítica», «supera la banda Idóneo».
- **Nombres de archivo** con «Banda» (`Clasificacion_Banda_Dominante*`,
  `Comparativo_Garibelt_Cambio_Banda`, `Grafica_Espectro_Transicion_Banda`):
  se pueden conservar. Si se renombran, avisar para cambiar las rutas de
  `\includegraphics` en la tesis.

### Figuras que muestran la escala (verificar todas)

Rutas relativas a `Figures/` del repositorio de la tesis.

**Red actual (Cap. 5 §5.6 y Anexo F)**
- `Mapas/Tableau_Resources/RedActual/Clasificacion_Garibelt/Red_Actual/Dashboard_Espectro_Red_Actual`
- `Mapas/Tableau_Resources/RedActual/Clasificacion_Garibelt/Red_Actual/Dashboard_Betweenness_Red_Actual`
- `Mapas/Tableau_Resources/RedActual/Clasificacion_Garibelt/Red_Actual/Dashboard_KPI_Red_Actual`
- `Mapas/Tableau_Resources/RedActual/Clasificacion_Garibelt/Red_Actual/Dashboard_Clasificacion_Red_Actual`
- `Mapas/Qgis_Resources/RedActual/Clasificacion_Garibelt/Clasificacion_Garibelt_Mapa_Cobertura`
- `Mapas/Qgis_Resources/RedActual/Clasificacion_Garibelt/Clasificacion_Garibelt_Fuerza_Capilar`
- `Mapas/Qgis_Resources/RedActual/Clasificacion_Garibelt/Clasificacion_Garibelt_Betweenness_Centrality`
- `Mapas/Qgis_Resources/RedActual/Clasificacion_Garibelt/Clasificacion_Banda_Dominante`
- `Mapas/Qgis_Resources/RedActual/Mapa_Betweenness` (su pie en §5.5.2 habla de bandas)

**Caso 2 — Anillo MB (Cap. 6 §6.4 y Anexo G)**
- `Mapas/Tableau_Resources/RedConAnillo/Escenario_MB/Dashboard_Espectro_MB`
- `Mapas/Tableau_Resources/RedConAnillo/Escenario_MB/Dashboard_Clasificacion_MB`
- `Mapas/Tableau_Resources/RedConAnillo/Escenario_MB/Dashboard_Betweenness_MB`
- `Mapas/Qgis_Resources/RedConAnillo/Escenario_MB/Clasificacion_Garibelt/Clasificacion_Banda_Dominante_MB`
- `Mapas/Qgis_Resources/RedConAnillo/Escenario_MB/Clasificacion_Garibelt/Clasificacion_Garibelt_Mapa_Cobertura_MB`
- `Mapas/Qgis_Resources/RedConAnillo/Escenario_MB/Clasificacion_Garibelt/Clasificacion_Garibelt_Fuerza_Capilar_MB`
- `Mapas/Qgis_Resources/RedConAnillo/Escenario_MB/Clasificacion_Garibelt/Clasificacion_Garibelt_Betweenness_Centrality_MB`

**Caso 3 — Anillo Metro (Cap. 6 §6.4 y Anexo G)**
- `Mapas/Tableau_Resources/RedConAnillo/Escenario_Metro/Dashboard_Espectro_Metro`
- `Mapas/Tableau_Resources/RedConAnillo/Escenario_Metro/Dashboard_Clasificacion_Metro`
- `Mapas/Tableau_Resources/RedConAnillo/Escenario_Metro/Dashboard_Betweenness_Metro`
- `Mapas/Qgis_Resources/RedConAnillo/Escenario_Metro/Clasificacion_Garibelt/Clasificacion_Banda_Dominante_Metro`
- `Mapas/Qgis_Resources/RedConAnillo/Escenario_Metro/Clasificacion_Garibelt/Clasificacion_Garibelt_Fuerza_Capilar_Metro`
- `Mapas/Qgis_Resources/RedConAnillo/Escenario_Metro/Clasificacion_Garibelt/Clasificacion_Garibelt_Betweenness_Centrality_Metro`

**Comparativos (Cap. 6 §6.4 y Anexo G)**
- `Mapas/Tableau_Resources/Comparativo_CG/Unigrafica_Comparativo_Valor_Normalizado`
- `Mapas/Tableau_Resources/Comparativo_CG/Unigrafica_Comparativo_Extendido`
- `Mapas/Tableau_Resources/Comparativo_CG/Unigrafica_Comparativo_Top_10_bv`
- `Mapas/Tableau_Resources/Comparativo_CG/Dashboard_Comparativo_KPI`
- `Mapas/Qgis_Resources/Comparativo_CG/Comparativo_Garibelt_Cambio_Banda`
- `Mapas/Qgis_Resources/Comparativo_CG/Comparativo_Garibelt_Cobertura`
- `Mapas/Qgis_Resources/Comparativo_CG/Comparativo_Garibelt_Betweenness`
- `Cap6/TiempoViajePromedio/Grafica_Espectro_Transicion_Banda` (cuaderno
  `graficas_cap6.ipynb`)

---

## 2. Corrida vigente en todas las figuras

**Corrida canónica:** `Corrida: 2026-10-04` (VFTModel `4ef4265`). Toda figura
de la tesis debe salir de esa corrida y decirlo así en su pie interno.

### 2.1 Pies de la tesis ya movidos a 2026-10-04 — la imagen aún es de otra corrida

La tesis ya rotula estas figuras con la corrida vigente (2026-11-04); falta
**regenerar la imagen** para que coincida.

| Figura (`\label`) | Archivo | Corrida de la imagen actual | Quién la genera |
|---|---|---|---|
| `fig:mapa-garibelt-cobertura` (§5.6.2) | `Clasificacion_Garibelt_Mapa_Cobertura` | 2026-09-24 | QGIS |
| `fig:mapa-garibelt-capilar` (§5.6.2) | `Clasificacion_Garibelt_Fuerza_Capilar` | 2026-09-24 | QGIS |
| `fig:mapa-garibelt-betweenness` (§5.6.2) | `Clasificacion_Garibelt_Betweenness_Centrality` | 2026-09-24 | QGIS |
| `fig:grafica-top10-estaciones` (§5.5.2) | `Grafica_Apimetro_2026_Top_10_estaciones` | 2026-04-18 | Tableau (datos de Apímetro) |
| `fig:di-caso07` (§5.3.4) | `Figures/Cap5/FactorDesviacion/Mapa/NB04_mapa10_caso07.png` | 2026-04-27 (trazo) | Cuaderno NB04 (verificar si es de VFTModel o de Transport-gis) |

Las tres de §5.6.2 también llevan la escala Garibelt (§1): conviene
regenerarlas una sola vez, con la corrida vigente y los rótulos numéricos.

### 2.2 Datos escritos en la tesis que vienen de corridas anteriores — piden datos de VFTModel, no figuras

No se les cambió la fecha: sus cifras están escritas en LaTeX, y cambiar solo la
fecha haría pasar datos viejos por vigentes. Hacen falta las salidas de la
corrida 2026-10-04 para reescribirlos.

| Dónde | Qué es | Corrida actual | Qué hace falta |
|---|---|---|---|
| `5-3-2-Cobertura.tex:76-…` `tab:cobertura-estructurados` | Top 3 alcaldías por sistema estructurado (área total, área cubierta, C %) | 2026-04-18 | Mismo cuadro con la corrida vigente (*buffer* 800 m) |
| `5-3-2-Cobertura.tex:148-…` `tab:cobertura-superficie` | Top 3 alcaldías por sistema de superficie | 2026-04-18 | Ídem |
| `Anexos/F-Visualizaciones-Analiticas.tex:366-…` `tab:anx-di-corrida-completa` | Los 100 pares O-D del $DI$ (semilla 42) | 2026-09-16 | La tabla de 100 pares de la corrida vigente; hoy no coincide con el Cuadro 5.x (el peor caso 4.42 no aparece) |
| `4-2-4-Grafo.tex:112` y `Anexos/VFTModel-Anexos/B4-Impedancia-Logs.tex` | Registros de construcción del grafo (45,679 aristas) | 2026-04-18 | Logs de la corrida vigente (45,517 aristas) o rotularlos como históricos |

**No se toca:** $\Delta E$ (`5-5-3-Vulnerabilidad.tex:39,56`) sigue como
«corrida exploratoria 2026-09-02» a propósito; no hay corrida vigente de
$\Delta E$ (#39) y así lo dicen el Cap. 5 y el Cap. 7.

---

## 3. Dominio CDMX para la Clasificación Garibelt (#34) — ⚪ FUERA DE ALCANCE

**Decisión del autor (2026-11-04):** no se recalcula la Clasificación Garibelt
para las 16 alcaldías. Se queda en ámbito metropolitano (76 demarcaciones en el
texto; 141 en las figuras, decisión C6-1). **No hay que generar dashboards ni
mapas para la CDMX.** El issue #34 queda abierto con la etiqueta
`fuera-de-alcance`.

Lo único que se conserva del acuerdo es una nota de restricción de datos, que se
redacta en la tesis dentro de #35: los sistemas que operan solo en el Estado de
México no tienen GTFS oficial (el Mexibús y el Mexicable se tomaron de
OpenStreetMap, `Apimetro/db/NOTES.txt:591-597`) y las rutas de superficie de
los municipios no están en los datos. Si se decide que esa nota aparezca también dentro de los dashboards o
mapas metropolitanos, se agregará aquí.

---

## 4. Para VFTModel (no es de Transport-gis, pero alimenta sus figuras)

Detectado el 2026-11-04 al revisar `src/api/main.py` para el Anexo B.

- **Umbral de alta intermediación (D33-3):** hace falta el **percentil 99 de
  $B(v)$** sobre todos los nodos de la componente gigante de la red actual,
  corrida 2026-10-04 (`/api/v1/network/topological/betweenness-centrality`
  con `limit` igual al total de nodos, o desde la caché del ranking). Con esa
  cifra se cierra la entrada nueva del glosario (Cap. 3 §3.1.1).
- **La API devuelve la clave `"banda"`** con valores «crítico / débil /
  aceptable / idóneo» (`summarize_coverage` en
  `src/core/algorithms/composite/network_profile.py:51-57` y `classify_band`
  en `normalization.py`). Si los dashboards leen esa columna, cambiar los
  valores por los intervalos numéricos de §1 (o mapearlos en Tableau).
- **DI — nombres de origen y destino:** como los IDs de nodo son tuplas, el
  campo `Origen`/`Destino` sale como «Punto cerca de <nombre>» y las
  caminatas de primera y última milla quedan en 0.0
  (`detaurFactor/orchestator.py:48-49`, `detaurFactor/engine.py:24-42`).
  Revisar si afecta a las tablas de pares O-D.
- **Ruta del DI:** el código expone `GET /get_detour_factor`; la tesis
  (Cuadro `tab:vft-endpoints`, Anexo B6) la documenta como
  `/topological/detour-factor`. La tesis se corrige al código.

- **Nodo «314 Memorial New's Divine»** (Metrobús, 2 registros, zona norte):
  parece un registro defectuoso de Apímetro. Ya no aparece en el texto de la
  tesis; revisar en la base y en el grafo (sale de #39 el 2026-11-04).

---

## 5. Erratas y rótulos pendientes ya registrados (verificar vigencia)

Acumulados el 2026-10-14 y el 2026-10-18 (ver también los issues #41 y #26).
Con §1, todo lo que hablaba de tildes en «Crítico/Idóneo» queda sustituido
por los rótulos numéricos.

**Red actual**
- «transporte masivo» → «transporte público» en las notas de `Mapa_Fuerza_Capilar`,
  `Mapa_DF`, `Mapa_Betweenness` y `Mapa_Cobertura_Mapa_Calor`.
- «Corredor Concecionado» → «Concesionado» (leyendas con la misma plantilla).
- Hub FC = 130 con tres nombres distintos («Chimalcoyotl–Coapa», «H. Gea
  González · Tlalpan», «Calz. Tlalpan – San Fernando / Hospitales»): fijar uno.
- `Mapa_DF`: símbolo «DF» → «DI»; Tláhuac 3.25 en el polígono y 3.26 en la
  nota; escala «1:300, 000».
- `Mapa_Cobertura_Mapa_Calor`: casilla azul sin etiqueta bajo TroleBús;
  «Mapa de Calor» en el título (es coroplético).
- `Clasificacion_Garibelt_Mapa_Cobertura`: la nota dice «141 demarcaciones»,
  «isócronas peatonales», «102 de 141 con cobertura cero» y «0.055 — banda
  crítica»; con el dominio de 76: 76 demarcaciones, *buffers* de 800 m, 42 de
  60 municipios en cero y C = 0.166 (depende también de #34).
- Títulos «ZMVM 2025» en FC y DF; Betweenness sin año → unificar en 2026.
- `Grafica_VFTModel_2026_Tiempo_Promedio`: leyenda «Measure Names» con campos
  internos; «Referencia CDMX / ideal» → «Referencia del modelo (85 min)».
- `Grafica_VFTModel_2026_Factor_desviacion`: título «…usando Encuesta Origen -
  Destino» (es muestra aleatoria de 100 pares, semilla 42); campo interno
  visible en la leyenda.
- Leyendas: «Vialidades — periferico» → «Periférico».

**Cap. 6**
- Dashboards Espectro: «Espectro Garibelt» → «Espectro MJG».
- «Cᵢ — Alimentación Capilar» / «Fuerza Capilar (C_i)» → «Fuerza Capilar (FC)».
- «Ranking Betweenness Centrality» → «Orden de Centralidad de Intermediación
  B(v)».
- «ref. CDMX: 85.0 min» → «tiempo de referencia del modelo (85 min)».
- `Comparativo_Garibelt_Cambio_Banda`: «ZMVM 2025» → «ZMVM 2026».
- `Propuesta_*_Anillar_Metro` / `_MB`: «Escenario Metro / Metrobús (BRT)» →
  «Caso 3 (Anillo Metro)» / «Caso 2 (Anillo MB)». («Periférico Interior
  Norte/Sur/Oriente/Poniente» no es errata.)
- `Propuesta_Anillar_Extendido_Metro`, cuadrante Sur-Poniente: «…y el Tren
  Ligero operan en la zona» → el Tren Ligero corre en el sur-oriente; verificar.
