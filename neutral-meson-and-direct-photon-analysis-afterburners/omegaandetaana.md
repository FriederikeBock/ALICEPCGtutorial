# Omega and Eta Analysis

Because the $$\omega$$ and the $$\eta$$ can both decay into $$\pi^+\pi^-\pi^0$$, the analysis in this decay channel is organized in a single analysis task: **AliAnalysisTaskNeutralMesonToPiPlPiMiPiZero.cxx**.

Analogue to the neutral pion analysis, there is a single macro that starts the first afterburners needed to process the output files of the task. The **start\_FullOmegaMesonAnalysis.sh** macro -- even though the name might be misleading -- takes care of the signal extraction \(using **ExtactSignalPiPlPiMiPiZero.cxx**\) and its correction \(using **CorrectSignalPiPlPiMiPiZero.cxx**\) for $$\omega\rightarrow\pi^+\pi^-\pi^0$$ _and_ $$\eta\rightarrow\pi^+\pi^-\pi^0$$ .

```text
  start_FullOmegaAnalysis.sh [-$OPTION] $Data-file.root [$MC-file.root] eps
```

In case either the data- or MC-file is missing, you can just pass the macro a dummy string. E.g the command

```text
bash start_FullOmegaAnalysis.sh /Path/To/datafile.root bla eps
```

will run the signal extraction macro two times -- once for the $$\omega$$ and once for the $$\eta$$ -- but won't run the correction macro afterwards, because it detected that you didn't provide it with a valid MC file.

There are several options available for this macro \(which are still work in progress\) that let you e.g. only analyse the $$\omega$$ \(**--omegaOnly**\) or the $$\eta$$ \(**--etaOnly**\). For a full list of available options please use the **-h** flag.

If you start the _start\_FullOmegaAnalysis.sh_ macro by hand, you will be asked about several things needed for the signal extraction and correction. The questions are similar to the ones asked e.g. by _start\_FullMesonAnalysis\_TaskV3.sh_, however there are some differences, so we will go through the questions one-by-one in the following chapter.

## start\_FullOmegaAnalysis.sh

First we start the macro using \(e.g.\):

```text
bash start_FullOmegaMesonAnalysis.sh /referenceDirectory/Legotrain-vAN-20171122-7TeV-omegaAnalysis/LHC10_GammaConvNeutralMesonPiPlPiMiPiZero_0_29.root /referenceDirectory/Legotrain-vAN-20171122-7TeV-omegaAnalysis/LHC14j4_GammaConvNeutralMesonPiPlPiMiPiZero_0_29.root eps
```

First, the macro will print the full path of the input files you specified. This comes in handy to track down if you got something wrong while using e.g. relative paths. The first thing you will be asked is to specify the method \(mode\) used to reconstruct the decay-photons of the $$\pi^0$$:

```text
The data file specified is /data/alice/pp7TeV/Legotrain-vAN-20171122-7TeV-omegaAnalysis/LHC10_GammaConvNeutralMesonPiPlPiMiPiZero_0_29.root
The MC file specified is /data/alice/pp7TeV/Legotrain-vAN-20171122-7TeV-omegaAnalysis/LHC14j4_GammaConvNeutralMesonPiPlPiMiPiZero_0_29.root
Which mode are you running? 40 (PCM-PCM *), 41 (PCM-EMCAL *), 42 (PCM-PHOS *), 43 (PCM-DCAL), 44 (EMCAL-EMCAL *), 45 (PHOS-PHOS*), 46 (DCAL-DCAL), 47 (PCM-DALITZ), 48 (EMCAL-DALITZ), 49 (PHOS-DALITZ), 50 (DCAL-DALITZ)
```

As you may have noticed, the **mode numbers** used for this analyisis **differ from the ones used for the** $$\gamma\gamma$$**-analysis**. This was implimented to avoid any conflicts between the two analysis \(e.g. between $$\eta\rightarrow\gamma\gamma$$ and $$\eta\rightarrow\pi^+\pi^-\pi^0$$\). The modes currently implemented are marked with a '\*'. For the sake of completeness, you can find a nicely formated table of the numbering scheme used in this analysis below:

| mode | reconstruction technique |
| :--- | :--- |
| 40 | PCM-PCM |
| 41 | PCM-EMCal |
| 42 | PCM-PHOS |
| 43 | PCM-DCal |
| 44 | EMCal-EMCal |
| 45 | PHOS-PHOS |
| 46 | DCal-DCal |
| 47 | PCM-Dalitz |
| 48 | EMcal-Dalitz |
| 49 | PHOS-Dalitz |
| 50 | DCal-Dalitz |

This information will later be used by the signal extraction macro to check if your choice is actually consistent with the input files you provided. After you entered the desired mode, you will be asked

```text
Do you want to take an already exitsting CutSelection.log-file. Yes/No
```

**If you select no**, the macro will write all the cut strings found in the input file in a file called _CutSelection.log_ sperated by \[ENTER\] \(using the [_MakeCutLog.C_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/TaskV1/MakeCutLog.C) macro\) and then run the signal extraction \(and correction\) for each cut string in that file. **If you select yes**, the macro will search for an existing _CutSelection.log_ file in the current working directory and run the afterburners for all cut strings contained in that file. This option is therefore useful if you just want to run the afterburners on a particular set of cut strings.

Let's assume we want to run the afterburners on all the cuts contained in the input file, so we answer with "no". The output should look something like this:

```text
-> found TopDir: GammaConvNeutralMesonPiPlPiMiPiZero
0_00000113_00200009327000008250400000_0103503800000000_302010708_0153503000000000
0_00000113_00200009327000008250400000_0103503800000000_302010708_0b53503000000000
0_00000113_00200009327000008250400000_0103503800000000_302010708_0c53503000000000
0_00000113_00200009327000008250400000_0103503800000000_302010708_0d53503000000000
Which collision system do you want to process? 8TeV (pp@8TeV), 7TeV (pp@7TeV), 13TeV (pp@7TeV, 900GeV (pp@900GeV), 2.76TeV (pp@2.76TeV), PbPb_2.76TeV (PbPb@2.76TeV), pPb_5.023TeV (pPb@5.023TeV)
```

Make sure that the macro detected all the cuts correctly and proceed by entering the collision system you are analysing. In this example, we will choose pp@7Tev.

```text
The collision system has been selected to be 7TeV.
How many p_T bins do you want to use for Omega? 36(7gev), 37(8gev), 38(10gev), 39(12gev), 40 (16gev), 41 (20gev), 42 (25gev)
```

After the collision system was selected, you have to specify how many $$p_T$$-bins should be analysed. This question is a bit misleading, because you are actually specifying up to what index in your $$p_T$$-bin array stored in ExtractSignalBinning.h you want to do the analysis. The total number of analysed bins would then be $$N_{\text{StartBin}}-N_{\text{EndBin}}$$. **Important: Make sure that the** $$p_T$$**-bin choosen here is not actually greater than the length of the array containing your binning for this analysis \(see ExtractSignalBinning.h\) ! Also: At the moment only the use of same number of** $$p_T$$ **bins for** $$\omega$$ **and** $$\eta$$ **are supported.**

```text
You have chosen  14  pt bins for Omega
mode has been chosen: 40 
I went into standard modes
Which fit do you want to do? CrystalBall or gaussian convoluted with an exponential function? CrystalBall/Gaussian?
Gaussian
Gaussian chosen ...
Please check that you really want to process all cuts, otherwise change the CutSelection.log. Remember at first all gamma cutstudies will be carried out. Make sure that the standard cut is the first in the file. Continue? Yes/No?
Yes
```

After choosing the desired fitting function for the $$\omega$$ / $$\eta$$ -peak \(using **gaussian** is recommended, no testing was done for crystal ball so far\), you will be asked if you are sure to process all cuts. After confirming this final question, the afterburners should go to work!

## ExtractSignalPiPlPiMiPiZero.C

This macro is used to extract the invariant mass distribution of the meson signal for each analyzed $$p_T$$-bin and its usage and tasks are almost identical to [_**ExtractSignalV2.C**_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/TaskV1/ExtractSignalV2.C). You can start the macro using:

```text
root -b -x- q -l 'TaskV1/ExtractSignalPiPlPiMiPiZero.C+("$MESONAME","/path/to/input.root","$CUTNUMBER","$SUFFIX","$MCOPTION","$ENERGY","Gaussian","","","",$NPTBINS,$OPTIONADDSIG,$MODE)'
```

Example usage \(**Data**\):

```text
root -b -x- q -l 'TaskV1/ExtractSignalPiPlPiMiPiZero.C+("Omega","/data/alice/pp7TeV/Legotrain-vAN-20171122-7TeV-omegaAnalysis/LHC10_GammaConvNeutralMesonPiPlPiMiPiZero_0_29.root","0_00000113_00200009327000008250400000_0103503800000000_302010708_0d53503000000000","pdf","kFALSE","7TeV","Gaussian","","","",14,kFALSE,40)'
```

Example usage \(**MC**\):

```text
root -b -x- q -l  'TaskV1/ExtractSignalPiPlPiMiPiZero.C+("Omega","/data/alice/pp7TeV/Legotrain-vAN-20171122-7TeV-omegaAnalysis/LHC14j4_GammaConvNeutralMesonPiPlPiMiPiZero_0_29.root","0_00000113_00200009327000008250400000_0103503800000000_302010708_0d53503000000000","pdf","kTRUE","7TeV","Gaussian","","","",14,kFALSE,40)'
```

## Further Processing

The following macros that allow further processing of the extracted signals have been implemented for $$\omega$$ / $$\eta$$ analysis so far:

* [_**CorrectSignalPiPlPiMiPiZero.C**_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/TaskV1/CorrectSignalPiPlPiMiPiZero.C)
* [_**ProduceFinalResultsPiPlPiMiPiZero.C**_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/TaskV1/ProduceFinalResultsPiPlPiMiPiZero.C)
* [_**CombineMesonMeasurementsPiPlPiMiPiZero.C**_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/CombineMesonMeasurementsPiPlPiMiPiZero.C)

  ​

