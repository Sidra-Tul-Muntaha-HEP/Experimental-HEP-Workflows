# ROOT & TMVA — Installation and Setup

ROOT is a scientific data analysis framework widely used in experimental high energy physics. It provides tools for data processing, statistical analysis, histogramming, visualization, and machine learning.

TMVA (Toolkit for Multivariate Data Analysis) is a machine-learning package integrated into ROOT. It supports classification, regression, and multivariate analysis methods, including Boosted Decision Trees (BDTs).

This guide describes general Linux installation procedures, environment configuration, and basic verification of ROOT and TMVA.

## 1. System Requirements

ROOT is supported on several Linux distributions.

Installation requirements depend on the selected ROOT release, operating system, compiler, and available system libraries.

A typical installation may require:

- Compatible C++ compiler
- Required system libraries
- Python 3 for PyROOT functionality
- CMake and development tools when compiling from source

Specific Linux or Python versions are not universally required. Compatibility should be checked against the selected ROOT release.

## 2. Installation Using Precompiled Binaries

Precompiled ROOT binaries are available from the official website:

https://root.cern/install/

### Download

Select a binary distribution compatible with the Linux system and compiler environment.

Create a software installation directory:

```bash
mkdir -p "$HOME/hep-software"
cd "$HOME/hep-software"
```

Extract the downloaded ROOT archive:

```bash
ROOT_ARCHIVE="$HOME/Downloads/root_vVERSION.PLATFORM.tar.gz"
tar -xzf "$ROOT_ARCHIVE"
```

Replace the example archive name with the actual downloaded filename.

Precompiled ROOT distributions commonly extract into a directory named `root`.

### Environment Configuration

Activate the ROOT environment:

```bash
source "$HOME/hep-software/root/bin/thisroot.sh"
```

This command configures the environment variables required to access ROOT executables and libraries.

The environment script may need to be sourced again in a new terminal session.

## 3. Alternative: Installation from Source

ROOT can also be compiled from source.

Source code repository:

https://github.com/root-project/root

Clone the stable source branch:

```bash
git clone --branch latest-stable --depth=1 \
  https://github.com/root-project/root.git root-src
```

Configure a separate build directory:

```bash
cmake -S root-src -B root-build \
  -DCMAKE_INSTALL_PREFIX="$HOME/hep-software/root-custom" \
  -Dtmva=ON
```

Compile and install:

```bash
cmake --build root-build -j2
cmake --install root-build
```

Activate the installation:

```bash
source "$HOME/hep-software/root-custom/bin/thisroot.sh"
```

Source compilation requires additional development dependencies and may differ between ROOT releases.

## 4. ROOT Installation Verification

Locate the ROOT executable:

```bash
which root
```

Check the installed version:

```bash
root-config --version
```

Check the installation prefix:

```bash
root-config --prefix
```

Start the ROOT interactive interface:

```bash
root -l
```

A successful launch confirms that the ROOT application is accessible.

## 5. TMVA Verification

TMVA is included in ROOT distributions built with TMVA support.

Check the availability of the TMVA library:

```bash
root -l -b -q -e 'std::cout << "TMVA library status: " << gSystem->Load("libTMVA") << std::endl;'
```

Library loading results:

| Status | Meaning |
|---|---|
| `0` | Library successfully loaded |
| `1` | Library already loaded |
| `-1` | Library loading failed |

Successful library loading confirms the availability of TMVA but does not independently validate all machine-learning algorithms.

## 6. Optional PyROOT Verification

PyROOT provides Python bindings for ROOT.

Check PyROOT availability:

```bash
python3 -c "import ROOT; print(ROOT.gROOT.GetVersion())"
```

The Python environment must be compatible with the selected ROOT installation.

## 7. Tested Environment

The following configuration has been verified on a local Linux system.

| Component | Version / Status |
|---|---|
| Operating System | Ubuntu 24.04.4 LTS |
| ROOT | 6.38.00 |
| ROOT executable | Available |
| ROOT configuration utility | Working |
| TMVA library | Successfully loaded |
| TMVA library status | `0` |

These values describe one verified environment rather than mandatory installation requirements.

PyROOT functionality has not yet been separately verified.

## 8. Common Installation Issues

### ROOT Command Not Found

Activate the ROOT environment through `thisroot.sh` and verify the installation directory.

### ROOT Library Loading Failure

Check compatibility between the ROOT binary distribution, operating system, compiler, and system libraries.

### TMVA Library Not Found

Confirm that the installed ROOT distribution includes TMVA support.

For source builds, check the TMVA CMake configuration option.

### PyROOT Import Failure

Verify Python compatibility and activate the corresponding ROOT environment.

### Conflicting ROOT Versions

Multiple ROOT installations may cause executable or library conflicts.

Verify the active installation with:

```bash
which root
root-config --prefix
```

## 9. References

- [ROOT Official Website](https://root.cern/)
- [ROOT Installation Guide](https://root.cern/install/)
- [ROOT Source Installation](https://root.cern.ch/install/build_from_source/)
- [ROOT TMVA Documentation](https://root.cern.ch/manual/tmva/)
- [ROOT GitHub Repository](https://github.com/root-project/root)
