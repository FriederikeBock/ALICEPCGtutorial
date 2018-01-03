## Secondary Corrections for the neutral pion reconstruction

### General Remarks and How To obtain the necessary Input Spectra

For the secondary correction to the pi0's and gamma's we do not rely any longer purely on the simulations, except for the material interactions contribution, consequently additional experimental inputs are needed. For each collision system the measured spectra for $$K^0_s$$ & $$\Lambda$$ will be needed \(ask LF convenors for corresponding input if not already included in the cocktail framework\). If these are not available in a certain collision system, energy or centrality one can either use the charged Kaons as proxy for the $$K^0_s$$ or in the pp case inter/-extrapolate the kaons/Lambda's from other collision energies. For the later ideally all available collision energies are to be used \(i.e 0.9, 2.76, 7, 13 TeV to get to 5 or 8 TeV\). For the Lambda no other obvious candidate exists which could stand in as proxy for the Lambda if inter-/extrapolation is not possible. In that case one can use mT scaling from the proton, this is however much less precise.  
The interpolations can be done with CalculateReference.C in the AnalysisSoftware repo. It is configured via a config file and example for that is given here configInterPolationPi0Comb.txt and an example of the running options can be found here runInterPol.sh. In order for the inter-/extrapolation-macro to work properly a global binning for the desired particle \(i.e. $$K^0_s$$, $$K^{\pm}$$, $$\Lambda$$, P, $$\pi^0$$, $$\pi^\pm$$, $$\eta$$, ... \) needs to be defined for the corresponding energy. This should be done in the function GetBinning\(\) of CommonHeaders/ExtractSignalBinning.C within the AnalysisSoftware repo  
If mT scaling is used there is no need to do calculate the spectrum separately it would be automatically if the Lambda is enabled in the cocktail parametrization in cocktail-framework.

### Obtaining Parametrizations and Running Secondary Cocktail

The following steps have to be performed within the Em-Cocktail framework, please be aware that the latest developments are using done in the "devel-branch" so please check this one out , if you are modifying the corresponding files.  
Include reference spectra of desired particles in corresponding data compilation macros: CocktailProduceCompleteInputFile\[PP,PPb,PbPb\].C for the corresponding energies, collision systems and centralities. Please remember to include also the source files and the references, dates in repository & the macro. In particular if the spectra were not yet published it has to be documented from whom they were obtained and which status they have. If you obtained more than the necessary spectra, which are needed for the secondary correction, please also include the ones you obtained in addition. Furthermore it has proven useful to also include the particle ratio's, which were either published or can be calculated using the CalculateRatioBetweenSpectraWithDifferentBinning - function. Make sure the spectra are in the correct format \(we need \)  
Parametrize the desired spectra within the cocktail framework using CocktailInputParametrization.C. Examples for the configuration files need for that can be found in the folder !parametrizationSettings and example run scripts for the full chain can be found in the main directory: script_startProduce_\[PP,PPb,PbPb\].sh. In the parametrizations file parametrizations for the pi0 and proton have to be available, otherwise the cocktail generation will crash. They don't need to be the final ones, but should not be completely unrealistic either, as otherwise more errors while running the cocktail production will occur \(i.e. if the integral of the functions is not finite\).  
Afterwards the corresponding desired parametrization file needs to be commited to AliPhysics in the PWG/Cocktail/parametrisations -folder  
Once it is available in the AliPhysics-tag you should ask Nicolas Schmidt or Friederike Bock to include the corresponding Cocktail-data set in the MCGen\_pp or MCGen\_PbPb train. You have to specify the full setting of the generator like:   
$ALICE\_PHYSICS/PWG/Cocktail/macros/AddMCEMCocktailV2.C\(200,0,0,262079,"$ALICE\_PHYSICS/PWG/Cocktail/parametrisations/pp\_8TeV.root","8TeV\_PCMEMCal",250,0.,50,10000,0,1,1,0\)   
adjusted to the corresponding collision system and desired produced particles. Keep in mind the train run might be used also for the photon decay-cocktail so make sure you have the correct particles specified.  
When the data set has been activated ask the operators to activate the wagons: Pi0Cocktail\_diffRap \(& GammaCocktail\_diffRap, if you wanna run the decay photon cocktail in paralllel\) and run the corresponding train.  
Then you have to wait until the train run finishes until you can proceed. The previous 2 steps can also be done locally on your computer, most likely however it will take a while until you accumulate enough statistics for the corresponding particle spectra.  
A general remark: Make sure your parametrization for all particles describe the spectra better than 5-10% over the full measured transverse momentum region, as otherwise the generated cocktail will certainly not reproduce the data. At low  include \(0,0\) in the fitting and at high  make sure the n of all spectra is approximately the same and they don't cross in the unmeasured region if they are not expected to.

### Integration of the Cocktail-output in the Analysis-Flow for the Pi0's and Gamma's

Once the train finished or you generated the file on your computer, copy the AnalysisResults.root file to your computer and rename it ideally with the data of generation, system and settings short hand for bookeeping.  
When asked by the start\_FullMesonAnalysis\_TaskV2.sh whether you have a cocktail file answer "Yes" and answer the consecutive questions regarding the file location and rapidity settings. For the later the answer is "0.8" for most analysis and it depends on the rapidity range you are using in the corresponding cutselection and analysis.  
This should take care of nearly everything else necessary afterwards. However you have to control whether the secondary efficiency and acceptance make sense as these might need to be fixed due to lack of statistics in the corresponding MC. Have a look at the corresponding plots for that. Examples for the pion reco are shown below.

  
Pi0\_AcceptanceWithSec\_\* & Pi0\_RatioSecEffiToTrueEff\_\*

![](/assets/Pi0_AcceptanceWithSec_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg)  
![](/assets/Pi0_RatioSecEffiToTrueEff_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg)  
Pi0\_TrueEffWithSecEffi\_\*  
![](/assets/Pi0_TrueEffWithSecEffi_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg)

Pi0\_data\_EffectiveSecCorrPt\_\* & Pi0\_data\_RAWYieldSecPt\_\*

![](/assets/Pi0_data_EffectiveSecCorrPt_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg),  
![](/assets/Pi0_data_RAWYieldSecPt_80000113_00200009327000008250400000_1111141057032230000_0163103100000010.jpg),

Make sure the appropriate functions are used if you need to fix the secondary correction factors, these might depend on energy, collision system and reconstruction method, please try to adjust it such that you don't interfere with existing exceptions.  
Repeat the cocktail generation procedure if the parametrizations are not good enough.

