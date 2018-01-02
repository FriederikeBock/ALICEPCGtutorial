# How to make a cocktail simulation

The generator level particle decay simulation, also called "cocktail simulation" is used for the secondary neutral pion or secondary photon correction as well as for the decay photon spectra necessary for a direct photon measurement.

The cocktail itself is based on parameterizations of \(measured\) particle spectra and uses mT scaling for the remaining spectra. In the following the basic steps for the cocktail generation are described exemplary for pp 5 TeV. This includes the procedure to add new input spectra to the cocktail, the parametrization of these spectra and finally the generation of the simulation.

The cocktail framework repository can be found at [**https://gitlab.cern.ch/alice-cocktail-EM/cocktail\_input**.](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input) The most updated branch is the "devel" branch which is merged into the master on a monthly basis. It is therefore recommended to checkout the devel branch when working on the cocktail framework.

## Adding new input spectra

In this part of the tutorial it is explained how to add new spectra to the cocktail. This is done in the macros **CocktailProduceCompleteInputFilePP.C, CocktailProduceCompleteInputFilePPb.C or CocktailProduceCompleteInputFilePbPb.C **depending on the desired collision system. _Side remark: XeXe is not yet included in the framework_. These macros are controlled with the respective bash scripts \(e.g.via **script\_startProduce\_pp.sh newInputPP**\). This will create the input spectra file for all currently defined center of mass energies from 0.9 to 13 TeV.

In order to add spectra to the pp 5 TeV cocktail it is necessary to have the _TList \*list\_5TeV_ defined and activated via the first argument of the macro. This first argument _TString enableEnergy = "111111"  is a simple switch for all defined center of mass energies starting from the left with 0.9 TeV and the last digit being the switch for 13 TeV. For 5 TeV, at least the third digit in the string should be set to 1 \(e.g. "001000"\). The lists for the different center of mass energies are filled in ascending energy order starting with 900 GeV. The 5 TeV spectra are added within the _  **if \(Include\_5TeV\){ ... }**  condition.

In addition to the center of mass energy switch, also **each particle has its own boolean switch** which are defined in the macro arguments \(e.g. _enable\_NPion, enable\_Eta_, ... \). To now add the neutral pion spectra to the list of input spectra, the condition _if \(enable\_NPion \) { ... }_ or _if \(enableNPion \|\| enableEta \) { ... }_ is used. Usually the latter is used as the neutral meson spectra are measured by us and provided in the file format produced by ProduceFinalResultsTriggersPatched/CombineMesonMeasurements as explained in the neutral meson section including systematic uncertainties.

The file containing the spectra then needs to be loaded and also added to the respective directory in the repository \(pp, pPb, PbPb\). The **spectra can be loaded as TH1D, TGraphErrors or TGraphAsymmErrors** whereas the latter usually allows for the best/easiest fitting.

The spectra then need to be added to the list as **invariant cross section** in the condition _if \(changeQuantity == 0\) { ... } \_and as **invariant yield per inelastic event** otherwise. This requires the right multiplication/division of the respective cross sections to result in the correct quantity. \(e.g. our cross sections are either V0OR or V0AND and therefore need to be divided by the inelastic cross section to obtain invariant yield per inelastic event\). Before the spectra are added to the list, they also **need to be converted to dN/dydpT** with the functions \_SetGraphProperties\(...\)_, or _SetHistoProperties\(...\)_ depending on the format. This also creates the necessary naming scheme of the spectra \(e.g. NPionPCMStat, EtaCombSys, ... \). For this, the right_ fParticle\[\]_ and _fMethod\[\]_ array entries need to be set in the SetGraph/HistoProperties\(...\) function which can be found in _CocktailFunctions.h \_for all particles and methods \(e.g. neutral pions are \_fParticle\[0\] \_and the EMC method is_ fMethod\[4\]\_\).

#### **To summarize:**

1. Create list for given center of mass energy \(if not yet defined\)
2. Load input spectra \(TH1D, TGraphErrors or TGraphAsymmerrors\) with separate spectra for statistical and systematic uncertainties
3. Convert spectra to invariant yield per inelastic event and afterwards to dN/dydpT
4. Apply correct naming scheme using the arrays fParticle\[\] and fMethod\[\]
5. Add spectra to the list

In the following, this part is shown in the full code implementation for a combined neutral pion spectrum at 5 TeV.

```
if (Include_5TeV){
        //================================================================================================================
        // reading and writing pi0 and eta to 5TeV list
        // input from pi0 and eta is given as inv. cross section or inv. yield (no bin shift available)
        //================================================================================================================
        if (enable_NPion || enable_Eta){
            TString localOutputQuantity                             = "#it{E} #frac{d^{3}#sigma}{d#it{p}^{3}} (pb GeV^{-2} #it{c}^{3})";

            TFile* fFileNeutralMeson5TeVComb                        = new TFile("pp/CombinedResultsPaperPP5TeV_2017_10_11.root");
            TDirectoryFile* fFileNeutralMeson5TeVCombPi0            = (TDirectoryFile*)fFileNeutralMeson5TeVComb->Get("Pi05TeV");
            TDirectoryFile* fFileNeutralMeson5TeVCombEta            = (TDirectoryFile*)fFileNeutralMeson5TeVComb->Get("Eta5TeV");

            if (enable_NPion){
                TGraphAsymmErrors* graphNPionXSecEMCAL5TeVStat      = (TGraphAsymmErrors*)fFileNeutralMeson5TeVCombPi0->Get("graphInvCrossSectionPi0EMCAL5TeVStatErr");
                TGraphAsymmErrors* graphNPionXSecEMCAL5TeVSys       = (TGraphAsymmErrors*)fFileNeutralMeson5TeVCombPi0->Get("graphInvCrossSectionPi0EMCAL5TeVSysErr");

                if (changeQuantity == 0){
                    SetGraphProperties(graphNPionXSecComb5TeVStat,  Form("Xsec_%s%sStat",    fParticle[0].Data(), fMethod[1].Data()), "#it{p}_{T} (GeV/#it{c})", localOutputQuantity, "");
                    SetGraphProperties(graphNPionXSecComb5TeVSys,   Form("Xsec_%s%sSys",     fParticle[0].Data(), fMethod[1].Data()), "#it{p}_{T} (GeV/#it{c})", localOutputQuantity, "");

                    list_5TeV->Add(graphNPionXSecComb5TeVStat);
                    list_5TeV->Add(graphNPionXSecComb5TeVSys);

                } else {
                    // convert XSection to invariant yield
                    TGraphAsymmErrors* graphNPionComb5TeVStat       = ScaleGraph(graphNPionXSecComb5TeVStat,1./xSection5023GeVINEL);
                    TGraphAsymmErrors* graphNPionComb5TeVSys        = ScaleGraph(graphNPionXSecComb5TeVSys,1./xSection5023GeVINEL);

                    // convert inv yield to 1/N d^2N/dydpT
                    graphNPionComb5TeVStat                          = ConvertYieldGraph(graphNPionComb5TeVStat,  kFALSE, kFALSE, kTRUE, kTRUE);
                    graphNPionComb5TeVSys                           = ConvertYieldGraph(graphNPionComb5TeVSys,   kFALSE, kFALSE, kTRUE, kTRUE);

                    SetGraphProperties(graphNPionComb5TeVStat,      Form("%s%sStat", fParticle[0].Data(), fMethod[1].Data()), "#it{p}_{T} (GeV/#it{c})", globalOutputQuantity, "");
                    SetGraphProperties(graphNPionComb5TeVSys,       Form("%s%sSys",  fParticle[0].Data(), fMethod[1].Data()), "#it{p}_{T} (GeV/#it{c})", globalOutputQuantity, "");

                    list_5TeV->Add(graphNPionComb5TeVStat);
                    list_5TeV->Add(graphNPionComb5TeVSys);
                }
            }
            if (enable_Eta){
                //...
            }
      }
}
```

This procedure can be repeated for all available particle spectra. However, sometimes one might only have ratios of particle spectra available or prefer to use the ratios for the parametrization. The only difference is then that there is, of course, no normalization to inelastic events necessary and that the SetGraph/HistoProperties\(...\) arguments are as follows:

`SetGraphProperties(graphEtaToPi0CombStat, Form("%sTo%s%sStat", fParticle[1].Data(), fParticle[0].Data(), fMethod[1].Data()), "#it{p}_{T} (GeV/#it{c})", "#eta/#pi^{0}", "");`

Where the _fParticle\[\]_ array entries for both particles of the ratio are required for the naming scheme. Usually, we use the eta/pi0 ratio for the parameterization of the eta spectrum to have a stable high pT tail compared to the neutral pion. It is therefore recommended to always add the ratio in addition to the eta spectrum itself to the list.

## Parametrization

Once all spectra are added and the input spectra file is created \(CocktailInputPP.root\), the spectra can be parametrized. The fitting is done with **CocktailInputParametrization.C **in combination with three text files as input. As given in the bash script, the macro is called the following way.

`oot -x -l -b -q 'CocktailInputParametrization.C+("CocktailInputPP.root","pp_5TeV","eps","parametrizationSettings/pp_5TeV_standard.dat","parametrizationSettings/pp_5TeV_ratio_standard.dat","parametrizationSettings/listAllUniqueNames_5TeV.txt",kFALSE,kFALSE,0,kFALSE)'`

With the input spectra file as first argument, the name of the list as second argument, the figure file format as the third followed by the three text files. The macro itself does not need to be modified for this step. **The only way to influence/change the fitting is via the first text file** \(e.g. parametrizationSettings/pp\_5TeV\_standard.dat \). This file has to be created if it does not already exist and is setup the following way:

`%particle    centrality    method    pt const relsys(%)    ptMin    ptMax    func    opt    par1    par1Low    par1Up    par2    par2Low    par2Up    par3    par3Low    par3Up    par4    par4Low    par4Up`

`NPion    MB    EMCal    0.042    0    14    oHagPt    QNRME+    511.782    -    -    0.1522    -    -    -0.13    -    -    0.44    -    -    6    -    -    stop`

`Eta    MB    PCMEMCal    0.045    1.2    25    tmpt    QNRME+    stop`

**Each line represents one parametrization that can be used in the cocktail**. In this case we have the neutral pion measurement from EMC and the eta meson with PCMEMC. The fourth argument is the portion of the systematic uncertainty that is flat in pT \(e.g. 9% for PCM from the material budget or 4.2% for EMC\). This is followed by the pT range that should be used to fit the spectra. Here 0--14 GeV/c for the pi0 and 1.2--25 GeV/c for eta. For fitting itself a variety of fitting function is available, ranging from Levy-Tsallis over Modified Hagedorn to TCM fits multiplied by pT. **A full overview of these functions can be found in **_**CocktailFitting.h::FitObject\(\). **_**As all of the input spectra are multiplied by pT, the fitting functions should also be the respective functions\*pT \(e.g. **_**oHagPt**_** instead of **_**oHag**_**\).** The next argument is parsed to the fitter and should generally always be QNRME+. If a fit does not need finetuning, the line can then be ended directly via _stop_. It is, however, also possible to set starting parameters for the fits as well as upper and lower parameter limits. Many examples for this can be found in the folder parametrizationSettings in the repository.

The fitting can then be checked in the plots produced by the macro. They can be found in plots/eps/pp\_5TeV in this case. Of interest are here first of all the plots with the name spectra\_NPionEMCal\_default.eps and spectra\_EtaPCMEMCal\_default.eps as these show the ratio of the fit that was defined in the text file above to the spectrum. The fitting parameters/functions/ranges need to be optimized to archieve a good description of the spectra over the full pT range. The high pT region needs to be checked thoroughly as the fit functions will be extrapolated up to 200 GeV/c for the cocktail production.At low pT it is important to not drastically overshoot or undershoot the data and to have the fit function go through \(x=0, y=0\).

The figure below shows a typical ratio of data to fit with a good description from low up to high momentum. Due to statistical fluctuations it can also happen that a datapoint is outside of the +-20% range of the ratio plot. In this case it is important to check the high momentum tail of the fit thoroughly.

![](/assets/pcmemc_npion5tev.png)

Once all spectra fits that are defined in ,e.g. parametrizationSettings/pp\_5TeV\_standard.dat, are made, the fitting procedure goes towards ratio fits. These are defined in this case in parametrizationSettings/pp\_5TeV\_ratio\_standard.dat. This file is build similar to the non-ratio fit file and plotted figures can be found in the same folder as before. In case of the ratio fits it is important to make sure they cross \(0,0\) and that they flatten out towards high momentum.

In order to check the systematic variations of the cocktail, which are obtained via shifitng of the datapoints based on the systematic uncertainties in either all points up or down, two linear variation as well as polinomial variations as well as variations of the mT scaling factors. These variations can be checked in the plot spectra\_NPionEMCal\_paramAllToCentral.eps where the variations should produce rather symmetrical patterns around unity.

Once all spectra are parametrized, the macro will save sets of those parametrizations to the output file that will later on be fed into the cocktail. These sets can be setup for example via parametrizationSettings/pp\_5TeV\_EMCal\_cocktail\_settings.dat which is written the following way:

`%pdg code   mtScaleFactor   mtScaleFacUp     mtScaleFacDown  particle    method  ratio           method`

`111         -               -                -               NPion       EMCal   stop`

`221         -               -                -               NPion       EMCal   EtaToNPion      Comb     stop`

`443         0.054           0.056            0.052           stop`

Each line, again, represents one particle that should be included in the set. The line starts with the PDG code of the particle \(e.g. 111 for the neutral pion\). The next three entries represent the mT scaling factors for particles that were not parametrized in the previous step. Here, particle 443 is mT scaled with a factor of 0.054 from the neutral pion. The next entries are self explanatory, as we in this case want to use the neutral pion parametrization from the EMC method. For the eta meson, we want to use the eta/pi0 ratio from the combined measurement multiplied with the pi0 EMC parametrization. This provides a very nicely described eta parametrization that keeps the high pT ratio value between pi0 and eta.

The resulting sets of parametrizations are plotted again in the folder parametrizations where also the .root file can be found. This root file is then used in the next step for the cocktail generation.

## Cocktail generation \(locally and on the grid\)

The generation of the cocktail, of course, is based on the same macros/classes if run locally or on the grid. The local test is useful to generate a few hundred events and check if your parametrizations are parsed correctly. The local running is handled by runStandaloneCocktail.C which only requires minor modifications to work with new parametrizations. Its base arguments are the amount of events that should be generated \(per event nParticles = 250 \(default\) particles per species are generated flat in pT, rapidity and azimuth\), the collision system \(0: pp, 1: pPb, 2:PbPb\) and the selection of particles to be generated. This selection, e.g. 262079 is the decimal number corresponding to the binary 111111111110111111. Each one represents an activated particle for the simulation and examples can be found at the end of the macro.

Slight modifications need to be made where the parametrizations are loaded from the file created in the previous step.

`gener = AddMCEMCocktailV2(200,0,decayMode,motherSelect,"../parametrizations/pp_5TeV.root","5TeV_PCMEMCal",nParticles,0.,50,10000,0,1,1,0);`

The AliGenerator needs to be set to the right parametrization file, folder, number of particles and pT range \(here 0-50 GeV/c\). The GammaCocktail and HadronicCocktail tasks are already added and can be modified for different rapidity ranges if necessary.

The cocktail is then simply run by the following line to generate 50 events:

`aliroot -x -l -b -q 'runStandaloneCocktail.C(50)'`

On the grid, the procedure requires the parametrization file to be comitted to AliPhysics into the folder AliPhysics/PWG/Cocktail/parametrisations/ where one can either update the existing file or recreate the complete file. To have the cocktail produced just let the trainoperators \(alice-pwg-GA-train-operators@cern.ch\) know which existing or new dataset should be used. Effectively, the full information of the AliGenerator \(gener\) needs to be handed to the operator. Cocktails on the grid are generated with 1M events and show nearly no remaining statistical uncertainties. For a thorough analysis, the systematics of the cocktail have to be requested as soon as the main cocktail is validated.

## Addition: Inter/Extrapolation of particle spectra

This step is an important addition for analyses that require a reliable cocktail early on \(before other particles are measured/published\). For example in the 5 TeV pp case, there were no measured spectra of kaons, protons, phi, omega, ... available, but a first cocktail for the measurements was needed. There is the possibility to use mT scaling for all spectra but this has proven to yield very limited results at LHC energies \(see [https://arxiv.org/abs/1710.01933](https://arxiv.org/abs/1710.01933%29\). Therefore it might be desired to inter/extrapolate the particle spectra from measurements at other center of mass energies. In the 5 TeV pp case, there are measurements available at 0.9, 2.76, 7 and 8 TeV which will allow for a very stable interpolation over a wide pT range.

The interpolations are handled by CalculateReference.C in the AnalysisSoftware repository \([https://gitlab.cern.ch/alice-pcg/AnalysisSoftware\](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware%29\). The macro is steered with an input text file and macro parameters. The text file is the most important ingredient as it provides the input spectra.

`CombinedResultsPaperPP2760GeV_2017_04_19_FrediV2Clusterizer.root    0    Pi02.76TeV/graphInvCrossSectionPi0PCM2760GeVStatErr    0    Pi02.76TeV/graphInvCrossSectionPi0PCM2760GeVSysErr 2.76TeV 2760    1 bla bla SystematicsInputOtherEnergies/SystematicErrorAveragedSinglePCM_Pi0_2_76TeV_2016_12_14.dat    ExternalInput/Theory/TheoryCompilationPP.root histoInvSecPythia8Monash2013LegoPi02760GeV`

For each energy, a separate line in the above format has to be provided starting with the root file first, followed by a switch \(0:histogram, 1:graph\) and the name for the statistical error input \(full path in root file including folder\). Afterwards the same is given for the systematic errors. Then the center of mass energy in two forms is given \(once in the standard format for our framework e.g. 900GeV, 7TeV, ... and once in units of GeV e.g. 900, 7000, ...\). The following three arguments are usually set as "1 bla bla" followed by a systematic uncertainty input file and the corresponding theory curve.

