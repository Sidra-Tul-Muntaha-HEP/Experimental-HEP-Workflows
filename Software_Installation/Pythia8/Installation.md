# Pythia8 — Installation and Configuration

Pythia8 is a general-purpose Monte Carlo event generator used in high energy physics for parton showering, hadronization, multiparton interactions, and particle decays.

This guide describes Pythia8 installation on Linux, integration with MadGraph5_aMC@NLO, optional external libraries, and basic installation verification.

Installation requirements depend on the selected software release, operating system, and external dependencies.

## 1. System Requirements

Pythia8 requires a compatible C++ compiler and standard build tools.

For Ubuntu and other Debian-based Linux distributions:

```bash
sudo apt update
sudo apt install -y g++ make wget tar
```

Check the compiler:

```bash
g++ --version
```

Additional development libraries may be required when enabling external packages.

## 2. Installation Through MadGraph5_aMC@NLO

Pythia8 can be installed directly through the MadGraph5_aMC@NLO interactive interface.

Start MadGraph:

```bash
./bin/mg5_aMC
```

At the MadGraph prompt:

```text
install pythia8
```

The installation procedure downloads and configures Pythia8 and its supported interfaces.

Installation time and dependencies depend on the selected MadGraph release and system configuration.

## 3. Standalone Pythia8 Installation

Pythia8 can also be installed independently of MadGraph.

Download a suitable source archive from the official Pythia website:

https://pythia.org/releases/

Extract the downloaded archive:

```bash
tar -xzf pythia8XXX.tgz
```

Replace `pythia8XXX.tgz` with the actual downloaded filename.

Enter the extracted source directory.

Configure the installation prefix:

```bash
./configure --prefix="$HOME/hep-software/pythia8"
```

Compile:

```bash
make -j2
```

Install:

```bash
make install
```

Additional configuration flags may be required for external physics libraries.

## 4. Optional LHAPDF6 Integration

LHAPDF6 provides external parton distribution functions.

Pythia8 includes internal PDF options, so LHAPDF6 is not mandatory for every Pythia8 installation.

For an existing LHAPDF6 installation, the external library can be enabled during the Pythia8 configuration stage:

```bash
./configure \
  --prefix="$HOME/hep-software/pythia8" \
  --with-lhapdf6="$LHAPDF_PREFIX"
```

`LHAPDF_PREFIX` must contain the corresponding LHAPDF6 installation directory.

Additional interfaces, including HepMC, can also be configured when required.

## 5. Installation Verification

For Pythia8 installations managed through MadGraph, the configuration executable is commonly located at:

```text
HEPTools/pythia8/bin/pythia8-config
```

Check the installed version:

```bash
./HEPTools/pythia8/bin/pythia8-config --version
```

Check LHAPDF6 support:

```bash
./HEPTools/pythia8/bin/pythia8-config --with-lhapdf6
```

Check the complete build configuration:

```bash
./HEPTools/pythia8/bin/pythia8-config --config
```

The output `true` for `--with-lhapdf6` indicates that LHAPDF6 support is enabled in the Pythia8 build.

These checks confirm configuration details but do not replace a complete simulation test.

## 6. Common Configuration Issues

### Pythia8 Configuration Executable Not Found

Check the Pythia8 installation prefix and the location of `pythia8-config`.

### LHAPDF6 Support Disabled

Check the LHAPDF6 installation prefix and rebuild Pythia8 with the appropriate configuration option if external PDF support is required.

### Missing Shared Libraries

Check the runtime library search path and confirm compatibility between compiled packages.

### Event Generation Failure

Verify the process configuration, external dependencies, available PDF sets, and MadGraph–Pythia8 interface settings.

## 8. References

- [Official Pythia8 Website](https://pythia.org/)
- [Pythia8 Documentation](https://pythia.org/documentation/)
- [Pythia8 Releases](https://pythia.org/releases/)
- [MadGraph5_aMC@NLO](https://launchpad.net/mg5amcnlo)
- [LHAPDF](https://www.lhapdf.org/)
