################################################################################
# File name:    Makefile
# Author:       chadd williams
# Date:         5/14/2025
# Class:        CS 170
# Assignment:   01Lab
# Purpose:      Demonstrate Codespaces & Python
# Hours:        1.5
################################################################################

ENSCRIPT_FLAGS=-C -T 4 -p - -M Letter -Epython --color -fCourier8

all:

printAll:
	enscript ${ENSCRIPT_FLAGS} src/main.py | ps2pdf - main.pdf
