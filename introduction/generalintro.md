# General Naming Scheme and Analysis Tasks

In our framework we follow a common naming scheme and several abbreviations will occur frequently. When we are talking about the **meson analysis**, we usually refer to the _neutal pion and eta analysis_. While when we are talking about the **photon analysis** we generally mean the _direct photon analysis_.  
Within the software package different photon reconstruction techniques are implemented:

| Abbreviation | Explanation |
| :--- | :--- |
| Conversions \(Conv, PCM\) | Photon reconstruction via conversion in the detector material based on the electrons and positrons reconstructed in the TPC |
| Calo \(EMCal, DCal PHOS\) | Photons reconstructed via their energy deposit in the calorimeters |

These are then combined to reconstruct the neutral mesons in either the _two photon_ \($$\gamma \gamma$$\) or the _Dalitz decay channel_ \($$\gamma e^+ e^-$$\) using the same or different techniques or detectors for the photon reconstruction. The corresponding analysis tasks in **AliPhysics** in **PWGGA/GammaConv** are:

* AliAnalysisTaskGammaConvV1.cxx
* AliAnalysisTaskGammaCalo.cxx
* AliAnalysisTaskGammaConvCalo.cxx
* AliAnalysisTaskGammaConvDalitzV1.cxx
* AliAnalysisTaskGammaCaloDalitzV1.cxx
* AliAnalysisTaskGammaCaloMerged.cxx

These tasks are named according to their photon/meson reconstruction method and will in most cases be used to reconstruct not only the $$\pi^0$$ and $$\eta$$ meson but also the direct photons. A similar naming scheme will be used throughout the whole software package and is explained in the following.

| Abbreviation | Explanation |
| :--- | :--- |
| Conv, PCM | Photons reconstructed using conversions and then paired with other photons reconstructed with the same technique |
| Calo | Photons reconstructed using one of the three calorimeters \(EMCal, DCal, PHOS\) and then paired with other photons reconstructed with the same technique |
| ConvCalo | Photons reconstructed using one of the three calorimeters \(EMCal, DCal, PHOS\) and then paired with photons, which have been reconstructed from conversions. Currently 3 combinations are possible: PCM-EMC, PCM-DMC, PCM-PHOS. For the direct photon reconstruction the conversion photon is used for the inclusive photon reconstruction. |
| ConvDalitz | Photons reconstructed using conversions and then paired with 2 primary electrons reconstructed in the TPC and ITS. |
| CaloDalitz | Photons reconstructed using one of the three calorimeters \(EMCal, DCal, PHOS\) and then paired with 2 primary electrons reconstructed in the TPC and ITS. |
| CaloMerged, Merged | Neutral pions and eta mesons are reconstructed in the calorimeter via single clusters in the region where the 2 photons can no longer be separated due to the calorimeter resolution. These techniques are also refered to as mEMC, mDMC or mPHOS, where only the first has been explored so far. |

They are configure by the AddTasks in **PWGGA/GammaConv/macros** following a similar naming scheme:

AddTask\_Gamma\[Calo,ConvV1,ConvCalo,ConvDalitzV1,CaloDalitzV1,CaloMerged\]\_\[pp,pPb,PbPb\].C

These tasks produce output files which are named according to the reconstruction method and the train-configuration which has been chosen i.e.: _GammaConvV1\_$TRAINCONFIG.root, GammaCalo\_$TRAINCONFIG.root, GammaConvCalo\_$TRAINCONFIG.root, GammaCaloDalitz\_$TRAINCONFIG.root, GammaConvDalitzV1\_$TRAINCONFIG.root, GammaCaloMerged\_$TRAINCONFIG.root\_

For the heavier meson reconstruction using the $$\pi^0$$ in the decay chain the same convention for the names could not be kept and the corresponding tasks are named according to the decay chain and meson which they are supposed to reconstruct:

* AliAnalysisTaskK0toPi0Pi0.cxx
* AliAnalysisTaskOmegaToPiZeroGamma.cxx
* AliAnalysisTaskNeutralMesonToPiPlPiMiPiZero.cxx
* AliAnalysisTaskEtaToPiPlPiMiGamma.cxx

In these cases the photon/neutral pion reconstruction technique is selected through the configurations in the AddTask, which follow a similar naming scheme as explained before.  
There are several "helper-tasks" implemented in **PWGGA/GammaConv** in addition, which are usually used for QA purposes, Cocktail or MC investigations. Furthermore they can be used to determine the material budget uncertainty.

* AliAnalysisTaskConversionQA.cxx
* AliAnalysisTaskGammaCocktailMC.cxx
* AliAnalysisTaskHadronicCocktailMC.cxx
* AliAnalysisTaskGammaPureMC.cxx
* AliAnalysisTaskResolution.cxx
* AliAnalysisTaskMaterial.cxx
* AliAnalysisTaskMaterialHistos.cxx

For the conversion analysis also the $$v_n$$ reconstruction for the photons and pions is implemented in **PWGGA/GammaConv**, which is not yet the case for the corresponding calorimeter based analysis.

* AliAnalysisTaskGammaConvFlow.cxx
* AliAnalysisTaskPi0v2.cxx

