#!/usr/bin/env python3
r"""
formatter.py — Reformateador de prosa LaTeX para Tesis Urbanismo UNAM

Toma archivos .tex de los capítulos con prosa en líneas largas (un párrafo
completo en una sola línea) y los reformatea a ~80 caracteres por línea,
preservando intactos todos los comandos LaTeX y el contenido del texto.

PRIORIDAD MÁXIMA: no se pierde ni modifica una sola palabra del texto.

Reglas de formateo:
  - Dentro de entornos estructurados (tabular, lstlisting, tikzpicture,
    equation, align, etc.) TODO pasa intacto sin excepción.
  - Líneas estructurales pasan intactas (secciones, labels, captions, etc.)
  - Párrafos de prosa: word-wrap al ancho objetivo (default 80)
  - Líneas ya dentro del límite: pasan intactas
  - Líneas en blanco: se preservan (separan párrafos)
  - Comandos LaTeX inline (\textit{}, \parencite{}, etc.) nunca se parten

Carpetas escaneadas (sin argumento):
  [1-7]-*/   →  todos los .tex en capítulos (recursivo)
  Anexos/    →  todos los .tex en anexos (recursivo)

Uso:
    python3 tools/formatter.py
    python3 tools/formatter.py --cap 2-MarcoTeorico/1-Antecedentes.tex
    python3 tools/formatter.py --cap 5-Resultados/5-2-1-Fase1/5-2-1-2-Cobertura.tex
    make formatear
    make formatear CAP=2-MarcoTeorico/1-Antecedentes.tex
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
WIDTH = 80  # columnas objetivo

# Patrones de directorios a escanear (relativos a REPO_ROOT)
CHAPTER_PATTERNS = ['[1-7]-*', 'Anexos']

# Entornos cuyo CONTENIDO pasa intacto (código, tablas, math, gráficos)
_VERBATIM_ENVS = frozenset({
    'lstlisting', 'lstinputlisting',
    'tabular', 'tabularx', 'longtable', 'tabu',
    'tikzpicture',
    'equation', 'equation*',
    'align', 'align*',
    'gather', 'gather*',
    'multline', 'multline*',
    'split', 'cases',
    'verbatim', 'Verbatim',
    'minted',
})

_BEGIN_RE = re.compile(r'^\s*\\begin\{([^}]+)\}')
_END_RE   = re.compile(r'^\s*\\end\{([^}]+)\}')

# Líneas estructurales fuera de entornos que pasan intactas
_STRUCTURAL_RE = re.compile(
    r'^\s*('
    r'%'                                                      # comentarios
    r'|\\(?:chapter|section|subsection|subsubsection)\*?\{'  # encabezados
    r'|\\input\{'                                             # inclusiones
    r'|\\include\{'
    r'|\\includegraphics'                                     # figuras
    r'|\\caption[\[{]'                                        # pies de figura
    r'|\\subcaption[\[{]'
    r'|\\label\{'                                             # etiquetas
    r'|\\fuentefigura\{'                                      # pie de fuente
    r'|\\pendiente\{'                                         # marcadores borrador
    r'|\\bajoRevision'
    r'|\\notaRevision'
    r'|\\clearpage'                                           # saltos y espaciado
    r'|\\newpage'
    r'|\\vspace[\[{]'
    r'|\\hspace[\[{]'
    r'|\\noindent'
    r'|\\setcounter\{'
    r'|\\addtocontents\{'
    r'|\\markboth\{'
    r')'
)


def _split_into_tokens(text: str) -> list[str]:
    r"""
    Divide texto en tokens indivisibles para el word-wrap:
      - Comandos LaTeX con argumento: \cmd[opt]{arg} → token único
      - Comandos LaTeX sin argumento: \ldots, \\, etc.
      - Palabras normales
      - Espacios
    """
    tokens: list[str] = []
    i = 0
    n = len(text)

    while i < n:
        c = text[i]

        if c == '\\':
            j = i + 1
            if j < n and text[j].isalpha():
                while j < n and text[j].isalpha():
                    j += 1
            else:
                j = i + 2  # \\ o \, etc.

            # Absorber espacios tras el nombre del comando
            while j < n and text[j] in ' \t':
                j += 1

            # Absorber argumento opcional [...]
            if j < n and text[j] == '[':
                depth = 0
                while j < n:
                    if text[j] == '[':
                        depth += 1
                    elif text[j] == ']':
                        depth -= 1
                        if depth == 0:
                            j += 1
                            break
                    j += 1
                while j < n and text[j] in ' \t':
                    j += 1

            # Absorber argumento(s) obligatorio(s) {...}
            while j < n and text[j] == '{':
                depth = 0
                while j < n:
                    if text[j] == '{':
                        depth += 1
                    elif text[j] == '}':
                        depth -= 1
                        if depth == 0:
                            j += 1
                            break
                    j += 1
                while j < n and text[j] in ' \t':
                    j += 1
                if j < n and text[j] != '{':
                    break

            tokens.append(text[i:j])
            i = j

        elif c == ' ':
            j = i
            while j < n and text[j] == ' ':
                j += 1
            tokens.append(text[i:j])
            i = j

        else:
            j = i
            while j < n and text[j] not in (' ', '\\'):
                j += 1
            tokens.append(text[i:j])
            i = j

    return tokens


def wrap_prose_line(line: str, width: int = WIDTH) -> str:
    """
    Aplica word-wrap a una línea de prosa larga.
    Devuelve el texto como múltiples líneas (con \\n) respetando width.
    Preserva el newline final si existía.
    """
    had_newline = line.endswith('\n')
    text = line.rstrip('\n').rstrip()

    if len(text) <= width:
        return line

    tokens = _split_into_tokens(text)
    lines: list[str] = []
    current: list[str] = []
    current_len = 0

    for token in tokens:
        tlen = len(token)

        if token.strip() == '':
            if current:
                current.append(token)
                current_len += tlen
        else:
            if current_len + tlen > width and current:
                joined = ''.join(current).rstrip()
                if joined:
                    lines.append(joined)
                current = [token]
                current_len = tlen
            else:
                current.append(token)
                current_len += tlen

    joined = ''.join(current).rstrip()
    if joined:
        lines.append(joined)

    result = '\n'.join(lines)
    if had_newline:
        result += '\n'
    return result


def format_file(path: Path, width: int = WIDTH) -> tuple[bool, int]:
    """
    Reformatea un archivo .tex in-place.
    Devuelve (modificado, líneas_reformateadas).
    """
    original = path.read_text(encoding='utf-8')
    lines = original.splitlines(keepends=True)

    output: list[str] = []
    env_stack: list[str] = []  # entornos verbatim activos anidados
    reformatted = 0

    for line in lines:

        # ── Límite de entorno: \begin{env} / \end{env} ─────────────────
        begin_m = _BEGIN_RE.match(line)
        if begin_m:
            env = begin_m.group(1)
            if env in _VERBATIM_ENVS:
                env_stack.append(env)
            output.append(line)
            continue

        end_m = _END_RE.match(line)
        if end_m:
            env = end_m.group(1)
            if env_stack and env_stack[-1] == env:
                env_stack.pop()
            output.append(line)
            continue

        # ── Dentro de entorno estructurado → intacto ───────────────────
        if env_stack:
            output.append(line)
            continue

        # ── Línea vacía → intacta ──────────────────────────────────────
        stripped = line.rstrip('\n')
        if not stripped.strip():
            output.append(line)
            continue

        # ── Línea estructural → intacta ────────────────────────────────
        if _STRUCTURAL_RE.match(line):
            output.append(line)
            continue

        # ── Línea corta → intacta ──────────────────────────────────────
        if len(stripped) <= width:
            output.append(line)
            continue

        # ── Prosa larga → word-wrap ────────────────────────────────────
        wrapped = wrap_prose_line(line, width)
        if wrapped != line:
            reformatted += 1
        output.append(wrapped)

    result = ''.join(output)
    if result == original:
        return False, 0

    path.write_text(result, encoding='utf-8')
    return True, reformatted


def collect_files(cap_arg: str) -> list[Path]:
    """
    Devuelve la lista de archivos .tex a procesar.
    Sin argumento: todos los capítulos y Anexos.
    Con argumento: el archivo específico indicado.
    """
    if cap_arg:
        target = REPO_ROOT / cap_arg
        if not target.exists():
            print(f'✗  No existe: {target}')
            sys.exit(1)
        return [target]

    files: list[Path] = []
    for pattern in CHAPTER_PATTERNS:
        for chapter_dir in sorted(REPO_ROOT.glob(pattern)):
            if chapter_dir.is_dir():
                files.extend(sorted(chapter_dir.rglob('*.tex')))
    return files


def main() -> None:
    parser = argparse.ArgumentParser(
        description='Reformateador de prosa LaTeX — Tesis Urbanismo UNAM'
    )
    parser.add_argument(
        '--cap',
        default='',
        metavar='RUTA',
        help=(
            'Archivo específico relativo a la raíz del repo '
            '(ej: 2-MarcoTeorico/1-Antecedentes.tex). '
            'Sin argumento se procesan todos los capítulos.'
        )
    )
    parser.add_argument(
        '--width',
        type=int,
        default=WIDTH,
        help=f'Ancho de línea objetivo (default: {WIDTH})'
    )
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Mostrar qué cambiaría sin modificar archivos'
    )
    args = parser.parse_args()

    tex_files = collect_files(args.cap)

    if not tex_files:
        print('✗  No se encontraron archivos .tex para procesar.')
        sys.exit(1)

    total_modified = 0
    for f in tex_files:
        rel = f.relative_to(REPO_ROOT)

        if args.dry_run:
            original = f.read_text(encoding='utf-8')
            # Contar líneas de prosa largas (excluye entornos y estructurales)
            env_stack: list[str] = []
            count = 0
            for line in original.splitlines(keepends=True):
                bm = _BEGIN_RE.match(line)
                if bm:
                    if bm.group(1) in _VERBATIM_ENVS:
                        env_stack.append(bm.group(1))
                    continue
                em = _END_RE.match(line)
                if em:
                    if env_stack and env_stack[-1] == em.group(1):
                        env_stack.pop()
                    continue
                if env_stack:
                    continue
                stripped = line.rstrip('\n')
                if (stripped.strip()
                        and not _STRUCTURAL_RE.match(line)
                        and len(stripped) > args.width):
                    count += 1
            if count:
                print(f'   ~  {rel}  ({count} líneas largas)')
            continue

        modified, count = format_file(f, args.width)
        if modified:
            total_modified += 1
            print(f'   ✓  {rel}  ({count} párrafos reformateados)')
        else:
            print(f'   —  {rel}  (sin cambios)')

    if not args.dry_run:
        if total_modified:
            print(f'\n✓  {total_modified} archivo(s) modificados.')
        else:
            print('\n✓  Todo ya estaba formateado.')


if __name__ == '__main__':
    main()
