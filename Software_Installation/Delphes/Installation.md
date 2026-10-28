# Delphes — Installation and Setup

Delphes is a C++ framework designed for fast simulation of particle detector responses in high energy physics experiments.

It provides reconstructed physics objects, including electrons, muons, jets, missing transverse energy, and b-tagged jets, using configurable detector models.

This guide describes the installation, configuration, and basic verification of Delphes on Linux.

## 1. System Requirements

Delphes requires:

- A compatible C++ compiler
- ROOT Data Analysis Framework
- Tcl scripting library
- Standard build tools

For Ubuntu and other Debian-based Linux distributions:

```bash
sudo apt update
sudo apt install -y build-essential git make tcl-dev
```

ROOT must be installed and configured separately.

Check the available ROOT environment:

```bash
root-config --version
```

```bash
root-config --prefix
```

If ROOT is installed but unavailable in the current terminal, activate its environment:

```bash
source /path/to/ROOT/bin/thisroot.sh
```

Replace the example path with the actual ROOT installation directory.

## 2. Standalone Delphes Installation

Download the Delphes source code from the official GitHub repository:

```bash
mkdir -p "$HOME/hep-software"
cd "$HOME/hep-software"

git clone https://github.com/delphes/delphes.git
```

Enter the source directory:

```bash
cd delphes
```

Compile Delphes:

```bash
make -j2
```

The compilation process builds the Delphes libraries and supported event-format readers.

## 3. Installation Through MadGraph5_aMC@NLO

Delphes can also be installed through the MadGraph5_aMC@NLO interactive interface.

Start MadGraph:

```bash
./bin/mg5_aMC
```

At the MadGraph prompt:

```text
install Delphes
```

The installation procedure configures Delphes within the MadGraph environment.

Existing installations should be checked before compiling additional copies.

## 4. Installation Verification

For a Delphes installation located inside the MadGraph directory, check the compiled library:

```bash
ls -lh Delphes/libDelphes.so
```

Check the available event readers:

```bash
ls -l Delphes/DelphesHepMC2
```

```bash
ls -l Delphes/DelphesHepMC3
```

Check the CMS detector configuration:

```bash
ls -l Delphes/cards/delphes_card_CMS.tcl
```

The presence of these files confirms the availability of the corresponding compiled components and detector configuration.

Successful detector simulation requires an additional runtime test.

## 5. Running Delphes

Delphes supports different generator-event formats, including HepMC and LHEF.

For an installation compiled with HepMC3 support, an example command is:

```bash
./DelphesHepMC3 \
  cards/delphes_card_CMS.tcl \
  output.root \
  input.hepmc
```

The input file must contain events in the format supported by the selected reader.

The detector configuration is defined through the Tcl card.

The simulation produces a ROOT output file containing reconstructed detector-level information.

## 6. ROOT Output Analysis

Start ROOT:

```bash
root -l
```

Load the compiled Delphes library:

```cpp
gSystem->Load("libDelphes");
```

Open an existing Delphes output file:

```cpp
TFile *file = TFile::Open("output.root");
```

Access the event tree:

```cpp
TTree *tree = nullptr;
file->GetObject("Delphes", tree);
```

Display the electron transverse-momentum distribution:

```cpp
tree->Draw("Electron.PT");
```

This example demonstrates basic access to reconstructed electron information.

## 7. Common Installation Issues

### ROOT Configuration Not Found

Confirm that ROOT is installed and its environment is active.

### Missing Tcl Development Files

Install the appropriate Tcl development package for the Linux distribution.

### Compilation Errors

Check compatibility between ROOT, GCC, and the selected Delphes release.

### Shared Library Loading Failure

Verify the location of `libDelphes.so` and configure the appropriate runtime library search path.

### Missing Detector Configuration

Check the available Tcl detector cards under the `cards` directory.

### Event Format Incompatibility

Select the appropriate Delphes input reader for the generator-event format.

## 8. References

- Delphes Official Website
- Delphes GitHub Repository
- Delphes Workbook — Quick Tour
- ROOT Data Analysis Framework
- MadGraph5_aMC@NLO Documentation
