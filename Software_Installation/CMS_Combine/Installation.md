# CMSSW, CMS Combine & CombineHarvester — Installation and Setup

## Overview

CMS Combine is a statistical analysis toolkit developed for high energy physics. It provides likelihood-based methods for parameter estimation, hypothesis testing, significance calculations, and confidence interval determination.

Combine is built on ROOT, RooFit, and RooStats and is commonly used within the CMS Software Framework (CMSSW).

CombineHarvester is an additional framework for constructing, manipulating, and validating statistical models, datacards, and workspaces.

This guide describes a CMSSW-based installation using the CERN lxplus computing environment and an EL8-compatible Singularity/Apptainer container.

The workflow includes environment initialization, package installation, compilation, and verification.

---

## 1. Computing Environment

The installation procedure uses the following components:

| Component | Configuration |
|---|---|
| Computing platform | CERN lxplus |
| Host operating system | Red Hat Enterprise Linux |
| Container environment | EL8 (Singularity/Apptainer) |
| CMS software | CMSSW_14_1_7 |
| Combine release | v10.5.1 |
| CombineHarvester reference tag | v3.1.0 |
| Software distribution | CERN CVMFS |

The selected software versions provide a reproducible reference configuration. Other combinations may be supported depending on compatibility requirements.

### Why an EL8 Container?

CMSSW releases are built for particular operating-system architectures and compiler environments.

An EL8-based container provides a compatible runtime environment for installations requiring `el8_amd64_gcc12`.

The container isolates operating-system dependencies while retaining access to CMS software distributed through CVMFS.

---

## 2. Prerequisites

The following resources are required:

- Access to a CERN lxplus computing environment
- CMS software repository through CVMFS
- Git for source-code retrieval
- Sufficient storage for the CMSSW development area
- Compatible Singularity/Apptainer runtime

Verify access to the CMS software repository:

```bash
ls /cvmfs/cms.cern.ch
```

Initialize the CMS environment when necessary:

```bash
source /cvmfs/cms.cern.ch/cmsset_default.sh
```

CVMFS provides access to centrally distributed CMS software and associated development tools.

---

## 3. Initialize the EL8 Environment

Create a dedicated CMSSW working directory:

```bash
mkdir -p "$HOME/CMSSW_WORK"
cd "$HOME/CMSSW_WORK"
```

Launch the EL8 container:

```bash
cmssw-el8
```

A successful container initialization typically produces a shell prompt similar to:

```text
Singularity>
```

Verify the container operating system:

```bash
cat /etc/redhat-release
```

The container should report an EL8-compatible Linux distribution.

---

## 4. Create a CMSSW Release Area

For a fresh installation, create the selected CMSSW release:

```bash
cmsrel CMSSW_14_1_7
```

Enter the source directory:

```bash
cd CMSSW_14_1_7/src
```

Activate the CMSSW runtime environment:

```bash
cmsenv
```

Check the active CMSSW release:

```bash
echo "$CMSSW_VERSION"
```

Check the SCRAM architecture:

```bash
echo "$SCRAM_ARCH"
```

The architecture must correspond to the selected CMSSW build environment.

**Note:** `cmsrel` is required only when creating a new release area. An existing CMSSW installation should be activated rather than recreated.

---

## 5. Install CMS Combine

CMS Combine is maintained in the `HiggsAnalysis/CombinedLimit` repository.

From the CMSSW source directory:

```bash
cd "$CMSSW_BASE/src"
```

Clone the selected Combine release:

```bash
git -c advice.detachedHead=false clone \
  --depth 1 \
  --branch v10.5.1 \
  https://github.com/cms-analysis/HiggsAnalysis-CombinedLimit.git \
  HiggsAnalysis/CombinedLimit
```

The explicit release tag ensures that the selected source version remains fixed rather than following the development branch.

Check the source directory:

```bash
ls HiggsAnalysis/CombinedLimit
```

Confirm the selected release tag:

```bash
git -C HiggsAnalysis/CombinedLimit describe --tags --always
```

---

## 6. Install CombineHarvester

CombineHarvester extends the CMS statistical-analysis environment with additional datacard and model-building utilities.

The package requires a compatible Combine installation in the CMSSW development area.

From the CMSSW source directory:

```bash
cd "$CMSSW_BASE/src"
```

Clone the repository using the release tag associated with the CMSSW 14_1_X series:

```bash
git -c advice.detachedHead=false clone \
  --depth 1 \
  --branch v3.1.0 \
  https://github.com/cms-analysis/CombineHarvester.git \
  CombineHarvester
```

Check the source directory:

```bash
ls CombineHarvester
```

Verify the selected source tag:

```bash
git -C CombineHarvester describe --tags --always
```

CombineHarvester is useful for automated statistical-model construction but is not required for every Combine analysis.

---

## 7. Compile the CMSSW Development Area

After retrieving the required packages, return to the CMSSW source directory:

```bash
cd "$CMSSW_BASE/src"
```

Compile the development area:

```bash
scram b -j4
```

The `-j4` option allows compilation using four parallel jobs.

The number of compilation jobs should be selected according to available computing resources and local system policies.

### Rebuilding After Source Changes

Following source modifications or build failures, recompilation can be attempted:

```bash
scram b -j4
```

If a clean rebuild becomes necessary:

```bash
scram b clean
scram b -j4
```

A clean build removes existing compilation products and should not be performed unnecessarily in an established development area.

---

## 8. Verify CMS Combine

After successful compilation, check the executable location:

```bash
command -v combine
```

Check the Combine command-line interface:

```bash
combine -h
```

Verify the workspace conversion utility:

```bash
command -v text2workspace.py
```

Display its help menu:

```bash
text2workspace.py -h
```

Check the availability of the Combine automation utility:

```bash
command -v combineTool.py
```

Display its help menu:

```bash
combineTool.py -h
```

Successful command execution indicates that the corresponding tools are accessible in the active runtime environment.

Full statistical functionality requires additional tests with valid datacards and statistical models.

---

## 9. Reusing an Existing Installation

A fresh CMSSW installation is not required for subsequent analysis sessions.

From a CERN lxplus shell, enter the existing release directory:

```bash
cd "$HOME/CMSSW_WORK/CMSSW_14_1_7/src"
```

Launch the compatible container:

```bash
cmssw-el8
```

Activate the CMSSW environment:

```bash
cmsenv
```

Check Combine:

```bash
command -v combine
```

```bash
combine -h
```

This procedure restores access to the installed software without repeating source installation or compilation.

---

## 10. Common Environment Issues

### Unsupported SCRAM Architecture

A CMSSW development area created for EL8 may not initialize correctly on an EL9 host.

The corresponding container environment should be activated before initializing CMSSW.

```bash
cmssw-el8
```

### Combine Executable Not Found

Confirm that the correct CMSSW directory is active:

```bash
echo "$CMSSW_BASE"
```

Reinitialize the runtime environment:

```bash
cmsenv
```

If required, initialize the SCRAM runtime explicitly:

```bash
eval "$(scram runtime -sh)"
```

### Package Compilation Failure

Confirm that the selected Combine and CombineHarvester tags are compatible with the CMSSW release.

Rebuild only after reviewing the reported compiler or dependency errors.

### CVMFS Repository Unavailable

Check the CMS software repository:

```bash
ls /cvmfs/cms.cern.ch
```

Repository access must be restored before continuing with a CVMFS-dependent installation.

### Multiple CMSSW Environments

Different CMSSW development areas may contain different Combine installations.

Check the active executable:

```bash
command -v combine
```

Check the active architecture:

```bash
echo "$SCRAM_ARCH"
```

Avoid mixing incompatible runtime environments or compiled libraries.

---

## 11. Verified Analysis Environment

The following configuration was used in an existing CMS Combine statistical-analysis workflow.

| Component | Observed configuration |
|---|---|
| Computing environment | CERN lxplus |
| Host operating system | Red Hat Enterprise Linux 9 |
| Container | EL8 Singularity |
| CMSSW release | CMSSW_14_1_7 |
| Combine version | v10.5.1 |
| SCRAM architecture | el8_amd64_gcc12 |
| Combine executable | Available |
| `text2workspace.py` | Available |
| `combineTool.py` | Available |
| CombineHarvester directory | Present |

The CombineHarvester source tag in the existing installation has not been independently confirmed. The `v3.1.0` tag specified in the installation procedure follows the compatibility recommendation for CMSSW 14_1_X.

The fresh-installation commands provide a reproducible setup procedure; they are distinct from verification of the existing installation.

---

## 12. Statistical Analysis Applications

After configuring the runtime environment, CMS Combine supports several statistical-analysis workflows.

Common applications include:

- Construction of statistical workspaces from datacards
- Binned maximum-likelihood fits
- Expected significance calculations
- Confidence interval and exclusion-limit estimation
- Treatment of systematic uncertainties
- Statistical-model validation

The statistical model, datacards, ROOT templates, and selected inference method depend on the physics analysis.

---

## 13. References

1. [CMS Combine — Official Documentation (v10.5.1)](https://cms-analysis.github.io/HiggsAnalysis-CombinedLimit/v10.5.1/)
2. [HiggsAnalysis/CombinedLimit — Official GitHub Repository](https://github.com/cms-analysis/HiggsAnalysis-CombinedLimit)
3. [CombineHarvester — Official GitHub Repository](https://github.com/cms-analysis/CombineHarvester)
4. [CMS Software — Singularity/Apptainer Environment Guide](https://cms-sw.github.io/singularity.html)
5. [CernVM File System (CVMFS) — Official Documentation](https://cvmfs.readthedocs.io/en/stable/)
