# ROOT-Based Data Analysis in Experimental High Energy Physics

## Overview

ROOT is a scientific data analysis framework widely used in experimental high energy physics for processing collision data, reconstructing physics observables, performing statistical analysis, and visualizing results.

This section documents ROOT-based computational workflows involving event reconstruction, kinematic calculations, histogramming, and preparation of structured datasets for machine-learning applications.

## 1. Analysis Framework

A typical Monte Carlo simulation and analysis chain follows:

**MadGraph5_aMC@NLO → Pythia8 → Delphes → ROOT → TMVA**

ROOT provides tools for processing detector-level events, reconstructing physics objects, calculating observables, and organizing analysis outputs.

## 2. Event Processing and Reconstruction

ROOT-based event analysis involves:

- Reading simulated or experimental data from ROOT files.
- Accessing event branches and processing events through event loops.
- Reconstructing electrons, muons, jets, and b-tagged jets.
- Calculating transverse momentum, pseudorapidity, and azimuthal angles.
- Reconstructing invariant masses and angular separations.
- Computing global event observables and missing transverse momentum.
- Applying analysis selections and reconstruction requirements.

Reconstruction procedures depend on the detector configuration and physics objectives.

## 3. Histogramming and Visualization

ROOT supports the visualization and interpretation of physics observables through:

- One-dimensional and multidimensional histograms.
- Kinematic and particle-multiplicity distributions.
- Comparisons between simulated processes.
- Reconstruction efficiency studies.
- Graphical presentation of analysis results.

## 4. ROOT Trees and Data Organization

ROOT TTrees provide efficient storage and access to event-level information.

Reconstructed observables can be organized into structured datasets for further analysis, including event selection, multivariate classification, and statistical inference.

## 5. Integration with Machine Learning

ROOT-based analysis produces reconstructed physics variables that can be used in TMVA (Toolkit for Multivariate Data Analysis).

TMVA supports classification and regression methods, including Boosted Decision Trees (BDTs), along with training, validation, and performance evaluation.

## 6. Software and Tools

| Software / Framework | Application |
|---|---|
| ROOT | Data processing, histogramming, and visualization |
| C++ | Event reconstruction and physics calculations |
| Delphes | Fast detector simulation |
| ROOT TTree | Structured event-data storage |
| ROOT TLorentzVector | Four-momentum and kinematic calculations |
| TMVA | Multivariate analysis and machine learning |

## 7. Reproducibility

Reliable analysis requires documented input datasets, reconstruction methods, variable definitions, event selection criteria, and software configurations.

Modular ROOT workflows support reproducibility, validation, and extension to different collider physics processes.

## 8. Related Documentation

- [ROOT & TMVA Installation](../Software_Installation/ROOT_TMVA/Installation.md)
- [Delphes Installation](../Software_Installation/Delphes/Installation.md)
- [Monte Carlo Simulation](../Monte_Carlo_Simulation/README.md)

## 9. References

- [ROOT — Official Website](https://root.cern/)
- [ROOT — User Guide](https://root.cern/manual/)
- [ROOT — Histograms](https://root.cern/manual/histograms/)
- [ROOT — Trees](https://root.cern/manual/trees/)
- [ROOT — TMVA](https://root.cern/manual/tmva/)
- [Delphes — Official Documentation](https://delphes.github.io/)
