## Secondary Corrections for the neutral pion reconstruction

### How To obtain the necessary Input Spectra & Cocktail Output

For the secondary correction to the $$\pi^0$$'s and $\gamma$'s we do not rely any longer purely on the simulations, except for the material interactions contribution, consequently additional experimental inputs are needed. For each collision system the measured spectra for $$K^0_s$$ & $$\Lambda$$ will be needed \(ask LF convenors for corresponding input if not already included in the [cocktail framework](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input) \). If these are not available in a certain collision system, energy or centrality one can either use the charged kaons as proxy for the $$K^0_s$$ or in the pp case inter/-extrapolate the kaons/Lambda's from other collision energies. For the later ideally all available collision energies are to be used \(i.e 0.9, 2.76, 7, 13 TeV to get to 5 or 8 TeV\). For the Lambda no other obvious candidate exists which could stand in as proxy for the Lambda if inter-/extrapolation is not possible. In that case one can use $$m_T$$ scaling from the proton, this is however much less precise.  
For the description of the interpolation procedure you can jump to the [Cocktail Framework Intro](https://friederikebock.gitbooks.io/pcgtutorial/content/Afterburners/Cocktail/cocktail.html). If $$m_T$$ scaling is used there is no need to do calculate the spectrum separately it would be automatically if the $$\Lambda$$ is enabled in the cocktail parametrization in cocktail-framework. A detailed description how the corresponding spectra need to be included in the cocktail frame work and how they are paremetrized is given in the section [Cocktail Framework Intro](https://friederikebock.gitbooks.io/pcgtutorial/content/Afterburners/Cocktail/cocktail.html) along with the instructions on how to run the corresponding cocktail on the grid. However, you have to ensure the train-operator enables the wagon for the hadronic cocktail as well \(Pi0Cocktail\_diffRap\), which will run several wagons of AliAnalysisTaskHadronicCocktailMC.cxx in parallel on the output of the generated EM-cocktail.  
A general remark: Make sure your parametrization for all particles describe the spectra better than 5-10% over the full measured transverse momentum region, as otherwise the generated cocktail will certainly not reproduce the data. At low  include \(0,0\) in the fitting and at high  make sure the n of all spectra is approximately the same and they don't cross in the unmeasured region if they are not expected to.

### Integration of the Cocktail-output in the Analysis-Flow for the Pi0's

* Once the train finished or you generated the file on your computer, copy the _AnalysisResults.root_ file to your computer and rename it ideally with the data of generation, system and settings short hand for bookeeping.
* When asked by the _start\_FullMesonAnalysis\_TaskV2.sh_ whether you have a cocktail file answer "Yes" and answer the consecutive questions regarding the file location and rapidity settings. For the later the answer is "0.8" for most analysis and it depends on the rapidity range you are using in the corresponding cutselection and analysis.
* This should take care of nearly everything else necessary afterwards. However you have to control whether the secondary efficiency and acceptance make sense as these might need to be fixed due to lack of statistics in the corresponding MC. Have a look at the corresponding plots for that. Examples for the pion reco are shown below.

Pi0\_AcceptanceWithSec\_\* & Pi0\_RatioSecEffiToTrueEff\_\*

![](/assets/Pi0_AcceptanceWithSec_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg)  
![](/assets/Pi0_RatioSecEffiToTrueEff_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg)  
Pi0\_TrueEffWithSecEffi\_\*  
![](/assets/Pi0_TrueEffWithSecEffi_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg)

Pi0\_data\_EffectiveSecCorrPt\_\* & Pi0\_data\_RAWYieldSecPt\_\*

![](/assets/Pi0_data_EffectiveSecCorrPt_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg),  
![](/assets/Pi0_data_RAWYieldSecPt_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg),

* Make sure the appropriate functions are used if you need to fix the secondary correction factors, these might depend on   energy, collision system and reconstruction method, please try to adjust it such that you don't interfere with existing exceptions.
* Repeat the cocktail generation procedure, if the parametrizations are not good enough.



