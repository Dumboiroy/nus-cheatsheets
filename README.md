# NUS Cheatsheets

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

Here be my collections of cheatsheets I made during my undergraduate studies in NUS.

## Building the Cheatsheets

These cheatsheets are LaTeX documents that need to be compiled. See **[BUILD.md](BUILD.md)** for detailed instructions on:

- Installing the required tools (XeLaTeX, Python, Pygments)
- Required LaTeX packages
- Compilation instructions
- Troubleshooting common issues

**Quick start:**
```bash
# Install dependencies (Ubuntu/Debian)
sudo apt-get install texlive-full python3-pygments

# Compile a cheatsheet
xelatex -shell-escape CS1101S/CS1101S-finals.tex
```

For other operating systems and detailed setup instructions, please refer to [BUILD.md](BUILD.md).
