# CLAUDE.md — Instrucciones para la Tesis de Maestría
## Proyecto: Transportes Anillares y su Importancia en la CDMX
**Autor:** Hernán Galileo Cabrera Garibaldi  
**Programa:** Maestría en Urbanismo, UNAM  
**Motor de compilación:** XeLaTeX + Biber

---

## Contexto del proyecto

Este es un documento académico institucional de tesis de maestría escrito en LaTeX.
Tiene una estructura modular: el archivo raíz es `tesis.tex`, los paquetes y comandos
personalizados están en `Latex/Comands.tex`, y el contenido está dividido en capítulos
dentro de carpetas numeradas (`1-Introduccion/`, `2-MarcoTeorico/`, etc.).

La bibliografía usa **biblatex con estilo APA** y backend **biber**, declarada en `referencias.bib`.

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
  6. `biblatex`
  7. `\input{Latex/Comands}` ← aquí se cargan xcolor, listings, tikz, caption, etc.
  8. `\usepackage{hyperref}` ← SIEMPRE al final

- Paquetes que DEBEN estar antes de `hyperref`: `titlesec`, `bookmark`, `caption`,
  `subcaption`, `listings`, `biblatex`.
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
- Los pies de figura usan `\fuentefigura{...}` y las citas usan `\textcite{}` o
  `\parencite{}` según contexto (nunca \cite{} directamente).
- Las ecuaciones numeradas siempre tienen una descripción de variables inmediatamente
  después con `\begin{itemize}`.

### 4. Detección de issues LaTeX (ALTO)
Al revisar cualquier archivo `.tex`, reportar si se detecta:
- `\label` duplicados en el documento.
- Referencias con `\ref{}` o `\eqref{}` sin `\label` correspondiente.
- Figuras incluidas con `\includegraphics` cuyo archivo no existe en `Figures/`.
- Citas `\textcite{}` o `\parencite{}` cuya clave no existe en `referencias.bib`.
- Entornos no cerrados (`\begin` sin `\end`).
- Comandos personalizados usados antes de ser definidos.
- Paquetes cargados con opciones incompatibles con XeLaTeX
  (p. ej., `inputenc`, `fontenc`, `utf8` son innecesarios con XeLaTeX).

---

## Estructura de archivos

```
tesis.tex                    ← Raíz del documento (no agregar paquetes aquí)
Latex/Comands.tex            ← ÚNICO lugar para paquetes y \newcommand
referencias.bib              ← Base de datos bibliográfica (estilo APA/biber)
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

## Lo que NO hacer

- No agregar `\usepackage` dentro de los archivos de capítulos.
- No usar `\cite{}` directamente — solo `\textcite{}` o `\parencite{}`.
- No crear archivos `.md` de documentación salvo que se pida explícitamente.
- No modificar `tesis.aux`, `tesis.bbl`, `tesis.bcf` ni archivos de compilación.
- No insertar paquetes incompatibles con XeLaTeX: `inputenc`, `fontenc`, `t1enc`.
- No cambiar el motor de compilación: siempre XeLaTeX + Biber.
