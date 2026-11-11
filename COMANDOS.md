# Comandos de Compilación — Tesis Maestría Urbanismo UNAM

Motor: **XeLaTeX + BibTeX** · Archivo raíz: `tesis.tex`
Configuración en: `.latexmkrc` (portable, no editar sin motivo)

---

## Uso diario

| Comando | Qué hace | Tiempo aprox. |
|---|---|---|
| `make latexmk` | Compilación automática multi-pasada. Detecta qué necesita recompilar. **Opción por defecto.** | ~35 seg |
| `make pdf` | Compilación completa en cuatro pasadas fijas (XeLaTeX → BibTeX → XeLaTeX × 2). La misma secuencia que usa el CI. | ~3–4 min |
| `make rapido` | Una sola pasada XeLaTeX. Para cambios menores de texto sin citas nuevas. | ~15 seg |
| `make borrador` | Sin imágenes (cajas vacías). Para editar prosa sin esperar gráficos. | ~12 seg |
| `make watch` | Recompila automáticamente al guardar cualquier `.tex`. | continuo |

---

## Compilar un solo capítulo

```bash
make solo CAP=6-Analisis-Red-Anillo/1-Analisis-Red-Anillo    # Cap. 6
make solo CAP=7-Conclusiones/1-Conclusiones                  # Cap. 7
make solo CAP=5-Analisis-Red-Actual/1-Analisis-Red-Actual    # Cap. 5
make solo CAP=4-Capas-Codigo/4-Capas                         # Cap. 4
make solo CAP=1-Introduccion/1-Introduccion                  # Cap. 1
```

> Genera `tesis_<carpeta>.pdf` solo con ese capítulo, en lugar del documento
> completo (~372 pág.). Los anexos no se incluyen; la bibliografía sí.
> Las referencias cruzadas a otros capítulos aparecen como **??** — es normal.
> Si hay citas nuevas, correr `make bib` antes.
> `make solo` mueve `tesis.pdf`: correr `make pdf` antes si se necesita el completo.

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
make checar            # Las tres verificaciones de abajo
make checar-bib        # Citas usadas en .tex vs. entradas en referencias.bib
make checar-etiquetas  # Detectar \label duplicados en todo el documento
make checar-refs       # Detectar \ref, \eqref, \autoref y \pageref sin \label
```

---

## Formateo de prosa

```bash
make formatear                                      # Todos los capítulos (80 cols)
make formatear CAP=6-Analisis-Red-Anillo/6-1-Corredor-Anillar.tex  # Un archivo
make formatear-preview                              # Ver cambios sin aplicar
```

---

## Flujos típicos

```bash
# Trabajo diario normal
make latexmk

# Estoy escribiendo solo Cap. 6 y quiero compilar rápido
make solo CAP=6-Analisis-Red-Anillo/1-Analisis-Red-Anillo

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
| Estado del Arte y Marco Teórico | `2-MarcoTeorico/2-MarcoTeorico` |
| Conceptos e Indicadores | `3-Conceptos-Indicadores/3-Conceptos` |
| Capas de Código | `4-Capas-Codigo/4-Capas` |
| Análisis de la Red Actual | `5-Analisis-Red-Actual/1-Analisis-Red-Actual` |
| Escenario Hipotético: Anillo | `6-Analisis-Red-Anillo/1-Analisis-Red-Anillo` |
| Conclusiones | `7-Conclusiones/1-Conclusiones` |

---

## Compilación en GitHub (releases)

Cada tag `v*` dispara `.github/workflows/compile-tesis.yml`, que compila con
latexmk en Linux y publica `tesis.pdf` en Releases (con guion en el nombre →
*pre-release*).

```bash
git tag -a v-alfa -m "Borrador Alfa de la tesis"
git push origin v-alfa
```

- El runner distingue mayúsculas: toda extensión de imagen debe estar en
  `.gitattributes` tal como aparece en el nombre (`*.jpeg` y `*.JPEG` son reglas
  distintas). Comprobar con
  `git -c core.ignorecase=false check-attr filter -- <archivo>`.
- Las rutas de `\includegraphics` deben coincidir en mayúsculas con el archivo.
