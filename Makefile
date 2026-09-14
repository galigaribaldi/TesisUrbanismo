# Makefile — Tesis de Maestría en Urbanismo, UNAM
# Motor: XeLaTeX + BibTeX (apalike)
# Uso: make <objetivo>  (por defecto: make pdf)

DOCUMENTO    = tesis
TEXBIN       = $(shell ls -d /Library/TeX/texbin 2>/dev/null || echo /usr/local/bin)
MOTOR        = $(TEXBIN)/xelatex
BIBTEX       = $(TEXBIN)/bibtex
LATEXMK      = $(TEXBIN)/latexmk
# -f: fuerza la compilación completa aunque XeLaTeX devuelva código 1
# -bibtex: activa explícitamente el backend BibTeX (no biber)
LATEXMKFLAGS = -xelatex -bibtex -interaction=nonstopmode -f

# ──────────────────────────────────────────────
# Objetivos principales
# ──────────────────────────────────────────────

.PHONY: pdf rapido bib watch limpiar limpiar-todo formatear ayuda

## pdf: Compilación completa (XeLaTeX → BibTeX → XeLaTeX × 2)
pdf:
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex
	$(BIBTEX) $(DOCUMENTO)
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex

## rapido: Una sola pasada de XeLaTeX (para revisar cambios menores, sin bib)
rapido:
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex

## latexmk: Compilación automática con latexmk (usa -f para continuar ante errores no fatales)
latexmk:
	$(LATEXMK) $(LATEXMKFLAGS) $(DOCUMENTO).tex

## bib: Regenerar bibliografía desde cero (úsalo después de limpiar o añadir entradas al .bib)
## Flujo: XeLaTeX → BibTeX → XeLaTeX × 2
bib:
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex
	$(BIBTEX) $(DOCUMENTO)
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex

## watch: Compilación continua; recompila al detectar cambios en cualquier .tex
watch:
	$(LATEXMK) $(LATEXMKFLAGS) -pvc $(DOCUMENTO).tex

## formatear: Word-wrap de prosa a 80 cols (todos los capítulos, in-place)
## formatear CAP=ruta: Word-wrap de un archivo específico (ruta relativa al repo)
CAP ?=
formatear:
	@python3 tools/formatter.py $(if $(CAP),--cap $(CAP),)

## formatear-preview: Mostrar qué líneas se reformatearían sin modificar nada
formatear-preview:
	@python3 tools/formatter.py $(if $(CAP),--cap $(CAP),) --dry-run

## checar-bib: Verificar entradas huérfanas o sin usar en referencias.bib
checar-bib:
	@echo "── Claves citadas en el documento ──"
	@grep -rh '\\textcite{\|\\parencite{' --include="*.tex" . \
		| grep -oP '(?<=\{)[^}]+' | sort | uniq
	@echo ""
	@echo "── Claves definidas en referencias.bib ──"
	@grep -oP '(?<=@\w{2,20}\{)[^,]+' referencias.bib | sort | uniq

## checar-etiquetas: Buscar \label duplicados en todos los .tex
checar-etiquetas:
	@echo "── Labels definidos ──"
	@grep -rn '\\label{' --include="*.tex" . | grep -oP '(?<=\\label\{)[^}]+' \
		| sort | uniq -d | while read l; do \
			echo "DUPLICADO: $$l"; \
			grep -rn "\\\\label{$$l}" --include="*.tex" .; \
		done
	@echo "Revisión completa."

## checar-refs: Buscar \ref o \eqref sin \label correspondiente
checar-refs:
	@echo "── Referencias usadas sin label definido ──"
	@refs=$$(grep -rh '\\ref{\|\\eqref{' --include="*.tex" . \
		| grep -oP '(?<=\{)[^}]+' | sort | uniq); \
	labels=$$(grep -rh '\\label{' --include="*.tex" . \
		| grep -oP '(?<=\{)[^}]+' | sort | uniq); \
	for r in $$refs; do \
		echo "$$labels" | grep -qx "$$r" || echo "SIN LABEL: $$r"; \
	done

# ──────────────────────────────────────────────
# Limpieza
# ──────────────────────────────────────────────

## limpiar: Eliminar artefactos de compilación (conserva el PDF)
limpiar:
	$(LATEXMK) -c $(DOCUMENTO).tex
	@rm -f $(DOCUMENTO).brf $(DOCUMENTO).run.xml \
		$(DOCUMENTO).idx $(DOCUMENTO).ilg $(DOCUMENTO).ind \
		$(DOCUMENTO).blg $(DOCUMENTO).bbl

## limpiar-todo: Eliminar artefactos Y el PDF generado
limpiar-todo:
	$(LATEXMK) -C $(DOCUMENTO).tex
	@rm -f $(DOCUMENTO).brf $(DOCUMENTO).run.xml \
		$(DOCUMENTO).idx $(DOCUMENTO).ilg $(DOCUMENTO).ind \
		$(DOCUMENTO).blg $(DOCUMENTO).bbl

# ──────────────────────────────────────────────
# Ayuda
# ──────────────────────────────────────────────

## ayuda: Mostrar esta lista de objetivos disponibles
ayuda:
	@echo ""
	@echo "  Tesis Urbanismo UNAM — Comandos disponibles"
	@echo "  ─────────────────────────────────────────────────────────────────"
	@grep -E '^## ' Makefile | sed 's/## /  /' | column -t -s ':'
	@echo ""
	@echo "  Ejemplos:"
	@echo "    make formatear CAP=2-MarcoTeorico/1-Antecedentes.tex"
	@echo "    make formatear-preview   # ver qué cambiaría sin modificar"
	@echo ""
