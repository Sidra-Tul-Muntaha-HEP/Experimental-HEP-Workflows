#!/usr/bin/env bash

# ROOT and TMVA Installation Verification

set -euo pipefail

echo "===== ROOT Installation ====="

if ! command -v root >/dev/null 2>&1; then
    echo "ERROR: ROOT executable not found."
    echo "Activate the ROOT environment using thisroot.sh."
    exit 1
fi

echo "ROOT executable:"
command -v root

if ! command -v root-config >/dev/null 2>&1; then
    echo "ERROR: root-config not found."
    exit 1
fi

echo
echo "===== ROOT Version ====="
root-config --version

echo
echo "===== ROOT Installation Prefix ====="
root-config --prefix

echo
echo "===== TMVA Verification ====="

TMVA_OUTPUT=$(root -l -b -q -e \
'std::cout << "TMVA library status: " << gSystem->Load("libTMVA") << std::endl;' \
2>&1)

echo "$TMVA_OUTPUT"

if echo "$TMVA_OUTPUT" | grep -Eq 'TMVA library status: [01]([^0-9]|$)'; then
    echo "TMVA library verification successful."
else
    echo "ERROR: TMVA library verification failed."
    exit 1
fi

echo
echo "ROOT and TMVA environment verification completed."
