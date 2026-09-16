# Makefile — Tesis de Maestría en Urbanismo, UNAM
# Motor: XeLaTeX + BibTeX (apalike)
# Uso: make <objetivo>  (por defecto: make latexmk)

DOCUMENTO    = tesis
TEXBIN       = $(shell ls -d /Library/TeX/texbin 2>/dev/null || echo /usr/local/bin)
# --shell-escape requerido para TikZ externalization
MOTOR        = $(TEXBIN)/xelatex --shell-escape
BIBTEX       = $(TEXBIN)/bibtex
LATEXMK      = $(TEXBIN)/latexmk

# Opciones de latexmk — la mayoría viven en .latexmkrc;
# aquí solo el mínimo para sobreescribir el modo interactivo.
LATEXMKFLAGS = -interaction=nonstopmode -f

# ──────────────────────────────────────────────────────────────────────────────
# Objetivos principales
# ──────────────────────────────────────────────────────────────────────────────

.PHONY: pdf rapido bib borrador solo compilar-limpio latexmk watch \
        limpiar limpiar-todo tikz-clean \
        formatear formatear-preview \
        checar-bib checar-etiquetas checar-refs ayuda

## pdf: compilación completa manual — XeLaTeX → BibTeX → XeLaTeX × 2
pdf:
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex || true
	$(BIBTEX) $(DOCUMENTO)
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex || true
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex

## rapido: Una pasada de XeLaTeX (cambios menores sin bibliografía)
rapido:
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex || true

## borrador: sin imágenes (~3× más rápido) — figuras como cajas vacías
borrador:
	$(MOTOR) -interaction=nonstopmode \
	  "\def\borrador{}\input{$(DOCUMENTO)}" || true
	$(MOTOR) -interaction=nonstopmode \
	  "\def\borrador{}\input{$(DOCUMENTO)}"

## solo: compilar un capítulo — uso: make solo CAP=6-Analisis.../1-Analisis
CAP ?=
solo:
	@if [ -z "$(CAP)" ]; then \
	  echo "Uso: make solo CAP=<ruta/archivo>"; \
	  echo "Ejemplo: make solo CAP=6-Analisis-SocioEspacial/1-Analisis"; \
	  exit 1; \
	fi
	$(MOTOR) -interaction=nonstopmode \
	  "\def\SoloCapitulo{$(CAP)}\input{$(DOCUMENTO)}" || true
	$(MOTOR) -interaction=nonstopmode \
	  "\def\SoloCapitulo{$(CAP)}\input{$(DOCUMENTO)}"

## bib: regenerar bibliografía — usar tras limpiar-todo o agregar citas
bib:
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex || true
	$(BIBTEX) $(DOCUMENTO)
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex || true
	$(MOTOR) -interaction=nonstopmode $(DOCUMENTO).tex

## latexmk: compilación automática multi-pasada (uso diario, config en .latexmkrc)
latexmk:
	$(LATEXMK) $(LATEXMKFLAGS) $(DOCUMENTO).tex

## compilar-limpio: limpiar todo y recompilar (XDV corrupto / cambios estructurales)
compilar-limpio: limpiar-todo bib

## watch: Recompila automáticamente al detectar cambios en .tex
watch:
	$(LATEXMK) $(LATEXMKFLAGS) -pvc $(DOCUMENTO).tex

# ──────────────────────────────────────────────────────────────────────────────
# Herramientas de verificación
# ──────────────────────────────────────────────────────────────────────────────

## checar-bib: Citas usadas en el documento vs. entradas en referencias.bib
checar-bib:
	@echo "── Claves citadas en el documento ──"
	@grep -rh '\\citet{\|\\citep{' --include="*.tex" . \
		| grep -oP '(?<=\{)[^}]+' | sort | uniq
	@echo ""
	@echo "── Claves definidas en referencias.bib ──"
	@grep -oP '(?<=@\w{2,20}\{)[^,]+' referencias.bib | sort | uniq

## checar-etiquetas: Detectar \label duplicados en todos los .tex
checar-etiquetas:
	@echo "── Labels duplicados ──"
	@grep -rn '\\label{' --include="*.tex" . \
		| grep -oP '(?<=\\label\{)[^}]+' \
		| sort | uniq -d \
		| while read l; do \
			echo "DUPLICADO: $$l"; \
			grep -rn "\\\\label{$$l}" --include="*.tex" .; \
		done
	@echo "Revisión completa."

## checar-refs: Detectar \ref o \eqref sin \label correspondiente
checar-refs:
	@echo "── Referencias sin label definido ──"
	@refs=$$(grep -rh '\\ref{\|\\eqref{' --include="*.tex" . \
		| grep -oP '(?<=\{)[^}]+' | sort | uniq); \
	labels=$$(grep -rh '\\label{' --include="*.tex" . \
		| grep -oP '(?<=\{)[^}]+' | sort | uniq); \
	for r in $$refs; do \
		echo "$$labels" | grep -qx "$$r" || echo "SIN LABEL: $$r"; \
	done

# ──────────────────────────────────────────────────────────────────────────────
# Formateo de prosa
# ──────────────────────────────────────────────────────────────────────────────

## formatear: word-wrap prosa a 80 cols — uso: make formatear CAP=ruta/arch.tex
formatear:
	@python3.10 tools/formatter.py $(if $(CAP),--cap $(CAP),)

## formatear-preview: ver qué cambiaría el formateo sin modificar archivos
formatear-preview:
	@python3.10 tools/formatter.py $(if $(CAP),--cap $(CAP),) --dry-run

# ──────────────────────────────────────────────────────────────────────────────
# Limpieza
# ──────────────────────────────────────────────────────────────────────────────

## limpiar: eliminar artefactos de compilación (conserva el PDF)
limpiar:
	$(LATEXMK) -c $(DOCUMENTO).tex || true
	@rm -f $(DOCUMENTO).brf  $(DOCUMENTO).run.xml \
	        $(DOCUMENTO).idx  $(DOCUMENTO).ilg  $(DOCUMENTO).ind \
	        $(DOCUMENTO).blg  $(DOCUMENTO).bbl  $(DOCUMENTO).xdv

## limpiar-todo: eliminar artefactos y el PDF
limpiar-todo:
	$(LATEXMK) -C $(DOCUMENTO).tex || true
	@rm -f $(DOCUMENTO).brf  $(DOCUMENTO).run.xml \
	        $(DOCUMENTO).idx  $(DOCUMENTO).ilg  $(DOCUMENTO).ind \
	        $(DOCUMENTO).blg  $(DOCUMENTO).bbl  $(DOCUMENTO).xdv

## tikz-clean: eliminar cache TikZ — usar si cambian los diagramas
tikz-clean:
	@rm -f Figures/TiKz_Libraries/externalized/*.pdf \
	       Figures/TiKz_Libraries/externalized/*.md5 \
	       Figures/TiKz_Libraries/externalized/*.log \
	       Figures/TiKz_Libraries/externalized/*.dpth
	@echo "PDFs TikZ eliminados. Próximo make latexmk los regenera."

# ──────────────────────────────────────────────────────────────────────────────
# Ayuda
# ──────────────────────────────────────────────────────────────────────────────

## ayuda: Mostrar esta lista de objetivos
ayuda:
	@echo ""
	@echo "  Tesis Urbanismo UNAM — Comandos disponibles"
	@echo "  ──────────────────────────────────────────────────────────────────"
	@grep -E '^## ' Makefile | sed 's/## /  /' | column -t -s ':'
	@echo ""
	@echo "  Flujos comunes:"
	@echo "    make latexmk                               — uso diario"
	@echo "    make borrador                              — editar prosa (sin imágenes)"
	@echo "    make solo CAP=6-Analisis.../1-Analisis     — compilar solo Cap. 6"
	@echo "    make compilar-limpio                       — después de cambios estructurales"
	@echo "    make tikz-clean && make compilar-limpio    — regenerar diagramas TikZ"
	@echo ""
