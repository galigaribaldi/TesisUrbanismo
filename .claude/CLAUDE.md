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
make limpiar      # Elimina artefactos de compilación (conserva el PDF)
make limpiar-todo # Elimina artefactos y el PDF
```

### Herramienta de formateo de prosa (`tools/formatter.py`)

Reformatea líneas de prosa largas a ~80 columnas respetando todos los comandos LaTeX. **No modifica** entornos estructurados (tabular, equation, tikzpicture, lstlisting, etc.) ni líneas de comandos (`\section`, `\label`, `\caption`, etc.).

```bash
make formatear                                      # todos los capítulos
make formatear CAP=2-MarcoTeorico/2-1-Apertura.tex  # un archivo específico
make formatear-preview                              # ver qué cambiaría (sin modificar)
```

### Verificación de integridad LaTeX

```bash
make checar-bib         # Entradas huérfanas o sin usar en referencias.bib
make checar-etiquetas   # Labels duplicados en todos los .tex
make checar-refs        # \ref/\eqref sin \label correspondiente
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

- `Figures/Cap1/`, `Figures/Cap3/`, `Figures/Cap4/`, `Figures/Cap5/` → imágenes por capítulo.
- `Figures/Mapas/` → 5 PDFs de mapas generados por la herramienta GIS (no modificar manualmente).
- `Figures/TiKz_Libraries/` → diagramas vectoriales TikZ organizados en subcarpetas `Diagramas/`, `Arboles/`, `Mapas/`, `Conectores/`, `Decoradores/`.

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
3-Conceptos-Indicadores/
  3-1-Definiciones.tex
  3-2-Grafos-Matematicas.tex
  3-3-Indicadores-Formula.tex
4-Capas-Codigo/
5-Resultados/
6-Analisis-SocioEspacial/
7-Conclusiones/
Figures/Cap2/, Figures/Cap3/ ← Imágenes por capítulo
Logos/                       ← Logos institucionales (PDF y PNG)
```

---

## Comandos personalizados disponibles

| Macro | Produce | Uso |
|---|---|---|
| `\cdmx` | Ciudad de México | Abreviatura en texto |
| `\zmvm` | Zona Metropolitana del Valle de México | Abreviatura en texto |
| `\gtfs` | GTFS | Sigla formateada |
| `\gis` | GIS | Sigla formateada |
| `\api` | API | Sigla formateada |
| `\dijkstra` | DIJKSTRA | Algoritmo en versalitas |
| `\floyd` | FLOYD-WARSHALL | Algoritmo en versalitas |
| `\termino{x}` | *x* | Término en inglés o primera definición |
| `\fuentefigura{x}` | Fuente: x | Pie de fuente en figuras |
| `\pendiente{x}` | Nota al margen roja | Solo en borrador |
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
- No usar `\cite{}` directamente — solo `\textcite{}` o `\parencite{}`.
- No crear archivos `.md` de documentación salvo que se pida explícitamente.
- No modificar `tesis.aux`, `tesis.bbl`, `tesis.bcf` ni archivos de compilación.
- No insertar paquetes incompatibles con XeLaTeX: `inputenc`, `fontenc`, `t1enc`.
- No cambiar el motor de compilación: siempre XeLaTeX + Biber.
