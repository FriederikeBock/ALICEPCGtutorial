#Overview of Running Neutral meson analysis

Task AliAnalysisTaskGammaConvV1.cxx gives GammaConvV1 _x.root (x = train config).

Before you start analysis, get input .root files from grid and change thier format by using macros in the folder AnalysisSoftware /DownloadAndDataPrep/ .

_ChangeStructureToStandard.C_
* Since the output from the task GammaConvV1 is not in a format readable by the following codes, you need to run this macro on the .root file (what it does is just changing the name of the folder inside)
$root -x -q -l -b 'TaskV1/ChangeStructureToStandard.C++("GammaConvV1_x.root","GammaConvV1_(name)_x.root","GammaConvV1_x")'

Shell scripts begin with "Get ... sh"
helpful to get files from grid and change structure at a time. (what they do are create list of file to get (alien_ls), copy from the grid (alien_cp), change structure (run ChangeStructure...), and merge them(hadd))

Following codes are in the folder *AnalysisSoftware/TaskV1*

_ExtractSignalV2.C_
* analyses the invariant mass of the mesons for each pT bin, subtracts BG, fits with functions, gives raw yields.
* the binning for the pT for pi0/eta is defined in the header ExtractSignalBinning.h (location: AnalysisSoftware /CommonHeaders/)
_AnalyseDCATestV1.C_
* calculates the fraction of photons from out-of-bunch pileup
* input file is GammaConvV1 _(name)_x.root with dca tree.
_CorrectSignalV2.C_
* applies the raw yields to all the corrections they need (the input for this macro is the output from the ExtractSignalV2.C and AnalyseDCATestV1.C). Also in this a .root file and plots are produced
_CutStudyOverview.C_
* gives systematic uncertainty on cut variation with different sets of cuts.
* input: CutSelection.log + uncorected file, corrected file
_MakeCutLog.C_
* gives CutSelection.log

Runnning above macros (except _AnalyseDCATestV1.C_) is done by _start/_FullMesonAnalysis/_TaskV2.sh in this order: _MakeCutLog.C_ -> _ExtractSignalV2.C_ -> _CorrectSignalV2.C_ -> _CutStudyOverView.C_


_FinaliseSystematicErrorsYY/_ZZ.C_ (YY = method, ZZ = collision sysytem and energy)
* gives a graph of all systematic uncertainties and their quadratic sum. also produce .dat file.
_ProduceFinalResultsV2.C_
* gives corrected yield of each mesons with systematic uncertainties.