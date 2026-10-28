# Monte Carlo Event Generation — Workflow and Configuration

## Overview

Monte Carlo event generation is an essential component of experimental high energy physics. It provides simulated particle-collision events for studying Standard Model processes, detector responses, reconstruction efficiencies, and analysis strategies.

MadGraph5_aMC@NLO supports leading-order (LO) and next-to-leading-order (NLO) calculations and can be integrated with external simulation packages.

A typical workflow consists of:

**MadGraph5_aMC@NLO → Pythia8 → Delphes → ROOT**

Reliable event generation requires consistent physics models, parton distribution functions, perturbative orders, and simulation settings.

---

## 1. Selecting the Physics Model

The physics model must be consistent with the target process and the intended perturbative calculation.

Common considerations include:

- Standard Model or beyond-the-Standard-Model interactions
- Leading-order or next-to-leading-order accuracy
- Treatment of heavy-quark masses
- Parton distribution functions
- Renormalization and factorization scales
- Initial-state and final-state particle definitions

### Four-Flavour Scheme (4FS)

In the four-flavour scheme:

- Bottom quarks are generally treated as massive.
- Bottom quarks are not included as incoming partons in the proton PDFs.
- Bottom quarks can be generated explicitly in the hard-scattering process.

### Five-Flavour Scheme (5FS)

In the five-flavour scheme:

- Bottom quarks can contribute as initial-state partons.
- The bottom-quark mass is commonly neglected in the hard-scattering matrix elements.
- Collinear logarithms associated with bottom-quark production are incorporated into the bottom-quark PDF.

### Model Configuration

For some NLO Standard Model calculations, MadGraph provides model configurations such as:

```text
import model loop_sm
```

and

```text
import model loop_sm-no_b_mass
```

The precise model name, supported interactions, parton definitions, and flavour-scheme implementation depend on the selected MadGraph release.

A consistent flavour scheme requires compatible model parameters, proton definitions, PDF sets, and process configurations.

---

## 2. Basic Event Generation

A simple introductory Drell–Yan process is describes lepton-pair production
in proton–proton collisions through electroweak interactions.

```math
pp \rightarrow \mu^{+}\mu^{-}
```

Start MadGraph:

```bash
./bin/mg5_aMC
```

Define the process:

```text
import model sm

generate p p > mu+ mu-

output DY_MuMu_LO
```

Launch the generated process:

```text
launch DY_MuMu_LO
```

During interactive configuration, select suitable values for:

- Number of generated events
- Beam energies
- Parton distribution functions
- Random seed
- Parton shower configuration, when required

For an illustrative proton–proton collision setup:

```text
set nevents 1000
set ebeam1 6500
set ebeam2 6500
```

These settings correspond to 1,000 requested events at a centre-of-mass energy of 13 TeV.

The commands are entered during the appropriate MadGraph launch configuration stage.

---

## 3. Parton Distribution Functions

Parton distribution functions describe the momentum distributions of quarks and gluons within hadrons.

LHAPDF6 provides access to PDF sets used in collider calculations.

Examples include:

```text
NNPDF31_nlo_as_0118
NNPDF31_nnlo_as_0118
```

PDF selection should account for:

- Perturbative order
- Flavour-number scheme
- Strong coupling configuration
- Compatibility with the intended calculation

Available PDF sets can be inspected using:

```bash
lhapdf list
```

Locally installed PDF sets can be checked using:

```bash
lhapdf list --installed
```

An example PDF set can be installed using:

```bash
lhapdf install NNPDF31_nlo_as_0118
```

PDF sets should be selected according to the physics process rather than installed indiscriminately.

---

## 4. Diagram Overlap and MadSTR

Certain NLO calculations contain overlapping contributions from resonant processes.

An example is the overlap between associated single-top production and top–antitop production in specific final states.

Diagram removal and diagram subtraction prescriptions can be used to define separate samples while accounting for overlapping resonant contributions.

MadSTR is a MadGraph plugin supporting selected diagram-removal and subtraction procedures.

For a compatible MadSTR installation, the plugin interface can be activated through:

```bash
./bin/mg5_aMC --mode=MadSTR
```

The applicable prescription and associated run-card settings must be selected according to the process definition and validated simulation setup.

Diagram removal is not a universal requirement for all single-top processes.

---

## 5. Matching and Merging

Parton showers generate additional QCD radiation beyond the hard-scattering calculation.

When samples containing different parton multiplicities are combined, matching or merging procedures help prevent double counting.

Common approaches include:

| Method | Typical Application |
|---|---|
| MLM matching | LO matrix-element samples |
| FxFx merging | NLO samples with multiple jet multiplicities |

### FxFx Merging

FxFx merging combines NLO calculations with different jet multiplicities and a compatible parton shower.

For suitable NLO configurations, the run card contains:

```text
3 = ickkw
```

Additional settings include the jet transverse-momentum requirement and the merging scale.

An illustrative configuration is:

**Run-card parameters**

```text
3 = ickkw
20.0 = ptj
1.0 = jetalgo
1.0 = jetradius
```

**Shower-card parameters**

```text
Qcut = 40.0
njmax = 2
```

These values are illustrative rather than universally optimized.

Correct FxFx generation requires appropriate matrix-element multiplicities, scale settings, shower configuration, and merging validation.

Some processes are not suitable for standard FxFx merging.

---

## 6. Pythia8 Parton Shower and Tune Selection

Pythia8 simulates several components of the collision event, including:

- Initial-state radiation
- Final-state radiation
- Hadronization
- Multiparton interactions
- Particle decays

A tune specifies parameters used to model aspects of the parton shower, hadronization, and underlying event.

### CMS CP5 Tune

The CMS CP5 tune is a commonly used Pythia8 configuration associated with CMS Monte Carlo simulations.

It includes specific settings for multiparton interactions, strong coupling, and parton distribution functions.

An example external PDF setting is:

```text
PDF:pSet = LHAPDF6:NNPDF31_nnlo_as_0118
```

The complete CP5 configuration should be obtained from the appropriate CMS generator configuration for the intended production campaign.

The selected tune must be compatible with the Pythia8 release, PDF setup, and matrix-element matching prescription.

Tune settings should not be transferred indiscriminately between different simulation workflows.

---

## 7. Event Generation Cards

MadGraph maintains several configuration files inside generated process directories.

| Configuration File | Purpose |
|---|---|
| `proc_card.dat` | Process definition |
| `run_card.dat` | Beam configuration, event generation, scales, and cuts |
| `param_card.dat` | Particle masses, widths, and model parameters |
| `shower_card.dat` | Parton shower configuration |
| `madspin_card.dat` | Optional particle-decay configuration |

Not every workflow requires all optional cards.

The configuration files should be preserved to support reproducibility.

---

## 8. Sample Validation

Generated samples should be checked before detector simulation and physics analysis.

Recommended validation includes:

- Successful completion of event generation
- Consistency of process definitions
- Generated event counts
- Reported cross sections and integration uncertainties
- PDF and flavour-scheme consistency
- Particle identities and decay definitions
- Shower completion and output integrity
- Matching and merging diagnostics, when applicable

Additional validation may include kinematic distributions and comparisons with established reference predictions.

---

## 9. Reproducibility

The following information should be recorded for each generated sample:

| Parameter | Description |
|---|---|
| Process | Hard-scattering definition |
| Generator version | MadGraph release |
| Physics model | Selected Standard Model or BSM configuration |
| Perturbative order | LO or NLO |
| Flavour scheme | 4FS or 5FS, when relevant |
| Collision energy | Centre-of-mass energy |
| PDF set | Selected parton distribution functions |
| Event count | Requested and successfully generated events |
| Random seed | Reproducibility parameter |
| Shower configuration | Pythia8 version and tune |
| Matching/merging | Selected method and associated settings |
| Cross section | Generator-reported production cross section |

Complete configuration records improve reproducibility and facilitate comparisons between independently generated samples.

---

## 10. Related Documentation

- [MadGraph5_aMC@NLO — Installation and Setup](../Software_Installation/MadGraph5/Installation.md)
- [LHAPDF6 — Installation and PDF Management](../Software_Installation/LHAPDF6/Installation.md)
- [Pythia8 — Installation and Configuration](../Software_Installation/Pythia8/Installation.md)
- [Delphes — Installation and Detector Simulation](../Software_Installation/Delphes/Installation.md)
- [ROOT & TMVA — Installation and Configuration](../Software_Installation/ROOT_TMVA/Installation.md)
- [ROOT — Event Analysis Documentation](https://root.cern/manual/trees/)

Advanced simulation settings should be selected according to the intended physics process and validated using the corresponding generator documentation.
