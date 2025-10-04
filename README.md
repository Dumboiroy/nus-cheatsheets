# NUS Cheatsheets

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

Here be my collections of cheatsheets I made during my undergraduate studies in NUS.

## Building the Cheatsheets

These cheatsheets are LaTeX documents that need to be compiled. 

**📖 Documentation:**
- **[QUICKSTART.md](QUICKSTART.md)** - Quick reference for getting started
- **[BUILD.md](BUILD.md)** - Comprehensive build instructions
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Solutions to common problems

**Quick start:**
```bash
# Check if your system is ready
./check-setup.sh

# Install dependencies (Ubuntu/Debian)
sudo apt-get install texlive-full python3-pygments

# Compile a cheatsheet
xelatex -shell-escape CS1101S/CS1101S-finals.tex
```

For other operating systems and detailed setup instructions, please refer to the documentation files above.
