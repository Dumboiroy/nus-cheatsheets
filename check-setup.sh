#!/bin/bash
# Check if all required tools for compiling NUS cheatsheets are installed

echo "================================================"
echo "NUS Cheatsheets - Build Environment Check"
echo "================================================"
echo ""

all_good=true

# Check XeLaTeX
echo -n "Checking for XeLaTeX... "
if command -v xelatex >/dev/null 2>&1; then
    version=$(xelatex --version 2>&1 | head -1)
    echo "✓ Found"
    echo "  Version: $version"
else
    echo "✗ NOT FOUND"
    echo "  Install: See BUILD.md for installation instructions"
    all_good=false
fi
echo ""

# Check Python
echo -n "Checking for Python 3... "
if command -v python3 >/dev/null 2>&1; then
    version=$(python3 --version 2>&1)
    echo "✓ Found"
    echo "  Version: $version"
elif command -v python >/dev/null 2>&1; then
    version=$(python --version 2>&1)
    if [[ $version == *"Python 3"* ]]; then
        echo "✓ Found (as 'python')"
        echo "  Version: $version"
    else
        echo "⚠ Found Python 2"
        echo "  Python 3 is recommended"
        echo "  Version: $version"
    fi
else
    echo "✗ NOT FOUND"
    echo "  Install: See BUILD.md for installation instructions"
    all_good=false
fi
echo ""

# Check Pygments/pygmentize
echo -n "Checking for Pygments... "
if command -v pygmentize >/dev/null 2>&1; then
    version=$(pygmentize -V 2>&1)
    echo "✓ Found"
    echo "  Version: $version"
else
    echo "✗ NOT FOUND"
    echo "  Install: pip install Pygments"
    echo "  Note: Required for cheatsheets that use code highlighting (minted package)"
    all_good=false
fi
echo ""

# Summary
echo "================================================"
if [ "$all_good" = true ]; then
    echo "✓ All required tools are installed!"
    echo ""
    echo "You can now compile cheatsheets with:"
    echo "  xelatex -shell-escape <filename>.tex"
    echo ""
    echo "Or use the compile script:"
    echo "  ./compile.sh <filename>.tex"
    echo ""
    echo "Example:"
    echo "  ./compile.sh CS1101S/CS1101S-finals.tex"
else
    echo "✗ Some tools are missing"
    echo ""
    echo "Please install the missing tools before compiling."
    echo "See BUILD.md for detailed installation instructions."
    echo ""
    echo "Quick install (Ubuntu/Debian):"
    echo "  sudo apt-get install texlive-xetex python3-pygments"
    echo ""
    echo "Quick install (macOS):"
    echo "  brew install --cask mactex"
    echo "  pip3 install Pygments"
fi
echo "================================================"
