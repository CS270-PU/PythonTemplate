# Python Codespace image
#
# Modified for CS270:
#   - Removed Subversion and the custom SVN build script.
#   - Added Ruff for Python formatting and linting.
#   - Added Pyright for command-line static type checking.
#   - Retained enscript/Ghostscript support for generating assignment PDFs.

ARG VARIANT=3-trixie
FROM python:${VARIANT}

# Install system packages needed for producing PDF source listings.
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get purge -y imagemagick imagemagick-6-common || true \
    && apt-get install -y --no-install-recommends \
        enscript \
        ghostscript \
        poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Update Python infrastructure packages and install course development tools.
RUN python3 -m pip install --no-cache-dir --upgrade \
        setuptools==78.1.1 \
        gitpython==3.1.41 \
        jaraco.context==6.1.0 \
        wheel==0.46.2 \
        ruff \
        pyright \
        pytest

# Optional: install project Python packages from requirements.txt.
#
# COPY requirements.txt /tmp/requirements.txt
# RUN python3 -m pip install --no-cache-dir -r /tmp/requirements.txt \
#     && rm /tmp/requirements.txt
