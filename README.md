# Transportes Anillares y su Importancia en la Ciudad de México y el Área Metropolitana

**Tesis de Maestría en Urbanismo — UNAM, 2026**  
Hernán Galileo Cabrera Garibaldi  
Tutor: Dr. David López Flores — Posgrado en Urbanismo, UNAM

[![Compilar Tesis PDF](https://github.com/galigaribaldi/TesisUrbanismo/actions/workflows/compile-tesis.yml/badge.svg)](https://github.com/galigaribaldi/TesisUrbanismo/actions/workflows/compile-tesis.yml)
[![Última versión](https://img.shields.io/github/v/release/galigaribaldi/TesisUrbanismo?include_prereleases&label=versión)](https://github.com/galigaribaldi/TesisUrbanismo/releases)
[![Licencia: CC BY-NC 4.0](https://img.shields.io/badge/Licencia-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

---

## Descripción

La tesis presenta una cadena de herramientas SIG de código abierto y replicable
para medir la estructura de una red de transporte público a partir de datos
abiertos (GTFS y OpenStreetMap), y la aplica a la Zona Metropolitana del Valle
de México (ZMVM).

Como caso de demostración se evalúa el impacto hipotético de un corredor anillar
de alta capacidad sobre el Anillo Periférico de la Ciudad de México, comparando
tres escenarios sobre el mismo grafo multimodal:

| Caso | Escenario |
|---|---|
| Caso 1 | Red actual (*statu quo*) |
| Caso 2 | Anillo MB: autobús de tránsito rápido en vía confinada, con el Mexibús como referencia |
| Caso 3 | Anillo Metro: Metro en vía exclusiva |

Los dos anillos usan el mismo trazo y las mismas 94 estaciones; solo cambia la
operación.

### Indicadores

Nivel de Cobertura (*C*), Fuerza Capilar (*FC*), Factor de Desviación (*DI*),
Coeficiente de Fricción Vial (*CF*), Penalización por Transferencia (*T_b*),
Tiempo de Viaje Promedio (*T*), Centralidad de Intermediación (*B(v)*) y
Vulnerabilidad Estructural (*ΔE*, exploratorio). La **Clasificación Garibelt**
reúne cinco de ellos en un perfil sin agregarlos en un índice único; su
resultado para cada escenario es el **Espectro MJG**.

### Cadena de herramientas

| Capa | Repositorio | Función |
|---|---|---|
| Datos | [Apímetro](https://github.com/galigaribaldi/Apimetro) | Normaliza los GTFS y la información de OpenStreetMap de los doce sistemas de la ZMVM y los sirve como API (Go) |
| Análisis | [VFTModel](https://github.com/galigaribaldi/VFTModel) | Construye el grafo dirigido y ponderado y calcula los indicadores (Python, NetworkX) |
| Visualización | [Transport-gis-zmvm-mjg](https://github.com/galigaribaldi/Transport-gis-zmvm-mjg) | Mapas QGIS y tableros de Tableau a partir de las salidas de las otras dos capas |

---

## Estructura del documento

| Capítulo | Contenido |
|---|---|
| 1 | Introducción: problemática, objetivos, hipótesis, método y metodología |
| 2 | Estado del arte, antecedentes históricos y marco teórico |
| 3 | Conceptos, teoría de grafos e indicadores (incluye la Clasificación Garibelt) |
| 4 | Capas de código: Apímetro, VFTModel y Transport-gis-zmvm-mjg |
| 5 | Análisis de la red actual de la ZMVM y Espectro MJG de línea base |
| 6 | Escenario hipotético: Anillo Periférico de alta capacidad (Casos 2 y 3) |
| 7 | Conclusiones: ejes tecnológico, urbano y académico |
| Anexos A–G | Documentación técnica de las tres herramientas (A–C), implementaciones de indicadores (D), cartografía (E) y recursos visuales de la red actual (F) y de los escenarios (G) |

## Estructura del repositorio

```
tesis.tex                    # Documento raíz (XeLaTeX)
referencias.bib              # Bibliografía (natbib + apalike, BibTeX)
Latex/Comands.tex            # Paquetes y comandos personalizados
Latex/Colores/               # Paletas de color intercambiables
0-Preliminares/              # Nota sobre esta versión
1-Introduccion/              # Cap. 1
2-MarcoTeorico/              # Cap. 2 — Estado del arte y marco teórico
3-Conceptos-Indicadores/     # Cap. 3
4-Capas-Codigo/              # Cap. 4
5-Analisis-Red-Actual/       # Cap. 5
6-Analisis-Red-Anillo/       # Cap. 6
7-Conclusiones/              # Cap. 7
8-Glosario/                  # Glosario (en preparación, aún no se incluye)
Anexos/                      # Anexos A–G y notas de revisión
Figures/                     # Imágenes por capítulo, mapas (QGIS/Tableau) y diagramas TikZ
Logos/                       # Logotipos institucionales
tools/                       # Verificador de citas/labels/refs y formateador de prosa
.github/workflows/           # CI: compilación del PDF y publicación del release
```

Las imágenes se guardan con **Git LFS**. Para clonar con las imágenes completas:

```bash
git lfs install
git clone git@github.com:galigaribaldi/TesisUrbanismo.git
```

---

## Cómo compilar localmente

**Requisitos:** TeX Live 2023 o posterior con XeLaTeX, BibTeX y latexmk; Git LFS;
Python 3.10 o posterior para las herramientas de `tools/`. La compilación usa
`--shell-escape` porque los diagramas TikZ se externalizan.

### Con Make (recomendado)

| Comando | Descripción |
|---|---|
| `make pdf` | Compilación completa (XeLaTeX → BibTeX → XeLaTeX × 2) |
| `make latexmk` | Compilación automática con latexmk (uso diario) |
| `make rapido` | Una pasada, para cambios menores sin citas nuevas |
| `make borrador` | Sin imágenes (cajas vacías), para editar prosa |
| `make solo CAP=<ruta>` | Compila un solo capítulo en `tesis_<carpeta>.pdf` |
| `make bib` | Regenera la bibliografía tras modificar `referencias.bib` |
| `make compilar-limpio` | Limpia todo y recompila (cambios estructurales) |
| `make watch` | Recompila al guardar cualquier `.tex` |
| `make tikz-clean` | Borra el caché de diagramas TikZ externalizados |
| `make checar` | Verifica citas, labels duplicados y referencias sin label |
| `make formatear` | Ajusta la prosa a ~80 columnas sin tocar entornos LaTeX |
| `make limpiar` / `make limpiar-todo` | Borra artefactos (y el PDF) |
| `make ayuda` | Muestra la lista completa |

La referencia detallada de comandos está en [`COMANDOS.md`](COMANDOS.md).

### Sin Make

```bash
latexmk tesis.tex          # usa la configuración de .latexmkrc
```

Manualmente:

```bash
xelatex --shell-escape tesis.tex
bibtex tesis
xelatex --shell-escape tesis.tex
xelatex --shell-escape tesis.tex
```

---

## Estado

| Capítulo | Estado |
|---|---|
| Caps. 1–7 | Completos (borrador Alfa) |
| Anexos A–G | Completos |
| Glosario (`8-Glosario/`) | En preparación |

Las observaciones pendientes del comité se siguen en los
[issues](https://github.com/galigaribaldi/TesisUrbanismo/issues).

---

## Ramas y versiones

| Rama | Propósito |
|---|---|
| `Feature-version-alpha` | Trabajo activo: correcciones, capítulos y figuras |
| `main` | Versiones estables; se actualiza con *fast-forward* desde la rama de trabajo |

Cada tag `v*` dispara el workflow que compila la tesis y publica el PDF en
[Releases](https://github.com/galigaribaldi/TesisUrbanismo/releases). Los tags
con guion (por ejemplo, `v-alfa`) se publican como *pre-release*.

| Tag | Significado |
|---|---|
| `v0.X.Y` | Borradores por capítulos completados |
| `v-alfa` | Borrador Alfa: documento completo para el tutor (noviembre 2026) |
| `v1.0.0` | Primera entrega formal al comité |
| `v1.X.0` | Revisiones posteriores a dictamen |
| `v2.0.0` | Versión final aprobada |
