# Transportes Anillares y su Importancia en la Ciudad de México y el Área Metropolitana

**Tesis de Maestría en Urbanismo — UNAM, 2026**  
Hernán Galileo Cabrera Garibaldi  
Tutor: Dr. David López Flores

## Descripción

Investigación sobre la viabilidad e impacto de un corredor circular de transporte
público masivo en la sección sur del Anillo Periférico de la Ciudad de México,
analizando su efecto en movilidad, tiempos de traslado e integración territorial
de las alcaldías de Tlalpan, Xochimilco, Tláhuac y Milpa Alta.

## Estructura del repositorio

TesisUrbanismo/
├── tesis.tex                        # Documento principal
├── referencias.bib                  # Base de datos bibliográfica
├── 1-Introduccion/
├── 2-MarcoTeorico/
├── 3-Conceptos-Indicadores/
├── 4-Capas-Codigo/
├── 5-Resultados/
├── 6-Analisis-SocioEspacial/
├── 7-Conclusiones/
├── Figures/                         # Imágenes por capítulo
├── Logos/                           # Logotipos institucionales UNAM
└── Latex/                           # Clases y estilos LaTeX

## Cómo compilar

**Requisitos:** TeX Live 2023+ o MiKTeX, con los paquetes `biblatex`, `biber`,
`xelatex`, `babel-spanish`.

```bash
xelatex tesis.tex
biber tesis
xelatex tesis.tex
xelatex tesis.tex
```

O con `latexmk` (recomendado):

```bash
latexmk -xelatex tesis.tex
```

## Estado actual

| Capítulo                            | Estado          |
| ----------------------------------- | --------------- |
| Cap. 1 — Introducción               | ✅ Completo      |
| Cap. 2 — Marco Teórico              | ✅ Completo      |
| Cap. 3 — Conceptos e Indicadores    | 🔄 En desarrollo |
| Cap. 4 — Arquitectura Computacional | ⬜ Pendiente     |
| Cap. 5 — Resultados                 | ⬜ Pendiente     |
| Cap. 6 — Análisis Socio-Espacial    | ⬜ Pendiente     |
| Cap. 7 — Conclusiones               | ⬜ Pendiente     |

## Proyectos relacionados

- [Apimetro](https://github.com/galigaribaldi/Apimetro) — API backend de análisis
  geoespacial de la red del Metro (Go/Golang)