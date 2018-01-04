# Overview

This chapter is about the very first and highly important step of performing any analysis: the **Quality Assurance (QA)** of recorded data and Monte Carlo (MC) productions.

It is important to ensure that all detectors behave as expected and that related observables (a couple of examples: Number of Tracks in TPC, dE/dx of electrons, Number of calorimeter clusters found,...) are described properly by MC simulations. In particular, it is important to check that any of these observables is the same for all the subsets of the data, namely for all different runs that were recorded. If this is not the case, the differences _must_ be understood in case the MC does not follow.

The QA framework can be found within the [AnalysisSoftware Repository](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware) in _TaskQA/*_ , it is split into the major parts:

* Event QA
* Photon QA
* Cluster QA
* PrimaryTrack QA

As data taking is split into runs, a so-called runwise QA must be run on the desired data/MC to analyze. Furthermore, it is important to globally check the observables for the full statistics.

Furthermore, the calibration of calorimeters directly follows the QA stage and is described in this chapter as well (macros are contained in [AnalysisSoftware Repository](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware) in TaskV1/*). Generally, all macros/functions should be able to handle EMCal as well as PHOS and DCal, but for last two calorimeters special care needs to be taken and every QA step still needs to be verified in detail (after sucessful validation this statement may be removed).
In general, the calibration of calorimeters is performed by the specific detector groups for EMCal/DCal and PHOS. What we are referring to in this chapter is an improved energy calibration scheme based on the measured pi0-peak position in data to which the simulated MC mass positions are tuned to. In general, it may happen that an improved energy calibration is not needed but still then the macros should be run to cross-check the calibration.

