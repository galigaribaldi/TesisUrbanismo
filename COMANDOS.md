# Comandos de Compilación — Tesis Maestría Urbanismo UNAM

Motor: **XeLaTeX + BibTeX** · Archivo raíz: `tesis.tex`
Configuración en: `.latexmkrc` (portable, no editar sin motivo)

---

## Uso diario

| Comando | Qué hace | Tiempo aprox. |
|---|---|---|
| `make latexmk` | Compilación automática multi-pasada. Detecta qué necesita recompilar. **Opción por defecto.** | ~35 seg |
| `make rapido` | Una sola pasada XeLaTeX. Para cambios menores de texto sin citas nuevas. | ~15 seg |
| `make borrador` | Sin imágenes (cajas vacías). Para editar prosa sin esperar gráficos. | ~12 seg |
| `make watch` | Recompila automáticamente al guardar cualquier `.tex`. | continuo |

---

## Compilar un solo capítulo

```bash
make solo CAP=6-Analisis-SocioEspacial/1-Analisis   # Cap. 6
make solo CAP=7-Conclusiones/1-Conclusiones          # Cap. 7
make solo CAP=5-Resultados/1-Resultados              # Cap. 5
make solo CAP=4-Capas-Codigo/4-Capas                 # Cap. 4 completo
make solo CAP=1-Introduccion/1-Introduccion          # Cap. 1 completo
```

> Solo muestra las páginas de ese capítulo (~89 pág. en lugar de ~232).
> Las referencias cruzadas a otros capítulos aparecen como **??** — es normal.
> Si hay citas nuevas, correr `make bib` antes.

---

## Bibliografía y compilación limpia

| Comando | Cuándo usarlo |
|---|---|
| `make bib` | Después de agregar entradas a `referencias.bib` o al cambiar citas en el texto. Regenera `.bbl` desde cero. |
| `make compilar-limpio` | Después de cambios estructurales: nuevos capítulos/anexos, labels movidos, XDV corrupto. Equivale a `limpiar-todo` + `bib`. |
| `make limpiar` | Elimina artefactos de compilación (`.aux`, `.log`, `.xdv`, etc.) pero conserva el PDF. |
| `make limpiar-todo` | Elimina artefactos **y** el PDF. |

---

## Diagramas TikZ

Los diagramas TikZ se guardan como PDFs en `Figures/TiKz_Libraries/externalized/`.
La primera compilación tras un `make compilar-limpio` los genera (~128 seg);
las siguientes los reutilizan (~35 seg).

| Comando | Cuándo usarlo |
|---|---|
| `make tikz-clean` | Cuando se modifica un diagrama TikZ o se agregan diagramas nuevos. Elimina el caché y fuerza regeneración en la próxima compilación. |
| `make tikz-clean && make compilar-limpio` | Flujo completo para regenerar todo desde cero. |

---

## Verificación de integridad

```bash
make checar-bib        # Citas usadas en .tex vs. entradas en referencias.bib
make checar-etiquetas  # Detectar \label duplicados en todo el documento
make checar-refs       # Detectar \ref sin \label correspondiente
```

---

## Formateo de prosa

```bash
make formatear                                      # Todos los capítulos (80 cols)
make formatear CAP=6-Analisis-SocioEspacial/...tex  # Un archivo específico
make formatear-preview                              # Ver cambios sin aplicar
```

---

## Flujos típicos

```bash
# Trabajo diario normal
make latexmk

# Estoy escribiendo solo Cap. 6 y quiero compilar rápido
make solo CAP=6-Analisis-SocioEspacial/1-Analisis

# Estoy editando prosa, no me importan las imágenes
make borrador

# Agregué citas nuevas al .bib
make bib

# Moví capítulos / agregué un Anexo / el PDF no actualiza referencias
make compilar-limpio

# Modifiqué un diagrama TikZ
make tikz-clean && make latexmk

# El XDV está corrupto o algo sale mal
make limpiar-todo && make bib
```

---

## Capítulos disponibles para `make solo`

| Capítulo | CAP= |
|---|---|
| Introducción | `1-Introduccion/1-Introduccion` |
| Marco Teórico | `2-MarcoTeorico/2-MarcoTeorico` |
| Conceptos e Indicadores | `3-Conceptos-Indicadores/3-Conceptos` |
| Capas de Código | `4-Capas-Codigo/4-Capas` |
| Resultados | `5-Resultados/1-Resultados` |
| Análisis Socioespacial | `6-Analisis-SocioEspacial/1-Analisis` |
| Conclusiones | `7-Conclusiones/1-Conclusiones` |
