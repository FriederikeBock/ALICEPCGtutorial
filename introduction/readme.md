# Welcome

This tutorial is meant as an introduction to the software packages provided by the Photon Conversion Group \(PCG\). As it is still under development as is the software it does not claim completeness. However, it should provide a good start for new-comers and oldies to get started on a new topic. If you wanna help improving this documentation you are very welcome and just need to let us know and [e-mail Friederike](mailto:friederike.bock@cern.ch). She will grant you access to the documentation git as well.

In the provided software package the reconstruction of photons within ALICE using different detectors \(EMCal, DCal, PHOS, TPC & ITS\) is handled in a common way and the neutral mesons can be extracted using different techniques. Furthermore the software can be used as analysis level QA for the corresponding detectors focussing on the quantities relevant for the corresponding photon reconstruction.

Our software is structured in 3 main parts hosted on GitHub and GitLab:

1. [**AliPhysics**](https://github.com/alisw/AliPhysics) implementation in **PWGGA/GammaConv**, which is running on the reconstructed ESD/AOD data or simulation files
2. **Afterburner** implementation which is kept and maintained in the [**PCG-Software directory**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware) and is used to analyse the output files of the AliPhysics-Tasks to extract the meson spectra \($$\pi^0, \eta, \omega$$\), $$v\_n$$ and direct photon results. It is named _AnalysisSoftware_ repository
3. **Cocktail** implementation, which is scattered in 2 different places in AliPhysics \(**PWG/Cocktail** & **PWGGA/GammaConv**\) and which has to fed by inputs summarized in the [**Cocktail-Repository**](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input)

All three packages will be needed to complete the full meson and direct photon analysis as it is currently implemented and will be explained in the following tutorial in different sections.

Furthermore, we have a repository \(named AnalysisNotes\) hosting all analysis/combination notes [**PCG-Notes repository**](https://gitlab.cern.ch/alice-pcg/AnalysisNotes) where you should contribute with your own analysis note once your analysis reached an advanced stage and is targeted to be included in a publication.

The _AliPhysics_ repository is automatically installed, the rest of the repositores can be cloned to your local disk \(remember the SSH key registration!\) via the following commands:

* AnalysisSoftware

  > git clone ssh://git@gitlab.cern.ch:7999/alice-pcg/AnalysisSoftware.git

* AnalysisNotes

  > git clone ssh://git@gitlab.cern.ch:7999/alice-pcg/AnalysisNotes.git

* Cocktail

  > git clone ssh://git@gitlab.cern.ch:7999/alice-cocktail-EM/cocktail\_input.git

To gain committer-access to the PCG-Software directories \(AnalysisSoftware and AnalysisNotes\) please subscribe to _**alice-pcg**_ **&** _**alice-pcg-core**_ on [e-groups](https://e-groups.cern.ch/) and to get the committer access to the Cocktail repository you have to be subscribed to _**alice-cocktail-EM**_. For AliPhysics such a subscribtion is not needed as you create your own fork of the repository and do pull-requests as described in [Working with AliPhysics](http://alisw.github.io/git-tutorial/).

Last but not least, the last GitHub repository is our GitBook tutorial repository to complete the list \(which you are reading\) [**PCG-tutorial**](https://github.com/FriederikeBock/ALICEPCGtutorial) which is linked to the GitBook itself [**Tutorial**](https://friederikebock.gitbooks.io/pcgtutorial/content/)

## Contacts

If there are any questions regarding this tutorial do not hesitate to ask on

* [alice-pcg-core@cern.ch](mailto:alice-pcg-core@cern.ch) 

or directly to the convenors and creators of the tutorial

* Daniel Muehlheim [d.muehlheim@cern.ch](mailto:d.muehlheim@cern.ch)
* Friederike Bock [friederike.bock@cern.ch](mailto:friederike.bock@cern.ch)
* Nicolas Schmidt [nicolas.schmidt@cern.ch](mailto:nicolas.schmidt@cern.ch)
* Mike Sas [msas@nikhef.nl](mailto:msas@nikhef.nl)
* Meike Danisch [meike.charlotte.danisch@cern.ch](mailto:meike.charlotte.danisch@cern.ch)

We are happy to help.

## Communication Tools

Besides the egroup and email contact, the _PCG_ uses mattermost (ALICE-PWGGA). There are different channels to discuss specific analyses or other topics.

**Weekly meetings of the PCG**

Weekly meetings of the PCG take place on vidyo [PCG @ Indico](https://indico.cern.ch/category/4027/). They are usually scheduled for Wednesday, 2am, and open to anybody with interest in the topic. Announcements are sent around via the main egroup

* [alice-pcg@cern.ch](mailto:alice-pcg@cern.ch)

which you should be registered to in addition to [alice-pcg-core@cern.ch](mailto:alice-pcg-core@cern.ch) -&gt; see [e-groups](https://e-groups.cern.ch)

## Additional Information

**useful links**

* [AliPhysics, aliBuild, AliEn](https://dberzano.github.io/)

**twikis**:

* [PCG](https://twiki.cern.ch/twiki/bin/view/ALICE/PWGGAPcmGroup)
* [PWGGA](https://twiki.cern.ch/twiki/bin/view/ALICE/PWGGA)
* [EMCocktail](https://twiki.cern.ch/twiki/bin/view/ALICE/EMCocktail)

