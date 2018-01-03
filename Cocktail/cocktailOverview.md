# Photon, Electron, and Dielectron Cocktails in ALICE

## Organization

**e-group**: alice-cocktail-EM Link  
contacts

* photons: Friederike Bock [friederike.bock@cern.ch](mailto:friederike.bock@cern.ch)
* electrons: Ralf Averbeck [ralf.averbeck@cern.ch](mailto:ralf.averbeck@cern.ch)
* dielectrons: Oton Vazquez Doce [oton.vazquez@universe-cluster.de](mailto:oton.vazquez@universe-cluster.de)

## Software repository for parametrization & spectra input

**repository**: [**Cocktail-Repository**](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input)  
in order to check it out first go to the web page and add your ssh key. readme  
afterwards you can check it out with:  
git clone ssh://git@gitlab.cern.ch:7999/alice-cocktail-EM/cocktail\_input.git

If you can't access, please inform Friederike Bock

This repository is meant to collect all the available spectra and $$v_n$$ within ALICE for the different particle species \($$\pi^{0,\pm}, \eta, \omega, K^{0,\pm}$$ ...\) which are needed to create the electromagnetic cocktails for the photon, heavy flavour and di-electron analysis. As such the information from different analyses has been summarized in 3 different twiki's and the corresponding macros to compile the data including the links to the analysis notes and JIRA tickets for the data which are not yet published. These are for:

* **pp**: [CocktailProduceCompleteInputFilePP.C](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input/blob/master/CocktailProduceCompleteInputFilePP.C) with the corresponding [PP-twiki](https://twiki.cern.ch/twiki/bin/view/ALICE/OverviewCocktailInputsPP)
* **p-Pb**: [CocktailProduceCompleteInputFilePPb.C](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input/blob/master/CocktailProduceCompleteInputFilePPb.C) with the corresponding [PPb-twiki](https://twiki.cern.ch/twiki/bin/view/ALICE/OverviewCocktailInputsPPb)
* **Pb-Pb**: [CocktailProduceCompleteInputFilePbPb.C](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input/blob/master/CocktailProduceCompleteInputFilePbPb.C) with the corresponding [PbPb-twiki](https://twiki.cern.ch/twiki/bin/view/ALICE/OverviewCocktailInputsPbPb)

As these pages and macros are maintained volluntarily please keep in mind that they might not reflect the latest status. Thus you should feel free to update them if you find a link or result does not correspond any longer to the knowledge within ALICE. We ask however that you make it available to all of us and update it in both places the macro and the twiki, so that we keep them in sync.

The latest fully vetted version of the code is usually kept in the _master-branch_ of the cocktail-repository. For the latest changes you might, however need to check out the _devel-branch_ of the same directory. If necessary we can create a separate branch for your changes as only a few people can directly commit to the _master-branch_ in order to allow a full vetting of the changes.

