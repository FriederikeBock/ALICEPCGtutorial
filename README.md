# Welcome to the Conversion Group Tutorials

This tutorial is meant as an introduction to the software packages provided by the Photon Conversion Group \(PCG\). As it is still under development as is the software it does not claim completeness. However, it should provide a good start for new-comers and oldies to get started on a new topic. If you wanna help improving this documentation you are very welcome and just need to let us know and [e-mail Friederike](friederike.bock@cern.ch). She will grant you access to the documentation git as well.

In the provided software package the reconstruction of photons within ALICE using different detectors \(EMCal, DCal, PHOS, TPC & ITS\) is handled in a common way and the neutral mesons can be extracted using different techniques. Furthermore the software can be used as analysis level QA for the corresponding detectors focussing on the quantities relevant for the corresponding photon reconstruction.

Our software is structured in 3 main parts:

1. [**AliPhysics**](https://github.com/alisw/AliPhysics) implementation in **PWGGA/GammaConv**, which is running on the reconstructed ESD/AOD data or simulation files
2. **Afterburner** implementation which is kept and maintained in the [**PCG-Software directory**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware) and is used to analyse the output files of the AliPhysics-Tasks to extract the meson spectra \($$\pi^0, \eta, \omega$$\), $$v_n$$ and direct photon results
3. **Cocktail** implementation, which is scattered in 2 different places in AliPhysics \(**PWG/Cocktail** & **PWGGA/GammaConv**\) and which has to fed by inputs summarized in the [**Cocktail-Repository**](https://gitlab.cern.ch/alice-cocktail-EM/cocktail_input)

All three packages will be needed to complete the full meson and direct photon analysis as it is currently implemented and will be explained in the following tutorial in different sections.

To gain committer-access to the PCG-Software directory please subscribe to _**alice-pcg**_** & **_**alice-pcg-core**_ on [e-groups](https://e-groups.cern.ch/) and to get the committer access to the Cocktail repository you have to be subscribed to _**alice-cocktail-EM**_.

## Contacts

If there are any questions regarding this tutorial do not hesitate to ask on  
_alice-pcg-core@cern.ch_  
or directly to the convenors and creators of the tutorial

* Daniel Muehlheim [d.muehlheim@cern.ch](mailto:d.muehlheim@cern.ch)
* Friederike Bock [friederike.bock@cern.ch](mailto:friederike.bock@cern.ch)
* Nicolas Schmidt [nicolas.schmidt@cern.ch](mailto:nicolas.schmidt@cern.ch)
* Mike Sas [msas@nikhef.nl](mailto:msas@nikhef.nl)

We are happy to help.

