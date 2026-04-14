# Makefile — Tesis de Maestría en Urbanismo, UNAM
# Motor: XeLaTeX + Biber
# Uso: make <objetivo>  (por defecto: make pdf)

DOCUMENTO   = tesis
MOTOR       = xelatex
BIBER       = biber
LATEXMK     = latexmk
LATEXMKFLAGS = -xelatex -interaction=nonstopmode

# ──────────────────────────────────────────────
# Objetivos principales
# ──────────────────────────────────────────────

.PHONY: pdf rapido bib watch limpiar limpiar-todo ayuda

## pdf: Compilación completa (XeLaTeX → Biber → XeLaTeX × 2)
pdf:
	$(MOTOR) $(DOCUMENTO).tex
	$(BIBER) $(DOCUMENTO)
	$(MOTOR) $(DOCUMENTO).tex
	$(MOTOR) $(DOCUMENTO).tex

## rapido: Una sola pasada de XeLaTeX (para revisar cambios menores)
rapido:
	$(MOTOR) $(DOCUMENTO).tex

## latexmk: Compilación automática con latexmk (recomendado, maneja las pasadas)
latexmk:
	$(LATEXMK) $(LATEXMKFLAGS) $(DOCUMENTO).tex

## bib: Compilar solo la bibliografía (útil tras añadir entradas a referencias.bib)
bib:
	$(MOTOR) $(DOCUMENTO).tex
	$(BIBER) $(DOCUMENTO)
	$(MOTOR) $(DOCUMENTO).tex

## watch: Compilación continua; recompila al detectar cambios en cualquier .tex
watch:
	$(LATEXMK) $(LATEXMKFLAGS) -pvc $(DOCUMENTO).tex

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
	@echo "Uso: make [objetivo]"
	@echo ""
	@grep -E '^## ' Makefile | sed 's/## /  /' | column -t -s ':'
	@echo ""
