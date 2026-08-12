################################################################################
# File name:    Makefile
# Class:        CS 270
# Purpose:      Python development and assignment PDF generation
#
# printAll generates main.pdf containing:
#   1. Python source code
#   2. Ruff linting results
#   3. Pyright type-checking results
################################################################################

ENSCRIPT_FLAGS=-C -T 4 -p - -M Letter -Epython --color -fCourier8

all: check

check:
	ruff check src/
	pyright src/

fix:
	ruff check --fix src/
	ruff format src/

printAll:
	@echo "Formatting and checking code..."
	@ruff check --fix src/ > /dev/null 2>&1 || true

	@echo "Generating source code PDF..."
	enscript ${ENSCRIPT_FLAGS} src/*.py | ps2pdf - source.pdf

	@echo "Running Ruff and Pyright..."
	@(echo "RUFF RESULTS"; \
	  echo "============"; \
	  ruff check src/ 2>&1 || true) > checks.txt

	@echo "" >> checks.txt
	@echo "PYRIGHT RESULTS" >> checks.txt
	@echo "===============" >> checks.txt
	@pyright src/ >> checks.txt 2>&1 || true

	enscript -p - -M Letter -fCourier8 checks.txt | ps2pdf - checks.pdf

	pdfunite source.pdf checks.pdf main.pdf

	rm -f source.pdf checks.pdf checks.txt

	@echo "Created main.pdf"

clean:
	rm -f *.pdf checks.txt source.pdf checks.pdf
	rm -rf .ruff_cache src/.ruff_cache __pycache__ src/__pycache__ .pytest_cache
