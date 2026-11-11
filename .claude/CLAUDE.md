# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

# CLAUDE.md — Instrucciones para la Tesis de Maestría
## Proyecto: Transportes Anillares y su Importancia en la CDMX
**Autor:** Hernán Galileo Cabrera Garibaldi  
**Programa:** Maestría en Urbanismo, UNAM  
**Motor de compilación:** XeLaTeX + BibTeX

---

## Compilación y herramientas

### Compilar el documento

```bash
make pdf          # Compilación completa: XeLaTeX → BibTeX → XeLaTeX × 2
make rapido       # Una sola pasada (para cambios menores, sin bibliografía)
make latexmk      # Compilación automática con latexmk (maneja las pasadas)
make bib          # Sólo bibliografía: XeLaTeX → BibTeX → XeLaTeX
make watch        # Compilación continua al detectar cambios en .tex
make borrador     # Sin imágenes, para editar prosa
make solo CAP=6-Analisis-Red-Anillo/1-Analisis-Red-Anillo  # un capítulo → tesis_<carpeta>.pdf
make compilar-limpio  # limpiar-todo + bib (cambios estructurales)
make tikz-clean   # Borra el caché de TikZ externalizado
make limpiar      # Elimina artefactos de compilación (conserva el PDF)
make limpiar-todo # Elimina artefactos y el PDF
```

Referencia completa en `COMANDOS.md`. El CI (`.github/workflows/compile-tesis.yml`)
compila y publica el PDF en Releases con cada tag `v*`; corre en Linux, así que
las rutas de `\includegraphics` y las extensiones de `.gitattributes` (Git LFS)
deben coincidir en mayúsculas.

### Herramienta de formateo de prosa (`tools/formatter.py`)

Reformatea líneas de prosa largas a ~80 columnas respetando todos los comandos LaTeX. **No modifica** entornos estructurados (tabular, equation, tikzpicture, lstlisting, etc.) ni líneas de comandos (`\section`, `\label`, `\caption`, etc.).

```bash
make formatear                                      # todos los capítulos
make formatear CAP=2-MarcoTeorico/2-3-Marco-Teorico/2-3-1-Dispersion.tex  # un archivo
make formatear-preview                              # ver qué cambiaría (sin modificar)
```

### Verificación de integridad LaTeX

```bash
make checar             # Las tres verificaciones
make checar-bib         # Entradas huérfanas o sin usar en referencias.bib
make checar-etiquetas   # Labels duplicados en todos los .tex
make checar-refs        # \ref/\eqref/\autoref/\pageref sin \label (ignora \ref{#1} de macros)
```

### Paletas de color disponibles

En `Latex/Colores/` hay cinco paletas intercambiables que se aplican vía `\input{}` en `Comands.tex`:

| Archivo | Paleta activa |
|---|---|
| `Institucional.tex` | Azul UNAM (`unamAzul`) + Oro UNAM (`unamOro`) |
| `Purpura.tex` | Purpura + Dorado |
| `Rojo.tex` | Rojo + Ocre |
| `Teal.tex` | Teal + Naranja |
| `VerdeOlivo.tex` | Verde olivo + Terracota |

Solo se carga una a la vez en `Comands.tex`. Los nombres `unamAzul` / `unamOro` son los tokens que usa `\hypersetup` — cualquier paleta que se active debe exportar esos dos nombres.

### Figuras y mapas

- `Figures/Cap1/`, `Figures/Cap3/` … `Figures/Cap6/` → imágenes por capítulo (en Git LFS).
- `Figures/Mapas/Qgis_Resources/` y `Figures/Mapas/Tableau_Resources/` → mapas y tableros
  exportados desde `Transport-gis-zmvm-mjg`, en subcarpetas `RedActual/`, `RedConAnillo/` y
  `Comparativo_CG/` (no modificar manualmente; las gráficas de datos se hacen allá, no en pgfplots).
- `Figures/TiKz_Libraries/` → diagramas TikZ en `Diagramas/` (incluye `Arboles/`), `Mapas/`,
  `Conectores/` y `Decoradores/`; caché en `externalized/`.

---

## Contexto del proyecto

Este es un documento académico institucional de tesis de maestría escrito en LaTeX.
Tiene una estructura modular: el archivo raíz es `tesis.tex`, los paquetes y comandos
personalizados están en `Latex/Comands.tex`, y el contenido está dividido en capítulos
dentro de carpetas numeradas (`1-Introduccion/`, `2-MarcoTeorico/`, etc.).

La bibliografía usa **natbib** con estilo **apalike** y backend **bibtex**, declarada en `referencias.bib`.

---

## Prioridades al revisar o modificar archivos

### 1. Coherencia de paquetes LaTeX (CRÍTICO)
- Todos los paquetes se declaran **exclusivamente** en `Latex/Comands.tex`.
  `tesis.tex` solo contiene: `\documentclass`, paquetes base de idioma/layout/math,
  `\input{Latex/Comands}`, y al final `\usepackage{hyperref}` + `\hypersetup`.
- **Nunca duplicar** `\usepackage`, `\definecolor`, `\lstdefinestyle`, `\captionsetup`
  ni `\newcommand` entre `tesis.tex` y `Comands.tex`.
- El orden de carga importa:
  1. `babel`, `csquotes`
  2. `geometry`, `setspace`, `emptypage`, `microtype`
  3. `graphicx`
  4. `amsmath`, `amsfonts`, `amssymb`, `bm`
  5. `fancyhdr`, `titlesec`, `bookmark`
  6. `natbib`
  7. `\input{Latex/Comands}` ← aquí se cargan xcolor, listings, tikz, caption, etc.
  8. `\usepackage{hyperref}` ← SIEMPRE al final

- Paquetes que DEBEN estar antes de `hyperref`: `titlesec`, `bookmark`, `caption`,
  `subcaption`, `listings`, `natbib`.
- `animate` requiere la opción `[xetex]` porque el motor es XeLaTeX.
- Los colores `unamAzul` y `unamOro` se definen en `Comands.tex` y son usados
  después en `\hypersetup`. No redefinir en ningún otro lugar.

### 2. Ortografía y gramática (ALTO)
- El documento está escrito en **español formal académico mexicano**.
- Revisar tildes, uso de mayúsculas institucionales (UNAM, CDMX, Metro, Metrobús),
  puntuación en listas y enumeraciones.
- Los términos técnicos en inglés van siempre en *cursiva*: \termino{hub},
  \termino{buffer}, \termino{detour factor}.
- Las siglas se introducen expandidas la primera vez: «Sistema de Información
  Geográfica (\gis{})» y después solo con la macro.
- No usar «en base a» — reemplazar por «con base en» o «a partir de».
- No usar «el mismo» / «la misma» como pronombre anafórico en redacción formal.

### 3. Congruencia de redacción (ALTO)
- Nivel de formalidad: académico, tercera persona o primera persona del plural.
  Evitar primera persona singular («yo considero»).
- Cada sección debe tener: introducción contextual → desarrollo → cierre o
  transición al siguiente punto.
- Las figuras y tablas **siempre** van referenciadas en el texto antes de aparecer:
  «como se observa en la Figura~\ref{fig:...}».
- Los pies de figura usan `\fuentefigura{...}` y las citas usan `\citet{}` (textual,
  «Autor (Año)») o `\citep{}` (parentética, «(Autor, Año)») según contexto
  (nunca `\cite{}` directamente).
- Las ecuaciones numeradas siempre tienen una descripción de variables inmediatamente
  después con `\begin{itemize}`.

### 4. Detección de issues LaTeX (ALTO)
Al revisar cualquier archivo `.tex`, reportar si se detecta:
- `\label` duplicados en el documento.
- Referencias con `\ref{}` o `\eqref{}` sin `\label` correspondiente.
- Figuras incluidas con `\includegraphics` cuyo archivo no existe en `Figures/`.
- Citas `\citet{}` o `\citep{}` cuya clave no existe en `referencias.bib`.
- Entornos no cerrados (`\begin` sin `\end`).
- Comandos personalizados usados antes de ser definidos.
- Paquetes cargados con opciones incompatibles con XeLaTeX
  (p. ej., `inputenc`, `fontenc`, `utf8` son innecesarios con XeLaTeX).

---

## Estructura de archivos

```
tesis.tex                    ← Raíz del documento (no agregar paquetes aquí)
Latex/Comands.tex            ← ÚNICO lugar para paquetes y \newcommand
referencias.bib              ← Base de datos bibliográfica (natbib/apalike + bibtex)
1-Introduccion/
2-MarcoTeorico/
0-Preliminares/Nota-Version.tex  ← cuadros de cambios entre versiones
1-Introduccion/              ← Cap. 1 (1-1 … 1-5; 1-6-Sinopsis.tex vacío, sin \input)
2-MarcoTeorico/              ← Cap. 2 «Estado del Arte y Marco Teórico»
  2-1-Estado-Arte/           ← §2.1 (2-1-0 … 2-1-5)
  2-2-Antecedentes/          ← §2.2
  2-3-Marco-Teorico/         ← §2.3
3-Conceptos-Indicadores/     ← Cap. 3 (padre 3-Conceptos.tex)
  3-1-Definiciones/          ← §3.1: 3-1-1-Glosario-Base, 3-1-2-Conceptos-Operativos
  3-2-Grafos-Matematicos/    ← §3.2
  3-3-Indicadores/           ← §3.3: 3-3-0-Intro … 3-3-8-Robustez,
    3-3-9-Clasificacion-Garibelt/  (Fundamento, Instrumento, Ejemplo)
    3-3-10-Resumen.tex
4-Capas-Codigo/              ← Cap. 4 (padre 4-Capas.tex): 4-1-Apimetro/, 4-2-VFTModel/,
                               4-3-Transport-Gis-Mjg/
5-Analisis-Red-Actual/       ← Cap. 5 (padre 1-Analisis-Red-Actual.tex): 5-1, 5-2,
                               5-3-Fase1/, 5-4-Fase2/, 5-5-Fase3/, 5-6-Espectro-MJG/
6-Analisis-Red-Anillo/       ← Cap. 6 (padre 1-Analisis-Red-Anillo.tex): 6-1 … 6-5,
                               6-3-Indicadores-Escenario/
7-Conclusiones/              ← Cap. 7 (padre 1-Conclusiones.tex): 7-1, 7-2, 7-3
8-Glosario/Glosario.tex      ← vacío, con plan en comentarios; aún sin \input
Anexos/                      ← A-Apimetro … G-Visualizaciones-Anillo (+ subcarpetas)
  Notas_Correciones/         ← notas de revisión del asesor y del comité (históricas)
Figures/                     ← Imágenes por capítulo, mapas y TikZ
Logos/                       ← Logos institucionales (PDF y PNG)
tools/                       ← checar_latex.py y formatter.py
```

Cada capítulo de trabajo tiene un `CONTEXTO_*.md` (Caps. 5–7) con decisiones y
bitácora; no se compilan. `CONTEXTO_CAP5.md` y
`5-6-Espectro-MJG/CONTEXTO_CLASIFICACION_GARIBELT.md` son de septiembre y sus
cifras son históricas.

> **Nota:** `5-Resultados/` y `6-Analisis-SocioEspacial/` fueron eliminados el
> 2026-09-19. El contenido fue reescrito en `5-Analisis-Red-Actual/` y
> `6-Analisis-Red-Anillo/`. El historial git los conserva.

---

## Comandos personalizados disponibles

| Macro | Produce | Uso |
|---|---|---|
| `\cdmx` | Ciudad de México | Abreviatura en texto |
| `\zmvm` | Zona Metropolitana del Valle de México | Abreviatura en texto |
| `\gtfs` | GTFS | Sigla formateada |
| `\gis` | GIS | Sigla formateada |
| `\brt` | BRT | Sigla formateada (autobús de tránsito rápido) |
| `\geojson` | GeoJSON | Nombre del formato |
| `\api` | API | Sigla formateada |
| `\dijkstra` | DIJKSTRA | Algoritmo en versalitas |
| `\floyd` | FLOYD-WARSHALL | Algoritmo en versalitas |
| `\termino{x}` | *x* | Término en inglés o primera definición |
| `\fuentefigura{x}` | Fuente: x | Pie de fuente en figuras |
| `\verfigura{label}` | Véase la Figura X (p. N). | Bajo un título de anexo cuya figura flota a otra página |
| `\pendiente{x}` | Nota al margen roja | Solo en borrador |
| `\graficapendiente{x}{y}` | Caja gris de marcador | Gráfica aún no exportada desde Transport-gis |
| `\notaRevision{x}` / `\bajoRevision{x}` | Caja / resaltado azul | Secciones bajo revisión |
| `\peso{i}{j}` | $w_{ij}$ | Peso de arista |
| `\costo{i}{j}` | $c_{ij}$ | Costo de arista |
| `\grafo` | $\mathcal{G}$ | Grafo |
| `\nodos` | $\mathcal{V}$ | Conjunto de nodos |
| `\aristas` | $\mathcal{E}$ | Conjunto de aristas |

---

## Skills activas para este proyecto

Estas skills deben invocarse en los contextos indicados:

| Skill | Cuándo usarla |
|---|---|
| `watermarks-remover:clean-user-facing-text` | Antes de finalizar o entregar cualquier sección de prosa en `.tex`; cuando el usuario pida pulir, limpiar o humanizar el texto |
| `watermarks-remover:remove-ai-marks` | Cuando el usuario pida eliminar marcas de IA, limpiar metadata o hacer invisible el origen del texto |
| `update-config` | Cuando el usuario quiera configurar comportamientos automáticos, permisos o variables en `.claude/settings.json` |
| `init` | Cuando la estructura del proyecto cambie significativamente y se deba actualizar este CLAUDE.md |

---

## Lo que NO hacer

- No agregar `\usepackage` dentro de los archivos de capítulos.
- No usar `\cite{}` directamente — solo `\citet{}` o `\citep{}` (natbib).
- No crear archivos `.md` de documentación salvo que se pida explícitamente.
- No modificar `tesis.aux`, `tesis.bbl`, `tesis.bcf` ni archivos de compilación.
- No insertar paquetes incompatibles con XeLaTeX: `inputenc`, `fontenc`, `t1enc`.
- No cambiar el motor de compilación: siempre XeLaTeX + BibTeX (natbib + apalike).
