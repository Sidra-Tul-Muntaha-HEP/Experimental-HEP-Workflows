#!/usr/bin/env bash

# Delphes Installation Verification

DELPHES_DIR="${1:-$PWD/Delphes}"

echo "===== Delphes Installation ====="

if [ -f "$DELPHES_DIR/libDelphes.so" ]; then
    echo "Delphes shared library found."
else
    echo "Delphes shared library not found."
fi

echo
echo "===== ROOT Configuration ====="

if command -v root-config >/dev/null 2>&1; then
    root-config --version
else
    echo "ROOT configuration utility not found."
fi

echo
echo "===== Event Readers ====="

for reader in DelphesHepMC2 DelphesHepMC3 DelphesSTDHEP; do
    if [ -x "$DELPHES_DIR/$reader" ]; then
        echo "$reader: Available"
    else
        echo "$reader: Not found"
    fi
done

echo
echo "===== CMS Detector Card ====="

if [ -f "$DELPHES_DIR/cards/delphes_card_CMS.tcl" ]; then
    echo "CMS detector card found."
else
    echo "CMS detector card not found."
fi

echo
echo "Verification completed."
echo "Detector simulation has not been executed."
