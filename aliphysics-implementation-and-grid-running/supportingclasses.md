# Supporting Classes and Cut Numbers

![](../.gitbook/assets/overview_gammaconv_aliphysicsmergedana.jpg)

## More information on cutstrings

To handle all the different possibilities to select our photons and neutral meson candidates we make use of a "cutstring" for the event cuts, conversion cuts, calo cuts and meson cuts. Changing for example a minimum energy threshold for your analysis will be done by changing a digit in the corresponding cutstring. It is recommended to open the classes in parallel so you can easily navigate around to find which digit corresponds to which cut.

**Conversion cut:**

```text
cuts.AddCut("80000113", "00200009327000008250404000", "0162103500900000");
```

**Calo cut:**

```text
cuts.AddCut("80000113","1111141057032230000","01631031000000d0");
```

**ConvCalo cut:**

```text
cuts.AddCut("82400113","00200009327000008250400000","1111141057032230000","0163103100000010");
```

**Explanation of the cutstrings:**

```text
//==============================================================
AliConvEventCuts.cxx

const char* AliConvEventCuts::fgkCutNames[AliConvEventCuts::kNCuts] = {
  "HeavyIon",                     //0
  "CentralityMin",                //1
  "CentralityMax",                //2
  "SelectSpecialTrigger",         //3
  "SelectSpecialSubTriggerClass", //4
  "RemovePileUp",                 //5
  "RejectExtraSignals",           //6
  "VertexCut",                    //7
};

//==============================================================
AliConversionPhotonCuts.cxx

const char* AliConversionPhotonCuts::fgkCutNames[AliConversionPhotonCuts::kNCuts] = {
  "V0FinderType",           // 0
  "EtaCut",                 // 1
  "MinRCut",                // 2
  "EtaForPhiCut",           // 3
  "MinPhiCut",              // 4
  "MaxPhiCut",              // 5
  "SinglePtCut",            // 6
  "ClsTPCCut",              // 7
  "ededxSigmaCut",          // 8
  "pidedxSigmaCut",         // 9
  "piMomdedxSigmaCut",      // 10
  "piMaxMomdedxSigmaCut",   // 11
  "LowPRejectionSigmaCut",  // 12
  "TOFelectronPID",         // 13
  "ITSelectronPID",         // 14 -- new ITS PID
  "TRDelectronPID",         // 15 -- new TRD PID
  "QtMaxCut",               // 16
  "Chi2GammaCut",           // 17
  "PsiPair",                // 18
  "DoPhotonAsymmetryCut",   // 19
  "CosinePointingAngle",    // 20
  "SharedElectronCuts",     // 21
  "RejectToCloseV0s",       // 22
  "DcaRPrimVtx",            // 23
  "DcaZPrimVtx",            // 24
  "EvetPlane"               // 25
};

//==============================================================
AliCaloPhotonCuts.cxx

const char* AliCaloPhotonCuts::fgkCutNames[AliCaloPhotonCuts::kNCuts] = {
  "ClusterType",          //0   0: all,    1: EMCAL,   2: PHOS
  "EtaMin",               //1   0: -10,    1: -0.6687, 2: -0,5, 3: -2
  "EtaMax",               //2   0: 10,     1: 0.66465, 2: 0.5,  3: 2
  "PhiMin",               //3   0: -10000, 1: 1.39626
  "PhiMax",               //4   0: 10000, 1: 3.125
  "NonLinearity1"         //5
  "NonLinearity2"         //6
  "DistanceToBadChannel", //7   0: 0,      1: 5
  "Timing",               //8   0: no cut
  "TrackMatching",        //9   0: 0,      1: 5
  "ExoticCluster",        //10   0: no cut
  "MinEnergy",            //11   0: no cut, 1: 0.05,    2: 0.1,  3: 0.15, 4: 0.2, 5: 0.3, 6: 0.5, 7: 0.75, 8: 1, 9: 1.25 (all GeV)
  "MinNCells",            //12  0: no cut, 1: 1,       2: 2,    3: 3,    4: 4,   5: 5,   6: 6
  "MinM02",               //13
  "MaxM02",               //14
  "MinM20",               //15
  "MaxM20",               //16
  "MaximumDispersion",    //17
  "NLM"                   //18
};

//==============================================================
AliConversionMesonCuts.cxx

const char* AliConversionMesonCuts::fgkCutNames[AliConversionMesonCuts::kNCuts] = {
  "MesonKind", //0
  "BackgroundScheme", //1
  "NumberOfBGEvents", //2
  "DegreesForRotationMethod", //3
  "RapidityMesonCut", //4
  "RCut", //5
  "AlphaMesonCut", //6
  "SelectionWindow", //7
  "SharedElectronCuts", //8
  "RejectToCloseV0s", //9
  "UseMCPSmearing", //10
  "DcaGammaGamma", //11
  "DcaRPrimVtx", //12
  "DcaZPrimVtx", //13
  "MinOpanMesonCut", //14
  "MaxOpanMesonCut" //15
};

//==============================================================
```

