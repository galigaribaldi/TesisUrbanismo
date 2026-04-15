# Transportes Anillares y su Importancia en la Ciudad de México

**Tesis de Maestría en Urbanismo — UNAM, 2026**  
Hernán Galileo Cabrera Garibaldi  
Tutor: Dr. David López Flores — Posgrado en Urbanismo, UNAM

[![Compilar Tesis PDF](https://github.com/galigaribaldi/TesisUrbanismo/actions/workflows/compile-tesis.yml/badge.svg)](https://github.com/galigaribaldi/TesisUrbanismo/actions/workflows/compile-tesis.yml)
[![Última versión](https://img.shields.io/github/v/release/galigaribaldi/TesisUrbanismo?label=versión)](https://github.com/galigaribaldi/TesisUrbanismo/releases/latest)
[![Licencia: CC BY-NC 4.0](https://img.shields.io/badge/Licencia-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

---

## Descripción

Esta investigación analiza la viabilidad e impacto de implementar un **corredor
circular de transporte público masivo** en la Zona Metropolitana del Valle de México
(ZMVM), con la sección sur del Anillo Periférico de la Ciudad de México como caso
de validación central.

La red de transporte de la ZMVM presenta una estructura radial-concéntrica que
concentra los flujos en nodos críticos del núcleo central (Pantitlán, Indios Verdes,
Taxqueña), generando tiempos de traslado superiores a 122 minutos en la periferia
profunda y una elevada vulnerabilidad funcional ante fallas operativas. La hipótesis
central postula que la incorporación de una geometría anillar en el Tercer Contorno
reducirá los indicadores de ineficiencia de la red —Índice de Ruta Directa (*DI*),
Tiempo de Viaje Promedio (*T*) y Centralidad de Intermediación (*B(v)*)—,
demostrable mediante modelado computacional de grafos.

### Metodología

La investigación se estructura en cuatro fases computacionales:

1. **Fase 1 — Construcción del grafo multimodal:** procesamiento de feeds GTFS
   de toda la red de la ZMVM con [Apimetro](https://github.com/galigaribaldi/Apimetro)
   para construir un grafo dirigido y ponderado georreferenciado.
2. **Fase 2 — Análisis de la topología actual:** cálculo de indicadores de
   eficiencia (*DI*, *T*), centralidad de intermediación (*B(v)*) y robustez
   geométrica (*ΔE*) con [VFTModel](https://github.com/galigaribaldi/VFTModel).
3. **Fase 3 — Diagnóstico y simulación de escenarios:** identificación de brechas
   de cobertura y comparación entre la red actual y la red ampliada con el corredor
   anillar propuesto.
4. **Fase 4 — Lineamientos de integración:** recomendaciones operativas y
   tecnológicas derivadas de los resultados del modelo.

---

## Estructura del repositorio

```
tesis.tex                    # Documento raíz (XeLaTeX)
referencias.bib              # Base de datos bibliográfica (APA / Biber)
Latex/Comands.tex            # Paquetes y comandos personalizados
1-Introduccion/              # Cap. 1 — Planteamiento y objetivos
2-MarcoTeorico/              # Cap. 2 — Antecedentes y marco conceptual
3-Conceptos-Indicadores/     # Cap. 3 — Teoría de grafos e indicadores
4-Capas-Codigo/              # Cap. 4 — Arquitectura computacional
5-Resultados/                # Cap. 5 — Resultados del modelo
6-Analisis-SocioEspacial/    # Cap. 6 — Análisis socio-espacial
7-Conclusiones/              # Cap. 7 — Conclusiones y recomendaciones
Figures/                     # Imágenes organizadas por capítulo
Logos/                       # Logotipos institucionales UNAM
.github/workflows/           # CI: compilación automática del PDF
```

---

## Cómo compilar localmente

**Requisitos:** TeX Live 2023+ con XeLaTeX, Biber y los paquetes
`biblatex`, `babel-spanish`, `csquotes`, `tikz`, `listings`, `xcolor`.

### Con Make (recomendado)

El repositorio incluye un `Makefile` con todas las tareas comunes:

| Comando | Descripción |
|---|---|
| `make pdf` | Compilación completa (XeLaTeX → Biber → XeLaTeX × 2) |
| `make rapido` | Una pasada rápida para revisar cambios menores |
| `make latexmk` | Compilación automática con latexmk |
| `make bib` | Recompila tras modificar `referencias.bib` |
| `make watch` | Recompila automáticamente al guardar cualquier `.tex` |
| `make checar-bib` | Lista claves citadas vs. definidas en el `.bib` |
| `make checar-etiquetas` | Detecta `\label{}` duplicados en el documento |
| `make checar-refs` | Detecta `\ref{}` sin `\label` correspondiente |
| `make limpiar` | Borra artefactos de compilación (conserva el PDF) |
| `make limpiar-todo` | Borra artefactos y el PDF generado |
| `make ayuda` | Muestra esta lista en la terminal |

### Sin Make

Con `latexmk`:

```bash
latexmk -xelatex tesis.tex
```

Manualmente:

```bash
xelatex tesis.tex
biber tesis
xelatex tesis.tex
xelatex tesis.tex
```

---

## Estado de redacción

| Capítulo                            | Estado           |
|-------------------------------------|------------------|
| Cap. 1 — Introducción               | Completo         |
| Cap. 2 — Marco Teórico              | Completo         |
| Cap. 3 — Conceptos e Indicadores    | En desarrollo    |
| Cap. 4 — Arquitectura Computacional | Pendiente        |
| Cap. 5 — Resultados                 | Pendiente        |
| Cap. 6 — Análisis Socio-Espacial    | Pendiente        |
| Cap. 7 — Conclusiones               | Pendiente        |

---

## Workflow de ramas y versiones

| Rama          | Propósito |
|---------------|-----------|
| `desarrollo`  | Trabajo activo: correcciones, nuevos capítulos, figuras |
| `main`        | Versiones estables; el PDF se compila y publica aquí vía CI |

Las versiones del documento siguen versionado semántico:

| Tag        | Significado |
|------------|-------------|
| `v0.X.0`   | Borradores por capítulos completados |
| `v1.0.0`   | Primera entrega formal al comité |
| `v1.X.0`   | Revisiones posteriores a dictamen |
| `v2.0.0`   | Versión final aprobada |

El PDF de cada versión se publica automáticamente en
[Releases](https://github.com/galigaribaldi/TesisUrbanismo/releases).

---

## Proyectos relacionados

- [Apimetro](https://github.com/galigaribaldi/Apimetro) — API backend de análisis
  geoespacial de la red del Metro (Go/Golang); fuente de datos para el Cap. 4
- [VFTModel](https://github.com/galigaribaldi/VFTModel) — modelo computacional de
  evaluación de frecuencia y tiempos de viaje en redes de transporte; base del
  análisis cuantitativo del Cap. 4 y Cap. 5
