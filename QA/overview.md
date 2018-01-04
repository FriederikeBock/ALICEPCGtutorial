# Overview

This chapter is about the very first and highly important step of performing any analysis: the **Quality Assurance (QA)** of recorded data and Monte Carlo (MC) productions.

It is important to ensure that all detectors behave as expected and that related observables (a couple of examples: Number of Tracks in TPC, dE/dx of electrons, Number of calorimeter clusters found,...) are described properly by MC simulations. In particular, it is important to check that any of these observables is the same for all the subsets of the data, namely for all different runs that were recorded. If this is not the case, the differences _must_ be understood in case the MC does not follow.

The QA framework can be found within the [AnalysisSoftware Repository](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware) in _TaskQA/*_ , it is split into the major parts:

1. [Event QA](QA/eventQA.md)
2. [Photon QA](QA/photonQA.md)
3. [Cluster QA](QA/clusterQA.md)
4. [PrimaryTrack QA](QA/primaryQA.md)

As data taking is split into runs, a so-called runwise QA must be run on the desired data/MC to analyze. Furthermore, it is important to globally check the observables for the full statistics.

> respective macros can be found in _TaskQA/EventQA.C_ and _TaskQA/EventQA_Runwise.C_ (and accordingly for the other three examples)

## GRID running

All QA tasks need to have the _slow_ option active as well as _runwise processing_ must be enabled on GRID (remember to include this in your request [Requesting a LEGO Train](AliPhysicsAndGrid/legotrains.md)).

* The PhotonQA is run by specialized wagons running the AddTask_PhotonQA, they can be found on the MonAlisa pages in the _Group PCM_ - look for _PhotonQA*_.
* The EventQA needs the standard output by one of our standard analysis tasks (GammaConvV1, GammaCalo, GammaConvCalo,..)
* For ClusterQA peferably run the standard calorimeter-related tasks GammaCalo & GammaConvCalo (as you will need output from both to verify the energy calibration) - if bad cell identification should be performed in addition, one of both tasks need to be run with QA level, for example '5' to enable full QA output including cell QA

Two different sets of download macros are available in _DownloadAndDataPrep/*_ and _TaskQA/Grid_CopyFiles*_, see [Download Files from GRID](AliPhysicsAndGrid/download.md) to download the runwise output as well as the fully merged output from GRID.

## Processing

> Always run the runwise macros first, then the merged output (also referred to as periodwise or full output).

For runwise processing with the QA framework, the _Gamma*.root_ files should be placed in the following folder scheme in the AnalysisSoftware folder ([AnalysisSoftware Repository](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware)):

> DataQA / -DATE- / -PERIODNAME- / -RUNNUMBER- / Gamma*.root (for example: DataQA/20180104/LHC15h1b/177681/GammaCalo_104.root and so on for the differnt runs available for the given dataset)

> Furthermore, all screen output is saved in _*.log_ files - watch for them if you want to look up any information.

Make sure that a file _runlists -PERIODNAME-.txt_ (for example runlistsLHC15h1b.txt) is contained in _DownloadAndDataPrep/runlists_ containing the different run numbers line by line (examples may be found when checking out from [AnalysisSoftware Repository](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware)) as the QA framework will look for the run numbers in that folder per default.

**Central Steering Macros**

The central steering macros for the QA framework are:

* QAV2.C
* QA_RunwiseV2.C

which can be called from bash via:

> root -x -l -b -q TaskQA/QAV2.C\+\(\"config.txt\"\,kTRUE\,kTRUE\,kTRUE\,kTRUE\,kTRUE\,2\,\"eps\"\)

and

> root -x -l -b -q TaskQA/QA_RunwiseV2.C\+\(\"config.txt\"\,kTRUE\,kTRUE\,kTRUE\,kTRUE\,kTRUE\,2\,\"eps\"\)

Example configurations for _config.txt_ may be found within _TaskQA/ExampleConfigurations_ while the other parameters of the functions stand for:

* doEventQA -> _kTRUE_
* doPhotonQA -> _kTRUE_ (set _kFALSE_ if you are not using any photon conversions)
* doClusterQA -> _kTRUE_ (set _kFALSE_ if you are not using any calorimeter clusters)
* doMergedQA -> _kTRUE_ (set _kFALSE_ if you are not running a merged analysis)
* doPrimaryTrackQA -> _kTRUE_ (set _kFALSE_ if you are not running Dalitz or neutral meson analysis via 3 pions)
* doExtQA -> _2_ (_0_ -> switched off, _1_ -> normal QA mode, _2_ extendedQA mode with cell QA)
* suffix -> _eps_ (_pdf_,_C_,...)


**IMPORTANT FOR RUNNING PHOTON QA**

As we are using TTrees for the photon QA, there is a slightly different approach in this case:

> _only_ download runwise output for the photon QA, as in most cases the full merges _will_ fail on GRID due to huge output size!
> during processing of PhotonQA_Runwise.C, the periodwise output will be automatically produced!


## Energy Calibration of Calorimeters

Furthermore, the energy calibration of calorimeters directly follows the QA stage and is described in 

* [Energy Calibration of Calorimeters](QA/ecalib.md)

> the macros are contained in [AnalysisSoftware Repository](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware) in TaskV1/*

Generally, all macros/functions should be able to handle EMCal as well as PHOS and DCal, but for last two calorimeters special care needs to be taken and every QA step still needs to be verified in detail (after sucessful validation this statement may be removed).
In general, the calibration of calorimeters is performed by the specific detector groups for EMCal/DCal and PHOS. What we are referring to in this chapter is an improved energy calibration scheme based on the measured pi0-peak position in data to which the simulated MC mass positions are tuned to. In general, it may happen that an improved energy calibration is not needed but still then the macros should be run to cross-check the calibration.

