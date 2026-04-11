% !TeX program = xelatex
\documentclass[11pt,letterpaper,oneside]{book}

% --- PAQUETES ---
\usepackage[spanish,es-tabla]{babel}
\usepackage{graphicx}
\usepackage{setspace}
\usepackage{geometry} % Para controlar márgenes
\geometry{top=2.5cm, bottom=2.5cm, left=3cm, right=2.5cm}

\begin{document}

% --- PORTADA MANUAL (Estilo UNAM) ---
\begin{titlepage}
    \centering
    {\large \textbf{UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO}} \\
    \vspace{0.3cm}
    {\large \textbf{PROGRAMA DE MAESTRÍA Y DOCTORADO EN URBANISMO}} \\
    \vspace{0.6cm}
    \begin{minipage}{0.3\textwidth}
        \includegraphics[width=2.5cm]{Logos/Escudo-UNAM}
    \end{minipage}
    \hfill
    \begin{minipage}{0.3\textwidth}
        \centering \includegraphics[width=2.5cm]{Logos/Escudo-Facultad}
    \end{minipage}
    \vspace{0.8cm}
    
    {\Large \textbf{Transportes Anillares y su Importancia en la Ciudad de México y el Área Metropolitana}} \\
    \vspace{1.5cm}
    {\large \textbf{TESIS}} \\
    \vspace{0.5cm}
    {QUE PARA OPTAR POR EL GRADO DE:} \\
    {\large \textbf{MAESTRO EN URBANISMO}} \\
    \vspace{1.2cm}
    {PRESENTA:} \\
    {\large \textbf{Hernán Galileo Cabrera Garibaldi}} \\
    \vspace{1.2cm}
    {TUTOR:} \\
    {\large \textbf{Dr. David López Flores}} \\
    \vfill
    {Ciudad Universitaria, CDMX. \hfill 4 de febrero de 2026}
\end{titlepage}

\frontmatter
\tableofcontents

\mainmatter
% Aquí iremos llamando a tus capítulos
\input{0-5-Introduccion/1-Motivation-Structure}

\end{document}