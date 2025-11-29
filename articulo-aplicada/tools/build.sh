#!/usr/bin/env bash

# Add TeX Live to PATH (image installs binaries under texdir/bin/x86_64-linuxmusl)
export PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:/opt/texlive/bin:$PATH"

[ -d build ] || mkdir build

# Compile IEEE (biblatex + biber)
echo "[build] Compiling IEEE"
# Limpiar archivos residuales de IEEE que puedan causar problemas de permisos
rm -f build/main_ieee.* 2>/dev/null || true
latexmk -f -file-line-error -outdir=build -xelatex main_ieee.tex
# Ejecutar biber para procesar referencias
biber build/main_ieee 2>/dev/null || true
# Recompilar para incluir referencias
latexmk -f -file-line-error -outdir=build -xelatex main_ieee.tex

# Compile ACM
echo "[build] Compiling ACM"
latexmk -file-line-error -outdir=build -xelatex main_acm.tex
biber build/main_acm 2>/dev/null || true
latexmk -file-line-error -outdir=build -xelatex main_acm.tex

# Compile APA7
echo "[build] Compiling APA7"
latexmk -file-line-error -outdir=build -xelatex main_apa7.tex
biber build/main_apa7 2>/dev/null || true
latexmk -file-line-error -outdir=build -xelatex main_apa7.tex

echo "[build] PDFs available in build/"
