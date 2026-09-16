# .latexmkrc — Tesis Maestría Urbanismo UNAM
# Motor: XeLaTeX + BibTeX (apalike)
# Ubicar en la raíz del repositorio junto a tesis.tex

# --- Motor de compilación ---
$pdf_mode = 5;            # XeLaTeX → XDV → PDF (vía xdvipdfmx)

# --shell-escape requerido para TikZ externalization
$xelatex = 'xelatex --shell-escape -interaction=nonstopmode -file-line-error %O %S';
$xdvipdfmx = 'xdvipdfmx -E -o %D %O %S';

# --- Bibliografía ---
$bibtex_use = 1;          # BibTeX (no biber)

# --- Comportamiento de pasadas ---
# 8 pasadas: necesario para documento con refs cruzadas profundas
# (capítulos → anexos → secciones de resultados → conclusiones)
$max_repeat = 8;

# Continuar aunque xelatex devuelva código 1 (warnings de refs no resueltas
# en primera pasada son normales y no deben detener la compilación)
$force_mode = 1;
