# LHAPDF6 — Installation and Configuration

LHAPDF (Les Houches Accord Parton Distribution Functions) provides access to parton distribution functions used in high energy physics calculations and Monte Carlo event generation.

This guide describes a general Linux installation procedure, environment configuration, and PDF set management.

Installation requirements may vary depending on the Linux distribution, compiler, Python environment, and LHAPDF release.

## 1. System Requirements

LHAPDF6 requires a C++11-compatible compiler and standard build tools.

For Debian-based Linux distributions, the required packages can be installed using:

```bash
sudo apt update
sudo apt install -y build-essential python3 python3-dev wget tar
```

Check the available software:

```bash
python3 --version
g++ --version
make --version
```

Python 3 may already be available in the operating system. Additional Python installation is unnecessary when a compatible interpreter is present.

Python development headers are required when building the optional Python interface.

## 2. Download LHAPDF6

Create a directory for scientific software:

```bash
mkdir -p "$HOME/hep-software"
cd "$HOME/hep-software"
```

Download the required LHAPDF6 source release from the official LHAPDF website.

For a downloaded archive named `LHAPDF-6.X.Y.tar.gz`, extract the source:

```bash
tar -xzf LHAPDF-6.X.Y.tar.gz
cd LHAPDF-6.X.Y
```

Replace `6.X.Y` with the selected release version.

## 3. Configure and Install

Configure LHAPDF with a local installation directory:

```bash
./configure --prefix="$HOME/hep-software/lhapdf-install"
```

Compile the source:

```bash
make -j2
```

Install the compiled library:

```bash
make install
```

The installation prefix determines the location of the libraries, executables, headers, and PDF data directories.

A local installation avoids modifying system-wide software packages.

## 4. Environment Configuration

For a local installation, configure the executable and shared-library search paths:

```bash
export LHAPDF_PREFIX="$HOME/hep-software/lhapdf-install"

export PATH="$LHAPDF_PREFIX/bin:$PATH"

export LD_LIBRARY_PATH="$LHAPDF_PREFIX/lib:${LD_LIBRARY_PATH:-}"
```

Some installations use `lib64` instead of `lib`. The actual library directory should be checked before setting the corresponding path.

The Python module search path may also require configuration when Python bindings are installed in a nonstandard location.

## 5. Installation Verification

Check the installed version:

```bash
lhapdf-config --version
```

Check the PDF data directory:

```bash
lhapdf-config --datadir
```

Check available PDF sets:

```bash
lhapdf list
```

Check locally installed PDF sets:

```bash
lhapdf list --installed
```

The general PDF catalogue and locally installed PDF sets are not necessarily identical.

## 6. PDF Set Management

Update the PDF catalogue:

```bash
lhapdf update
```

Install an example PDF set when required:

```bash
lhapdf install NNPDF31_nlo_as_0118
```

Verify installation:

```bash
lhapdf list --installed
```

PDF sets should be selected according to the perturbative order and requirements of the intended physics calculation.

## 7. Common Configuration Issues

### Python Command Not Found

Some Linux installations provide `python3` without a `python` command.

On compatible Ubuntu installations, the following package can provide the Python 3 command alias:

```bash
sudo apt install python-is-python3
```

### Shared Library Not Found

Check the LHAPDF library installation directory and configure `LD_LIBRARY_PATH` when necessary.

### PDF Set Not Found

Verify the installed PDF sets and the configured PDF data search path.

### Python Module Not Found

Check that LHAPDF was compiled with Python support and that the module installation directory is accessible to the selected Python environment.

## 8. Integration with MadGraph5_aMC@NLO

MadGraph5_aMC@NLO supports LHAPDF6 integration for parton distribution functions.

LHAPDF6 may be installed independently or through the MadGraph installation interface:

```text
install lhapdf6
```

Existing LHAPDF installations should be checked before installing additional copies.

The LHAPDF configuration executable and PDF data paths must be accessible to the selected MadGraph environment.
