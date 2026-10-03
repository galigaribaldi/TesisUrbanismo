#!/usr/bin/env python3
r"""
checar_latex.py — Verificación de integridad LaTeX para Tesis Urbanismo UNAM

Sustituye las reglas checar-* del Makefile basadas en `grep -oP`, que no
funcionan con el grep BSD de macOS.

Revisiones disponibles:
  bib        Claves citadas (\citet, \citep, \citeauthor, ...) que no existen
             en referencias.bib, y entradas de la .bib que nunca se citan.
             También señala usos de \cite{} directo (prohibido en el proyecto).
  etiquetas  \label{} y label= (listings) duplicados.
  refs       \ref, \eqref, \autoref, \pageref, \nameref sin \label definido.
  todo       Las tres anteriores.

Reglas comunes:
  - Se ignora el texto después de un % no escapado (comentarios).
  - Se excluyen Anexos/Notas_Correciones/ y Figures/TiKz_Libraries/externalized/.
  - Las listas separadas por comas (\citep{a,b}, \ref{x,y}) se separan.
  - Cada hallazgo se reporta como archivo:línea.

Código de salida:
  0  sin problemas (las entradas .bib sin usar solo son aviso)
  1  hay claves sin entrada, etiquetas duplicadas o referencias sin label

Uso:
    python3.10 tools/checar_latex.py bib
    python3.10 tools/checar_latex.py etiquetas
    python3.10 tools/checar_latex.py refs
    python3.10 tools/checar_latex.py todo
"""
import re
import sys
from collections import defaultdict
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
BIB = RAIZ / "referencias.bib"
EXCLUIR = ("Anexos/Notas_Correciones", "Figures/TiKz_Libraries/externalized")

RE_COMENTARIO = re.compile(r"(?<!\\)%.*$")
RE_LABEL = re.compile(r"\\label\{([^}]+)\}|\blabel=\{?([^,}\]\s]+)\}?")
RE_REF = re.compile(r"\\(?:ref|eqref|autoref|pageref|nameref)\*?\{([^}]+)\}")
RE_CITA = re.compile(
    r"\\(cite[a-zA-Z]*)\*?(?:\[[^\]]*\]){0,2}\{([^}]+)\}"
)
RE_BIB = re.compile(r"^\s*@(\w+)\s*\{\s*([^,\s]+)\s*,", re.M)


def archivos_tex():
    for p in sorted(RAIZ.rglob("*.tex")):
        rel = p.relative_to(RAIZ).as_posix()
        if not rel.startswith(EXCLUIR):
            yield p, rel


def lineas(path):
    with open(path, encoding="utf-8", errors="ignore") as f:
        for n, linea in enumerate(f, 1):
            yield n, RE_COMENTARIO.sub("", linea)


def separar(lista):
    return [k.strip() for k in lista.split(",") if k.strip()]


def recolectar():
    labels = defaultdict(list)
    refs = []
    citas = []
    cite_directo = []
    for path, rel in archivos_tex():
        for n, linea in lineas(path):
            pos = f"{rel}:{n}"
            for m in RE_LABEL.finditer(linea):
                labels[m.group(1) or m.group(2)].append(pos)
            for m in RE_REF.finditer(linea):
                refs += [(k, pos) for k in separar(m.group(1))]
            for m in RE_CITA.finditer(linea):
                if m.group(1) == "cite":
                    cite_directo.append(pos)
                citas += [(k, pos) for k in separar(m.group(2))]
    return labels, refs, citas, cite_directo


def checar_bib(citas, cite_directo):
    print("── Citas vs. referencias.bib ──")
    texto = BIB.read_text(encoding="utf-8", errors="ignore")
    claves = {k for tipo, k in RE_BIB.findall(texto)
              if tipo.lower() not in ("comment", "string", "preamble")}
    citadas = {k for k, _ in citas}
    faltantes = [(k, pos) for k, pos in citas if k not in claves]
    for k, pos in faltantes:
        print(f"  SIN ENTRADA: {k}  ({pos})")
    for pos in cite_directo:
        print(f"  \\cite{{}} DIRECTO (usar \\citet o \\citep): {pos}")
    sin_usar = sorted(claves - citadas)
    for k in sin_usar:
        print(f"  aviso — entrada sin citar: {k}")
    print(f"  {len(citadas)} claves citadas · {len(claves)} entradas en .bib · "
          f"{len(faltantes)} sin entrada · {len(sin_usar)} sin citar")
    return bool(faltantes or cite_directo)


def checar_etiquetas(labels):
    print("── Labels duplicados ──")
    dup = {k: v for k, v in labels.items() if len(v) > 1}
    for k, posiciones in sorted(dup.items()):
        print(f"  DUPLICADO: {k}")
        for pos in posiciones:
            print(f"    {pos}")
    print(f"  {len(labels)} labels · {len(dup)} duplicados")
    return bool(dup)


def checar_refs(labels, refs):
    print("── Referencias sin label definido ──")
    rotas = [(k, pos) for k, pos in refs if k not in labels]
    for k, pos in rotas:
        print(f"  SIN LABEL: {k}  ({pos})")
    print(f"  {len(refs)} referencias · {len(rotas)} sin label")
    return bool(rotas)


def main():
    modo = sys.argv[1] if len(sys.argv) > 1 else "todo"
    if modo not in ("bib", "etiquetas", "refs", "todo"):
        print(__doc__)
        return 2
    labels, refs, citas, cite_directo = recolectar()
    error = False
    if modo in ("bib", "todo"):
        error |= checar_bib(citas, cite_directo)
    if modo in ("etiquetas", "todo"):
        error |= checar_etiquetas(labels)
    if modo in ("refs", "todo"):
        error |= checar_refs(labels, refs)
    print("Revisión completa." if not error else "Revisión completa — hay problemas.")
    return 1 if error else 0


if __name__ == "__main__":
    sys.exit(main())
