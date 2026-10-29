# TMVA Classification Workflow

## Overview

This section presents a general-purpose classification workflow using **ROOT TMVA (Toolkit for Multivariate Data Analysis)**.

The workflow demonstrates the training, testing, and evaluation of multivariate classification algorithms using a synthetic Monte Carlo dataset.

## Classification Methods

The tutorial supports multiple classification techniques, including:

- Boosted Decision Trees (BDTs)
- AdaBoost and Gradient Boosting
- Likelihood-based classifiers
- Fisher discriminant analysis
- Support Vector Machines (SVMs)
- Neural Networks

## Execution

Run the BDT classifier using:

```bash
root -l -q 'TMVAClassification.C("BDT")'
```

The macro uses the ROOT tutorial dataset and produces `TMVAC.root`, containing training and evaluation results.

## Source Code

[TMVAClassification.C](TMVAClassification.C)

**Attribution:** ROOT TMVA classification tutorial, originally authored by Andreas Hoecker. The source code is included without modifications.

## References

- [ROOT TMVA Documentation](https://root.cern/manual/tmva/)
- [ROOT Official Website](https://root.cern/)
