# Combination of Measurements

The combination of measurements is described in its latest version in Combination Notes [pp 8 TeV](https://aliceinfo.cern.ch/Notes/node/522), [pp 2.76 TeV](https://aliceinfo.cern.ch/Notes/node/484), from which all details about the procedures itself can be extracted.
Further details about the combination of triggers within one method can be obtained from the respective analysis notes of the measurements, linked in [Analysis Notes and Papers](/Introduction/notes.md).

**!!!**
Keep in mind that any combination of measurements is **HIGHLY** non-trivial and needs special care in all of its steps (uncertainties, correlations, bin-shifting, fitting, weights for combination, comparison with other measurements,...)!
**!!!**

## Correlation Coefficients of Statistical/Systematic Uncertainties

For the BLUE method, the statistical as well as systematic uncertainties of the measurements are needed as input for the combination (see Analysis Notes above).

In general, however, the statistical as well as systematic uncertainties may be correlated, for example combining PCM and PCM-EMCal but also for many other different cases (carefully think about any possibility how your measurements could be correlated in statistics+systematics -> general event cuts like SPD background rejection are the same for all measurements, although the correlation of systematics will be rather small, but still it exists).

For the case of different triggers being available for a reconstruction method, for example minimum bias and calorimeter triggers for EMCal/DCal/PHOS methods, the systematic uncertainties are found to be highly correlated in general - thus a proper consideration of correlation coefficients is already needed on the level of single methods/measurements.

An example configuration and how-to run the macro can be found here for the example of the neutral pion measurements for pp @ 8 TeV:

```
root -x -l -q -b ComputeCorrelationFactors.C\+\(\"input.log\"\,\"systems\"\,\"Pi0\"\,\"8TeV\"\,2\,\"eps\"\)
```

The macro needs an input log-file, for which you find an example configuration below.

It takes the number of measurements and then the links to the systematic files, **_SystematicErrorAveragedSingle*_**, together with the method name, the number of bins and pT ranges.

Then, the single uncertainty sources are listed from the first method with respect to the second method, in how much % of the uncertainty is uncorrelated with respect to the latter method.

```
3
PCM 29 0.3 12.0 SystematicErrorAveragedSinglePCM_Pi0_8TeV_2017_11_03.dat
PCMEMC 40 0.8 35.0 FinalResultsTriggersPatched_PCMEMCAL/SystematicErrorAveragedSinglePCMEMC_Pi0_8TeV.dat
EMC 35 1.2 18.0 FinalResultsTriggersPatched_EMCAL/SystematicErrorAveragedSingleEMCEMC_Pi0_8TeV.dat
PCM PCMEMC YieldExtraction 95%
PCM PCMEMC PileupDCA 100%
PCM PCMEMC Material 50%
PCM PCMEMC dEdxE 75%
PCM PCMEMC dEdxPi 50%
PCM PCMEMC TPCCluster 25%
PCM PCMEMC SinglePt 50%
PCM PCMEMC Chi2 50%
PCM PCMEMC Qt 50%
PCM PCMEMC Alpha 25%
PCM PCMEMC BG 100%
PCM PCMEMC BGEstimate 100%
PCMEMC PCM YieldExtraction 95%
PCMEMC PCM Alpha 25%
PCMEMC PCM ConvPhi 100%
PCMEMC PCM ClusterMinEnergy 100%
PCMEMC PCM ClusterNCells 100%
PCMEMC PCM ClusterNonLinearity 100%
PCMEMC PCM ClusterTrackMatching 100%
PCMEMC PCM ClusterM02 100%
PCMEMC PCM CellTiming 100%
PCMEMC PCM ClusterMaterialTRD 100%
PCMEMC PCM Trigger 100%
PCMEMC PCM Efficiency 100%
PCMEMC PCM ClusterEnergyScale 100%
PCMEMC PCM ClusterTime 100%
PCMEMC PCM ClusterizationEnergy 100%
EMC PCMEMC YieldExtraction 95%
EMC PCMEMC OpeningAngle 100%
EMC PCMEMC ClusterMinEnergy 50%
EMC PCMEMC ClusterNCells 50%
EMC PCMEMC ClusterNonLinearity 50%
EMC PCMEMC ClusterTrackMatchingCalo 75%
EMC PCMEMC ClusterM02 50%
EMC PCMEMC CellTiming 50%
EMC PCMEMC Efficiency 50%
EMC PCMEMC ClusterEnergyScale 50%
EMC PCMEMC ClusterTime 50%
EMC PCMEMC ClusterizationEnergy 50%
PCMEMC EMC YieldExtraction 95%
PCMEMC EMC Material 100%
PCMEMC EMC dEdxE 100%
PCMEMC EMC dEdxPi 100%
PCMEMC EMC TPCCluster 100%
PCMEMC EMC SinglePt 100%
PCMEMC EMC Chi2 100%
PCMEMC EMC Qt 100%
PCMEMC EMC Alpha 100%
PCMEMC EMC ConvPhi 100%
PCMEMC EMC ClusterMinEnergy 25%
PCMEMC EMC Efficiency 50%
```

The correlation macro automatically reads in all the files and calculates the correlation coefficients for all common bins of the different methods.

It outputs a _*.root_ file with all the correlation factors as well as figures, examples shown below for the neutral pion pp@8TeV:

![](/assets/pp8TeV_Systems_Pi0_corrFactors.jpg)

Not only systematic correlations can be calculated, the statistical correlation factors can also be determined using the macro and adjusting the list of parameters accordingly.

**IMPORTANT NOTE**

To use the correlation factors in your combination, make sure to add the cases to **_CombinePtPointsSpectraFullCorrMat_**, example:

```
cout << "\n**************************************************************************************************" << endl;

cout << "loading systematic correlations..." << endl;

cout << "**************************************************************************************************\n" << endl;

corrFracPCM_PCM_PCMEMC[0] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems", mesonType, "PCM_PCM-PCMEMC");
corrFracPCMEMC_PCM_PCMEMC[0] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems", mesonType, "PCMEMC_PCM-PCMEMC");
corrFracPCMEMC_PCMEMC_EMC[0] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems", mesonType, "PCMEMC_PCMEMC-EMC");
corrFracEMC_PCMEMC_EMC[0] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems", mesonType, "EMC_PCMEMC-EMC");
corrFracPCM_PCM_EMC[0] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems", mesonType, "PCM_PCM-EMC");
corrFracEMC_PCM_EMC[0] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems", mesonType, "EMC_PCM-EMC");

cout << "\n**************************************************************************************************" << endl;
cout << "loading statistical correlations..." << endl;

cout << "**************************************************************************************************\n" << endl;

if (GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems_Stat", mesonType, "PCM_PCM-PCMEMC") != -10)
  corrFracPCM_PCM_PCMEMC[1] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems_Stat", mesonType, "PCM_PCM-PCMEMC");
if (GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems_Stat", mesonType, "PCMEMC_PCM-PCMEMC") != -10)
  corrFracPCMEMC_PCM_PCMEMC[1] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems_Stat", mesonType, "PCMEMC_PCM-PCMEMC");
if (GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems_Stat", mesonType, "PCMEMC_PCMEMC-EMC") != -10)
  corrFracPCMEMC_PCMEMC_EMC[1] = GetCorrFactorFromFile(fCorrFactors,xValue[ptBin], "Systems_Stat", mesonType, "PCMEMC_PCMEMC-EMC");
```

## Combination of different Measurements

The combination of different measurements is performed in the macros **_CombineMeson..._** and **_CombineGamma..._**. In the following examples are shown (many more macros are available in the _AnalysisSoftware_ repository):

> CombineMesonMeasurements8TeV.C
```
root -x -l -b -q CombineMesonMeasurements8TeV.C\+\(\"$PCMfile\"\,\"$PCMEMCfile"\,\"$EMCfile\"\,\"$mergedEMCfile\"\,\"$PHOSfile\"\,\"eps\"\,\"\"\,\"\"\,\"XY\"\,\"ComputeCorrelationFactors_pp8TeV/pp8TeV.root\"\,kTRUE\,kFALSE\)
```

The input files from PCM, PCMEMC, EMC, mergedEMC and PHOS need to be fed in, generated by **_TaskV1/ProduceFinalResultsPatchedTriggers.C_**. Furthermore, the output mode for the figures ("eps") is specified as well as in which direction bin-shifting should be applied for the combined spectra ("XY"). The file containing the correlation factors for _pp@8TeV_ needs to be hand over and some more plotting options are set with last two bools.

The macro performs the combination of all different input measurements and plots the final results, stored as _.eps_ files as well as in _.root_ files, see Combination Note [pp 8 TeV](https://aliceinfo.cern.ch/Notes/node/522) which contains lots of the output generated by the combination macro.

> CombineGammaResultsPP8TeV.C
```
root -x -l -q -b CombineGammaResultsPP8TeV.C\+\(\"$PCMfile\"\,kFALSE\,\"\"\,kTRUE\,\"$EMCfile\"\,kTRUE\,\"$PCMEMCfile\"\,\"$cocktail\"\,\"C\"\,\"$corrFile\"\,kFALSE\,1.28\,kTRUE\,\"FitsPaperPP8TeV_2017_11_16.root\"\)
```

The input files from PCM, PCMEMC, EMC need to be fed in, generated by **_TaskV1/CalculateGammaToPi0V4.C_**. Furthermore, the cocktail file is specified as well as the fits of the neutral meson spectra. The file containing the correlation factors for _pp@8TeV_ needs to be hand over and some more plotting options are set. The number "1.28" specifies the nsigma to calculate upper limits on the direct photon spectra.
