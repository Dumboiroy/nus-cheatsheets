# Quick Reference: Building NUS Cheatsheets

## TL;DR - What You Need

| Component | Purpose | Installation |
|-----------|---------|--------------|
| **XeLaTeX** | LaTeX compiler | `sudo apt-get install texlive-xetex` (Linux)<br>`brew install --cask mactex` (macOS)<br>Download MiKTeX (Windows) |
| **Python 3** | For syntax highlighting | Usually pre-installed (Linux/macOS)<br>Download from python.org (Windows) |
| **Pygments** | Syntax highlighter for code | `pip install Pygments` |
| **LaTeX Packages** | Various formatting | `sudo apt-get install texlive-full` (Linux)<br>Included in MacTeX (macOS)<br>Auto-installed by MiKTeX (Windows) |

## Compilation Command

```bash
xelatex -shell-escape filename.tex
```

**Important:** The `-shell-escape` flag is required for files that use the `minted` package (most CS modules).

## Which Files Use What?

### Files requiring Pygments (minted package):
- Most CS module cheatsheets (CS1101S, CS2030, CS2040, CS2100, CS2104, CS2105, CS2106, CS3210, CS3243, CS3245, CS4223)

### Files without special requirements:
- MA1521, PC1431, ST2334, CS1231

## Quick Install Commands

### Ubuntu/Debian (Complete Setup)
```bash
sudo apt-get update
sudo apt-get install texlive-full python3-pygments
```

### macOS (Complete Setup)
```bash
brew install --cask mactex
pip3 install Pygments
```

### Windows (MiKTeX)
1. Download and install MiKTeX: https://miktex.org/download
2. Install Python: https://www.python.org/downloads/
3. Run: `python -m pip install Pygments`

## Testing Your Setup

Try compiling a simple cheatsheet:
```bash
cd MA1521
xelatex ma1521-finals.tex
```

If that works, try one with minted:
```bash
cd CS1101S
xelatex -shell-escape CS1101S-finals.tex
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "xelatex: command not found" | Install TeX Live / MiKTeX |
| "pygmentize: command not found" | Install Pygments: `pip install Pygments` |
| "Missing Pygments output" | Add `-shell-escape` flag |
| "Font not found" | Install full TeX distribution or specific font packages |
| "Package X not found" | Install texlive-full or let MiKTeX auto-install |

## Need More Details?

See [BUILD.md](BUILD.md) for comprehensive documentation including:
- Detailed installation instructions for all platforms
- Complete package list
- Editor-specific setup
- Advanced troubleshooting
- Overleaf instructions

## Using Overleaf (No Installation)

1. Upload the .tex file to [Overleaf](https://www.overleaf.com/)
2. Set compiler to **XeLaTeX** (Menu → Compiler)
3. Upload any image files in the same directory
4. Compile!
