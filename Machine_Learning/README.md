# Machine Learning in Experimental High Energy Physics

## Overview

Machine learning techniques are widely applied in experimental high energy physics for event classification, signal-background discrimination, and multivariate analysis.

This section documents machine-learning workflows using **ROOT TMVA**, with a focus on Boosted Decision Trees (BDTs), model training, validation, and performance evaluation.

## 1. Machine Learning Framework

**ROOT TMVA (Toolkit for Multivariate Data Analysis)** provides machine-learning algorithms for classification and regression studies.

Key methods include:

- Boosted Decision Trees (BDTs)
- AdaBoost and Gradient Boosting
- Binary and multiclass classification

## 2. Analysis Workflow

A typical TMVA-based classification workflow involves:

1. Preparing input datasets from ROOT TTrees.
2. Selecting relevant physics variables.
3. Defining signal and background classes.
4. Splitting datasets into training and testing samples.
5. Training and evaluating classification models.
6. Examining classification performance and overtraining.
7. Producing classifier response distributions.

## 3. Model Performance Evaluation

Classification performance can be evaluated using:

- Receiver Operating Characteristic (ROC) curves
- Area Under the Curve (AUC)
- Signal efficiency and background rejection
- Kolmogorov–Smirnov (KS) tests
- Training and testing response comparisons

## 4. Applications in Collider Physics

Machine-learning classifiers support the separation of rare signal processes from Standard Model backgrounds using reconstructed kinematic and event-level observables.

Classifier outputs can also serve as discriminating observables in subsequent statistical analyses.

## 5. Reproducibility

Reliable machine-learning workflows require documented input variables, dataset splitting, algorithm configurations, training procedures, and validation methods.

## 6. References

- [ROOT TMVA — Official Documentation](https://root.cern/manual/tmva/)
- [ROOT Data Analysis Framework](https://root.cern/)
- [TMVA — GitHub Source Code](https://github.com/root-project/root/tree/master/tmva)
