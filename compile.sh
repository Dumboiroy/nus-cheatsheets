#!/bin/bash
# Compile a LaTeX cheatsheet with proper settings for this repository
# Usage: ./compile.sh <filename.tex>

set -e  # Exit on error

if [ $# -eq 0 ]; then
    echo "Usage: ./compile.sh <filename.tex>"
    echo ""
    echo "Example:"
    echo "  ./compile.sh CS1101S/CS1101S-finals.tex"
    echo ""
    echo "This script will:"
    echo "  1. Check if xelatex and pygmentize are available"
    echo "  2. Compile the document twice (for references)"
    echo "  3. Show the location of the output PDF"
    exit 1
fi

FILENAME="$1"
BASENAME="${FILENAME%.tex}"

# Check if file exists
if [ ! -f "$FILENAME" ]; then
    echo "Error: File '$FILENAME' not found"
    exit 1
fi

# Check if xelatex is available
if ! command -v xelatex &> /dev/null; then
    echo "Error: xelatex not found. Please install TeX Live or MiKTeX."
    echo "See BUILD.md for installation instructions."
    exit 1
fi

# Check if pygmentize is available (for minted package)
if ! command -v pygmentize &> /dev/null; then
    echo "Warning: pygmentize not found. If the document uses the 'minted' package, compilation will fail."
    echo "Install with: pip install Pygments"
    echo ""
fi

echo "Compiling $FILENAME..."
echo ""

# First pass
echo "Pass 1/2..."
xelatex -shell-escape -interaction=nonstopmode "$FILENAME" || {
    echo ""
    echo "Compilation failed. Check the .log file for details:"
    echo "  ${BASENAME}.log"
    exit 1
}

# Second pass (for references, page numbers, etc.)
echo ""
echo "Pass 2/2..."
xelatex -shell-escape -interaction=nonstopmode "$FILENAME" || {
    echo ""
    echo "Second pass failed. Check the .log file for details:"
    echo "  ${BASENAME}.log"
    exit 1
}

echo ""
echo "✓ Compilation successful!"
echo "Output PDF: ${BASENAME}.pdf"

# Optional: Clean up auxiliary files
# Uncomment the lines below if you want to automatically clean up
# echo ""
# echo "Cleaning up auxiliary files..."
# rm -f "${BASENAME}.aux" "${BASENAME}.log" "${BASENAME}.out" "${BASENAME}.toc"
# rm -rf "_minted-${BASENAME}"
