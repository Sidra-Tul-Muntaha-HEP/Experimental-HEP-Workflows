# tHZbj Event Reconstruction and Analysis Workflow

## Overview

This section documents the ROOT-based analysis workflow developed for the study of single-top-quark production in association with a Higgs boson and a Z boson (tHZbj) at the LHC.

The analysis processes simulated detector-level events from Delphes, reconstructs physics observables, and prepares structured ROOT datasets for subsequent multivariate analysis using TMVA.

## 1. Physics Process

The analysis considers the dilepton and jets final state, involving:

- **Top quark:** t → Wb, with W → jj
- **Higgs boson:** H → bb̄
- **Z boson:** Z → ℓ⁺ℓ⁻, where ℓ = e, μ
- **Additional production objects:** An associated b quark and a light jet

## 2. Event Analysis Workflow

The ROOT/C++ analysis involves:

1. Reading detector-level events from Delphes ROOT files.
2. Accessing reconstructed leptons, jets, and event information.
3. Classifying jets into b-tagged and light-jet categories.
4. Calculating particle-level kinematic variables.
5. Reconstructing Higgs, W, Z, and top-quark candidates.
6. Calculating invariant masses, angular separations, and global event variables.
7. Organizing reconstructed observables into ROOT TTrees.
8. Preparing the resulting datasets for TMVA-based machine learning.

## 3. Analysis Workflow Documentation

The following figure presents the event reconstruction and analysis procedure, including the main computational stages and ROOT/C++ implementation details.

![tHZbj Event Reconstruction and Analysis Workflow](tHZbj_Analysis_Workflow.png)

## 4. Analysis Output

The final ROOT TTrees contain reconstructed physics observables and event-level information suitable for multivariate classification studies.

These datasets provide the connection between detector-level simulation and subsequent machine-learning analysis.

## 5. Software and Frameworks

- **Delphes:** Fast detector simulation
- **ROOT/C++:** Event processing and physics reconstruction
- **ROOT TTree:** Storage of reconstructed observables
- **TMVA:** Multivariate classification

## 6. References

- [ROOT — Official Website](https://root.cern/)
- [ROOT — User Guide](https://root.cern/manual/)
- [ROOT — TTree Documentation](https://root.cern/manual/trees/)
- [ROOT — TMVA Documentation](https://root.cern/manual/tmva/)
