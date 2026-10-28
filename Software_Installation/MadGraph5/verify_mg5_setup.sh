#!/usr/bin/env bash
# Read-only checks for a MadGraph5_aMC@NLO Linux installation.
# Usage: bash verify_mg5_setup.sh /path/to/MG5_aMC_directory
# If no path is given, the current directory is checked.

set -u
MG5_DIR="${1:-$PWD}"

printf '\n=== MG5_aMC environment check ===\n'
printf 'Directory: %s\n\n' "$MG5_DIR"

if command -v lsb_release >/dev/null 2>&1; then
    printf 'OS: '; lsb_release -ds 2>/dev/null || true
elif [[ -r /etc/os-release ]]; then
    . /etc/os-release
    printf 'OS: %s\n' "${PRETTY_NAME:-unknown}"
fi

for tool in python3 gcc g++ gfortran; do
    if command -v "$tool" >/dev/null 2>&1; then
        case "$tool" in
            python3) printf 'Python: '; python3 --version 2>&1 ;;
            gcc) printf 'GCC: '; gcc -dumpfullversion -dumpversion ;;
            g++) printf 'G++: '; g++ -dumpfullversion -dumpversion ;;
            gfortran) printf 'GFortran: '; gfortran -dumpfullversion -dumpversion ;;
        esac
    else
        printf '%s: not found in PATH\n' "$tool"
    fi
done

printf '\n=== MG5_aMC ===\n'
if [[ -f "$MG5_DIR/bin/mg5_aMC" ]]; then
    printf 'MG5_aMC launcher found: %s\n' "$MG5_DIR/bin/mg5_aMC"
    if [[ -r "$MG5_DIR/VERSION" ]]; then
        printf 'VERSION file: '
        head -n 5 "$MG5_DIR/VERSION"
    fi
    printf 'Note: startup not executed by this read-only script.\n'
else
    printf 'MG5_aMC launcher not found at the specified directory.\n'
    printf 'Usage: bash verify_mg5_setup.sh /path/to/MG5_aMC_directory\n'
fi

printf '\n=== Optional tools ===\n'

find_config() {
    local cmd="$1"
    shift
    local candidate
    for candidate in "$@"; do
        if [[ -x "$candidate" ]]; then
            printf '%s\n' "$candidate"
            return 0
        fi
    done
    command -v "$cmd" 2>/dev/null || return 1
}

pythia_cfg="$(find_config pythia8-config "$MG5_DIR/HEPTools/pythia8/bin/pythia8-config" || true)"
if [[ -n "$pythia_cfg" ]]; then
    printf 'Pythia8: '
    "$pythia_cfg" --version 2>&1 || printf 'version query failed\n'
else
    printf 'Pythia8: pythia8-config not found\n'
fi

lhapdf_cfg="$(find_config lhapdf-config \
    "$MG5_DIR/HEPTools/lhapdf6_py3/bin/lhapdf-config" \
    "$MG5_DIR/HEPTools/lhapdf6/bin/lhapdf-config" || true)"
if [[ -n "$lhapdf_cfg" ]]; then
    printf 'LHAPDF6: '
    "$lhapdf_cfg" --version 2>&1 || printf 'version query failed\n'
else
    printf 'LHAPDF6: lhapdf-config not found\n'
fi

if [[ -f "$MG5_DIR/Delphes/libDelphes.so" ]]; then
    printf 'Delphes: compiled shared library found\n'
else
    printf 'Delphes: libDelphes.so not found in MG5/Delphes\n'
fi

printf '\nThese checks confirm paths and version reporting, not full physics validation.\n'
