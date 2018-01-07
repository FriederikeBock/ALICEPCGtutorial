# Overview of Running Neutral Meson Analysis and Direct Photon

The analysis of the neutral mesons and direct photons, which is done after the pure grid analysis is organized in different macros, where we tried to have one macro per analysis step. Thus we split the steps of signal extraction, out-of-bunch pileup calculation, correction, cocktail processing, double ratio calculation, cut comparsion and systematics calculation into different macros. However, as the most of the macros need input from a previous step and it would be cumbersome to change the macro calls each time with the appropriate file. Most of steps, which need no manual intervention or optimization are handled by our steering scripts:

* _start\_FullMesonAnalysis\_TaskV3.sh_ - handling the $$\pi^0$$ & $$\eta$$  in the $$\gamma\gamma$$-decay channel and the merged analysis as well as direct photon analysis
* _start\_FullMesonAnalysisDalitz\_TaskV2.sh_ - handling the $$\pi^0$$ & $$\eta$$  in the $$\gamma e^+e-$$-decay channel 
* _start\_FullOmegaMesonAnalysis.sh_ - handling the $$\eta$$ and $$\omega$$ analysis in the $$\pi^0 \pi^+ \pi^-$$ and $$\pi^0 \gamma$$ channel

They are stored in the main directory of the [PCG-Afterburner directory](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware). A visualisation of the paths for the neutral meson analysis in the $$\gamma\gamma$$-channel and the direct photon analysis can be found below using the _start\_FullMesonAnalysis\_TaskV3.sh_. It explains the main path of the analysis in the standard setup.

![](/assets/SoftwareOverviewNeutralMesonAndDirGamma.jpg)

However, as usual there are some exceptions and you might want to read the corresponding script ones if you are analysing a well know data set for the first time, as for instance it might be necessary to run a special merging step for the efficiencies from added signals and minimum bias or jet-jet simulations. Each of the three scripts is also equipped with a short helper page, which can be called '--help' or '-h' after the script name.

In general the repository is ordered as follows:

* [**main directory**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware): 
  * Contains general steering scripts for the macros \(_start\_FullMesonAnalysis\_TaskV3.sh, start\_FullMesonAnalysisDalitz\_TaskV2.sh, start\_FullOmegaMesonAnalysis_\), as mentioned above.  
  * Furthermore, the macros to calculate the systematics of the different analysis techniques \(_FinaliseSystematicErrors\[Calo,Conv,ConvCalo,Merged,Dalitz\]\_\[$SYSTEM$ENERGY\].C\),_ the combination macros for the mesons/gammas from different reconstruction techniques_ \(CombineMesonMeasurements\_\*.C, CombineGammaResults\_\*.C\) as well as comparison macros among different energies and particles \(_CombineNeutralPion\*.C, CompareCharged\*.C, CompareGamma\*.C_\). Most of these are tailored to specific energies and cannot be used as generalized macros, but have either been used for the corresponding publications or for the preliminary creation. 
  * Additional import macros contained in the main directory regarding the publications are the _CalculateReference.C_, _CalculateSignificanceToPYTHIA.C, ComputeCorrelationFactors.C, TestMtScaling.C_ which can be used in a slightly more general way. In addition to these there are more specific macros, which were used for the publications \(p-Pb mesons and the first meson paper\), which are not necessarily maintained any longer.
  * The compilation macros of the external inputs for different data files from ALICE and other experiments \(_PrepareChargedPionDataALICE\*.C,ProduceExperimentalDataGraphsPbPb.C_\) and theory predictions \(_ProduceTheoryGraphs\*.C_\) can also be found here.
* [**CocktailInput**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CocktailInput): 
  Contains the output files from the cocktail generation on the grid, which are needed as input for the Afterburners once they are final. Furthermore, contains the final processed files by _PrepareCocktail.C_ if they are close to preliminary or publication. We ask everyone not to commit too large root files here, as these will blow up the size of the repository and cannot be deleted fully again.

* [**CommonHeaders**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders): 
  Contains the header files which are commonly used in different macros:
    * [_AdjustHistRange.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/AdjustHistRange.h) contains the functions to automatically adjust the ranges for the QA output included in **TaskQA/**
    * [_CombinationFunctions.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/CombinationFunctions.h) contains all functions (and support routines) to combine results from different detectors/triggers (`CombinePtPointsSpectraFullCorrMat()`,`CombinePtPointsSpectraTriggerCorrMat()`) or compare spectra with different or the same binnings (`CalculateRatioBetweenSpectraWithDifferentBinning()`). Furthermore the previously used functions to combined only the fully independent results from PHOS and PCM are kept in this header files (`CombinePtPointsSpectraAdv(), CombinePtPointsSpectra(), CombinePtPointsRAA()`), however, they should not be used anymore as they will no longer be maintained. Most of these functions do rather delicate operations (i.e. matrix inversions, transformations of graphs & histos into each other, ...) as such please check the `couts`, they are ment as control and debug output. Last but not least it contains a function to calculate weighted quantities based on the $$p_T$$-dependent weights obtained in `CombinePtPointsSpectraTriggerCorrMat()` to properly display for instance the efficiency, acceptance, mass-position... . This function is, however, not yet fully vetted for all special cases, thus please have a look at the outcome and make sure the results are sensible.
    
    * [_ConversionFunctionsBasicsAndLabeling.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/ConversionFunctionsBasicsAndLabeling.h) 
    * [_ConversionFunctions.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/ConversionFunctions.h) 
    * [_ExtractSignalBinning.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/ExtractSignalBinning.h) 
    * [_ExtractSignalPlotting.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/ExtractSignalPlotting.h) 
    * [_FittingGammaConversion.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/FittingGammaConversion.h) 
    * [_PlottingGammaConversionAdditional.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/PlottingGammaConversionAdditional.h) 
    * [_PlottingGammaConversionHistos.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/PlottingGammaConversionHistos.h) 
    * [_PlottingInterPolationRpPb5023GeV.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/PlottingInterPolationRpPb5023GeV.h) & [_Interpolation5023GeV.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/Interpolation5023GeV.h) are used in the p-Pb interpolation macros and contain specific functions for that as well as the binnings needed for the interpolation.
    * [_PlottingMeson.h_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CommonHeaders/PlottingMeson.h) contains the specific plotting functions for the meson QA needed in the framework.

* [**DownloadAndDataPrep**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/DownloadAndDataPrep): 
  

* [**RooUnfold**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/RooUnfold): 
  

* [**ExternalInput**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/ExternalInput)**, **[**ExternalInputpPb**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/ExternalInputpPb)**, **[**ExternalInputPbPb**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/ExternalInputPbPb)**, **[**LHC11hInputFiles**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/LHC11hInputFiles): 
  

* [**SimulationStudies**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/SimulationStudies)**, **[**ToyModels**](https://www.gitbook.com/book/friederikebock/pcgtutorial/ToyModels): 
  

* [**DeprecatedMacros**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/DeprecatedMacros): 
  

* [**SupportingMacros**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/SupportingMacros): 
  

* [**SystematicErrorsNew**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/SystematicErrorsNew)**, **[**SystematicErrorsOld**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/SystematicErrorsOld): 
  

* [**TaskFlow**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/TaskFlow): 
  

* [**TaskQA**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/TaskQA): 
  

* [**TaskV1**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/TaskV1): 
  

Before you start analysis, get input .root files from grid and change their format by using macros in the folder **AnalysisSoftware /DownloadAndDataPrep/ **.

_ChangeStructureToStandard.C_

* Since the output from the task GammaConvV1 is not in a format readable by the following codes, you need to run this macro on the .root file \(what it does is just changing the name of the folder inside\)
  ```
  root -x -q -l -b 'TaskV1/ChangeStructureToStandard.C++("GammaConvV1x.root","GammaConvV1(name)_x.root","GammaConvV1_x")'
  ```

Shell scripts begin with "Get ... sh"  
helpful to get files from grid and change structure at a time. \(what they do are create list of file to get \(alien\_ls\), copy from the grid \(alien\_cp\), change structure \(run ChangeStructure...\), and merge them\(hadd\)\)

Following codes are in the folder **AnalysisSoftware/TaskV1**

_ExtractSignalV2.C_

* analyses the invariant mass of the mesons for each pT bin, subtracts BG, fits with functions, gives raw yields.
* the binning for the pT for pi0/eta is defined in the header ExtractSignalBinning.h \(location: **AnalysisSoftware/CommonHeaders/**\)

_AnalyseDCATestV1.C_

* calculates the fraction of photons from out-of-bunch pileup
* input file is GammaConvV1 \_\(name\)\_x.root with dca tree.

_CorrectSignalV2.C_

* applies the raw yields to all the corrections they need \(the input for this macro is the output from the _ExtractSignalV2.C_ and _AnalyseDCATestV1.C_\). Also in this a .root file and plots are produced

_CutStudyOverview.C_

* gives systematic uncertainty on cut variation with different sets of cuts.
* input: CutSelection.log + uncorected file, corrected file

_MakeCutLog.C_

* gives CutSelection.log

Running above macros \(except _AnalyseDCATestV1.C_\) is done by _start\_FullMesonAnalysis\_TaskV2.sh in this order: MakeCutLog.C_ -&gt; _ExtractSignalV2.C_ -&gt; _CorrectSignalV2.C_ -&gt; _CutStudyOverView.C_

_FinaliseSystematicErrorsYY\_ZZ.C_ \(YY = method, ZZ = collision system and energy\)

* gives a graph of all systematic uncertainties and their quadratic sum. also produce .dat file.

_ProduceFinalResultsV2.C_

* gives corrected yield of each mesons with systematic uncertainties.



