# Building the NUS Cheatsheets

This document explains how to compile the LaTeX cheatsheets in this repository.

## Required Tools and Versions

### LaTeX Distribution

The cheatsheets are designed to be compiled with **XeLaTeX** (part of the TeX Live or MiKTeX distributions).

**Recommended versions:**
- TeX Live 2017 or later
- MiKTeX 2.9 or later

Some files explicitly specify XeLaTeX with the directive:
```tex
% !TEX TS-program = xelatex
```

### Python and Pygments

Several cheatsheets use the `minted` package for syntax highlighting, which requires:
- Python 3.x
- Pygments library

Install Pygments:
```bash
pip install Pygments
```

Or on Ubuntu/Debian:
```bash
sudo apt-get install python3-pygments
```

## Required LaTeX Packages

All cheatsheets use standard packages that should be available in a full TeX Live installation. The most commonly used packages include:

### Essential packages (used in all/most cheatsheets):
- `geometry` - Page layout customization
- `multicol` - Multi-column layouts
- `tikz` - Graphics and diagrams
- `mdframed` - Framed text boxes
- `kpfonts` - Font package
- `sourcesanspro` - Source Sans Pro font
- `microtype` - Typography improvements
- `enumitem` - Customized lists
- `datetime` - Date formatting
- `lastpage` - Page numbering
- `wrapfig` - Text wrapping around figures

### Code highlighting packages:
- `minted` - Syntax highlighting (requires Pygments)
- `listings` - Alternative code listings

### Math and technical packages:
- `mathtools` - Enhanced math typesetting
- `tabularx` - Enhanced tables
- `hhline` - Table line drawing
- `makecell` - Table cell formatting

### Other packages:
- `tikz` libraries: shapes, positioning, arrows, fit, calc, graphs, graphs.standard, trees
- `verbatim` - Verbatim text
- `etoolbox` - Programming tools
- `ulem` - Underlining
- `chngcntr` - Counter manipulation
- `pgfplots` - Plotting (for MA1521)
- `graphicx` - Graphics inclusion (for CS1231)

## Installation Instructions

### Option 1: Full TeX Live (Recommended for Linux/macOS)

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install texlive-full python3-pygments
```

**macOS (with Homebrew):**
```bash
brew install --cask mactex
pip3 install Pygments
```

**macOS (alternative - BasicTeX):**
```bash
brew install --cask basictex
# Then install required packages with tlmgr:
sudo tlmgr update --self
sudo tlmgr install collection-xetex collection-fontsrecommended \
  kpfonts sourcesanspro minted enumitem datetime mdframed \
  microtype wrapfig lastpage tikz-cd pgf mathtools tabularx \
  makecell hhline listings xcolor fancyvrb framed etoolbox \
  chngcntr ulem fvextra ifplatform xstring lineno pgfplots cancel
```

### Option 2: MiKTeX (Recommended for Windows)

1. Download and install MiKTeX from https://miktex.org/download
2. Install Python and Pygments:
   ```
   python -m pip install Pygments
   ```
3. MiKTeX will automatically prompt to install missing packages on first compile

### Option 3: Overleaf (Online, No Installation Required)

You can upload the .tex files to [Overleaf](https://www.overleaf.com/) and compile them online. Make sure to:
1. Set the compiler to **XeLaTeX** in the project settings
2. Ensure shell-escape is enabled for minted (usually enabled by default on Overleaf)

## Compilation Instructions

### Basic Compilation

For files that use the `minted` package (most CS modules), you need to enable shell-escape:

```bash
xelatex -shell-escape filename.tex
```

For files without `minted`, regular compilation works:
```bash
xelatex filename.tex
```

### Using LaTeX Editors

**TeXShop / TeXworks:**
1. Open the .tex file
2. Select "XeLaTeX" from the typesetting menu
3. Click "Typeset"

**Visual Studio Code (with LaTeX Workshop extension):**
1. Install the LaTeX Workshop extension
2. Open the .tex file
3. The extension will auto-detect XeLaTeX from the `% !TEX TS-program = xelatex` directive
4. Configure shell-escape in settings.json:
```json
"latex-workshop.latex.tools": [
  {
    "name": "xelatex",
    "command": "xelatex",
    "args": [
      "-shell-escape",
      "-synctex=1",
      "-interaction=nonstopmode",
      "-file-line-error",
      "%DOC%"
    ]
  }
]
```

**Texpad:**
1. Open the .tex file
2. The TS-program directive should auto-select XeLaTeX
3. Enable shell-escape in preferences if minted doesn't work

### Compilation Script

Create a simple compilation script `compile.sh`:

```bash
#!/bin/bash
# Compile a cheatsheet with proper settings

if [ $# -eq 0 ]; then
    echo "Usage: ./compile.sh <filename.tex>"
    exit 1
fi

FILENAME="$1"
BASENAME="${FILENAME%.tex}"

# First pass
xelatex -shell-escape -interaction=nonstopmode "$FILENAME"

# Second pass (for references, page numbers, etc.)
xelatex -shell-escape -interaction=nonstopmode "$FILENAME"

# Clean up auxiliary files (optional)
# rm -f "${BASENAME}.aux" "${BASENAME}.log" "${BASENAME}.out"

echo "Compilation complete: ${BASENAME}.pdf"
```

Make it executable:
```bash
chmod +x compile.sh
```

Use it:
```bash
./compile.sh CS1101S/CS1101S-finals.tex
```

## Common Issues and Solutions

### Issue: "minted Error: Missing Pygments output"

**Solution:** Ensure that:
1. Pygments is installed: `pip install Pygments` or `pip3 install Pygments`
2. You're compiling with `-shell-escape` flag
3. Python is in your PATH

### Issue: "Font not found" errors

**Solution:** 
- For TeX Live, ensure you have the font packages installed:
  ```bash
  sudo tlmgr install kpfonts sourcesanspro
  ```
- For MiKTeX, let it auto-install the packages, or use the Package Manager

### Issue: "Package minted Error: You must invoke LaTeX with the -shell-escape flag"

**Solution:** Always compile with the `-shell-escape` flag when using minted:
```bash
xelatex -shell-escape filename.tex
```

### Issue: Compilation is very slow

**Cause:** Multiple columns and complex TikZ graphics can be slow to compile.

**Solution:** 
- Use a faster computer or compile on a more powerful machine
- Consider using `lualatex` instead of `xelatex` (usually faster)
- Draft mode for faster previews: `xelatex -shell-escape -draftmode filename.tex`

### Issue: "Undefined control sequence" errors

**Solution:** Ensure all required packages are installed. The error message usually indicates which package is missing.

## Testing Your Setup

To verify your LaTeX installation is complete, try compiling one of the simpler cheatsheets first:

```bash
cd MA1521
xelatex -shell-escape ma1521-finals.tex
```

If this works, your setup is correct and you can compile any of the cheatsheets.

## Directory Structure

Each module has its own directory with `.tex` source files and associated images:

```
nus-cheatsheets/
├── CS1101S/
│   ├── CS1101S-finals.tex
│   └── screenshot*.png
├── CS1231/
│   └── CS1231-finals.tex
├── CS2030/
│   └── CS2030-final.tex
├── CS2040/
│   └── CS2040-final.tex
├── CS2100/
│   ├── CS2100-final.tex
│   └── CS2100-midterms.tex
└── ...
```

## Additional Notes

- The cheatsheets were originally created between 2017-2019 and tested with TeX Live 2017-2019
- Some cheatsheets use very tight margins (`top=0mm,bottom=1mm,left=0mm,right=1mm`) for maximum content density
- Most cheatsheets are designed for A4 paper in landscape orientation
- Some cheatsheets (like CS1101S) use portrait orientation
- The typical compilation time is 10-30 seconds per cheatsheet, depending on complexity

## Contributing

If you make improvements to the cheatsheets or this build documentation, please consider contributing back to the repository!

## License

See the LICENSE file. The cheatsheets are licensed under CC BY-NC-SA 4.0.
