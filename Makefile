################################################################################
# File name:    Makefile
# Class:        CS 270
# Purpose:      Python development and assignment PDF generation
#
# printAll generates output/main.pdf containing:
#   1. Python source code
#   2. Ruff linting results
#   3. Pyright type-checking results
################################################################################

ENSCRIPT_FLAGS=-C -T 4 -p - -M Letter -Epython --color -fCourier8
OUT_DIR=output

all: check

check:
	ruff check src/
	pyright src/

fix:
	ruff check --fix src/
	ruff format src/

printAll:
	@mkdir -p $(OUT_DIR)
	@echo "Formatting and checking code..."
	@ruff check --fix src/ > /dev/null 2>&1 || true

	@echo "Generating source code PDF..."
	enscript ${ENSCRIPT_FLAGS} src/*.py | ps2pdf - $(OUT_DIR)/source.pdf

	@echo "Running Ruff and Pyright..."
	@(echo "RUFF RESULTS"; \
	  echo "============"; \
	  ruff check src/ 2>&1 || true) > $(OUT_DIR)/checks.txt

	@echo "" >> $(OUT_DIR)/checks.txt
	@echo "PYRIGHT RESULTS" >> $(OUT_DIR)/checks.txt
	@echo "===============" >> $(OUT_DIR)/checks.txt
	@pyright src/ >> $(OUT_DIR)/checks.txt 2>&1 || true

	enscript -p - -M Letter -fCourier8 $(OUT_DIR)/checks.txt | ps2pdf - $(OUT_DIR)/checks.pdf

	pdfunite $(OUT_DIR)/source.pdf $(OUT_DIR)/checks.pdf $(OUT_DIR)/main.pdf

	rm -f $(OUT_DIR)/source.pdf $(OUT_DIR)/checks.pdf $(OUT_DIR)/checks.txt

	@echo "Created $(OUT_DIR)/main.pdf"

clean:
	rm -rf $(OUT_DIR)/*
	rm -f *.pdf checks.txt source.pdf checks.pdf
	rm -rf .ruff_cache src/.ruff_cache __pycache__ src/__pycache__ .pytest_cache
