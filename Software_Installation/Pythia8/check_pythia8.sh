#!/usr/bin/env bash
set -euo pipefail

# Pythia8 installation and configuration verification

PYTHIA_DIR="${1:-}"

if [[ -z "$PYTHIA_DIR" ]]; then
    echo "Usage: bash check_pythia8.sh /path/to/pythia8"
    exit 2
fi

PYTHIA_CONFIG="$PYTHIA_DIR/bin/pythia8-config"

if [[ ! -x "$PYTHIA_CONFIG" ]]; then
    echo "ERROR: Pythia8 configuration executable not found."
    exit 1
fi

echo "===== Pythia8 Version ====="
"$PYTHIA_CONFIG" --version

echo
echo "===== External Package Support ====="

for package in lhapdf6 hepmc2 gzip; do
    printf "%-10s : " "$package"
    "$PYTHIA_CONFIG" "--with-$package"
done

echo
echo "===== Pythia8 Configuration ====="
"$PYTHIA_CONFIG" --config

echo
echo "Configuration verification completed."
echo "Full event-generation functionality has not been tested."
