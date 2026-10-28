# MadGraph5_aMC@NLO — Installation and Setup (Linux)

This guide documents a **general Linux installation workflow** for MadGraph5_aMC@NLO (MG5_aMC). It also shows how to check an existing installation and connect commonly used simulation tools. Commands and dependencies may differ between MG5_aMC releases and Linux distributions.

> **Scope:** General educational workflow; not a configuration for any specific physics analysis.

## 1. Requirements

For a typical Ubuntu installation, install Python 3 and the compiler/build tools:

```bash
sudo apt update
sudo apt install -y python3 gcc g++ gfortran make wget tar
```

Check the environment:

```bash
python3 --version
gcc --version
g++ --version
gfortran --version
```

Additional libraries may be required for particular NLO processes or optional packages. Consult the documentation for the version you choose.

## 2. Download and extract MG5_aMC

1. Download a release archive (`.tar.gz`) from the [official MG5_aMC releases page](https://launchpad.net/mg5amcnlo) or the [MadGraph download page](https://madgraph.mi.infn.it/cgi-bin/Register/download.cgi).
2. Put the archive in a convenient directory and extract it. **Replace the example archive filename** with the actual file you downloaded:

```bash
mkdir -p "$HOME/hep-software"
cd "$HOME/hep-software"

# Change the path below to the archive that you downloaded.
ARCHIVE="$HOME/Downloads/MG5_aMC_vX.Y.Z.tar.gz"
tar -xzf "$ARCHIVE"
```

3. Enter the **extracted** MG5_aMC directory (its name depends on the release):

```bash
cd /path/to/extracted/MG5_aMC_directory
```

The `/path/to/...` string above is a placeholder, not a literal path to run.

## 3. Start MG5_aMC

From the MG5_aMC installation directory:

```bash
./bin/mg5_aMC
```

At the `MG5_aMC>` prompt:

```text
help
tutorial
quit
```

The `tutorial` command is interactive; follow the on-screen prompts. If MG5_aMC offers to update, you can answer `n` to keep the release you intended to document.

## 4. Optional physics packages

MG5_aMC can use additional packages, depending on the intended workflow. In its interactive prompt, commonly used installation commands include:

```text
install lhapdf6
install pythia8
install Delphes
```

Run **only the relevant commands**, one at a time, if the software is not already available. Installation may download and compile dependencies, may require a working internet connection, and may fail if a prerequisite is missing. In particular, Delphes integration may require a compatible ROOT setup. Some workflows need additional interfaces or packages; consult the MG5_aMC help for your installed version.

To see installation options:

```text
help install
```

### Check installed support tools

From the MG5_aMC installation directory, examples of checks are:

```bash
# Pythia8: if installed in the MG5 HEPTools directory
./HEPTools/pythia8/bin/pythia8-config --version

# LHAPDF6: example for a common MG5 Python-3 directory layout
./HEPTools/lhapdf6_py3/bin/lhapdf-config --version

# Delphes: check whether the compiled library exists
ls -lh Delphes/libDelphes.so
```

These paths are **examples**, not universal installation paths. A configuration script reporting a version or a library being present does not by itself prove a complete event-generation, showering, or detector-simulation workflow works.

If packages are installed elsewhere, MG5_aMC may need the corresponding tool paths configured. Check `input/mg5_configuration.txt` and MG5_aMC's `help set` output before changing settings.

## 5. Basic example: generate a standard-model process

A simple *optional* example to try after installation is Drell–Yan production of a muon pair. Inside `MG5_aMC>`:

```text
generate p p > mu+ mu-
output DY_example
launch
```

Follow the interactive prompts. This is a **general tutorial process** and not a thesis analysis card. A successful run provides a stronger end-to-end test than a startup message alone.

## 6. Common startup messages

- **FastJet / `fastjet-config` missing:** MG5_aMC may use its `fjcore` fallback for some tasks. Install/configure FastJet only if your workflow requires it.
- **eMELA configuration missing:** Not generally necessary for a basic proton–proton example.
- **Python-version warning:** Check the release notes for compatibility with features you plan to use. Successful startup does not validate every feature.
- **Update prompt:** Answer `n` to retain the installed version, or update separately after checking compatibility.

## 7. Example of a checked local environment

The following **example environment was checked with terminal commands**, but the listed versions are **not mandatory** for everyone:

| Component | Observed result |
| --- | --- |
| Operating system | Ubuntu 24.04.4 LTS |
| Python | 3.12.3 |
| GCC / G++ / GFortran | 13.3.0 |
| MG5_aMC | 3.6.6; interactive interface launched |
| Pythia8 | `pythia8-config --version` → 8.316 |
| LHAPDF6 | `lhapdf-config --version` → 6.5.5 |
| Delphes | `libDelphes.so` present; full runtime not tested here |

The **original installation history was not recorded**. This is a verified *environment check*, not proof that every suggested installation command above was run on that machine.

For convenient checks, see [`verify_mg5_setup.sh`](verify_mg5_setup.sh). It reports local tools and file presence; it does not generate physics events or modify the installation.

## 8. References

- [Official MG5_aMC installation wiki](https://cp3.irmp.ucl.ac.be/projects/madgraph/wiki/Installation)
- [MG5_aMC project wiki](https://cp3.irmp.ucl.ac.be/projects/madgraph/wiki)
- [MG5_aMC releases](https://launchpad.net/mg5amcnlo)
- [Pythia8 website](https://pythia.org/)
- [LHAPDF website](https://lhapdf.hepforge.org/)
- [Delphes website](https://delphes.github.io/)
