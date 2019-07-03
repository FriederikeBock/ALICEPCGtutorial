# The EMCal Correction Framework

The full set of EMCal calibrations was previously handled by the Tender and was composed of several tasks that were, by demand, added to the analysis chain. The EMCal group has introduced a new framework for the handling of the corrections/calibrations which in addition brings many more useful features. The framework was thoroughly tested by the group and verified to yield the same results as using the Tender.

## Setting up the framework

Setting up the correction framework invovles writing a yaml configuration file. The basic configuration can be found in AliPhysics/PWG/EMCAL/config/AliEmcalCorrectionConfiguration.yaml. In this configuration, the default setting for all corrections/calibrations is "false" meaning that they are not being applied. A very detailed introduction to the parts of this configuration can be found on the [AliDoc webpage](http://alidoc.cern.ch/AliPhysics/master/_r_e_a_d_m_eemc_corrections.html#configureEMCalCorrections).

In the following, only the basic adjustments to the configurations will be explained. The current configurations that are available for our tasks can be found in AliPhysics/PWGGA/GammaConv/config/PWGGA\_CF\_config.yaml and AliPhysics/PWGGA/GammaConv/config/PWGGA\_CF\_config\_MC.yaml.

The basic configuration consists of the definition of the input/output objects for cells, clusters and tracks. In addition, the reconstruction pass is set here, or can be put to an empty string \(""\) to let the framework auto-detect the pass.

```text
configurationName: "PWGGA configuration"
pass: "pass4"
inputObjects:
    cells:
        defaultCells:
            branchName: "usedefault"
    clusterContainers:
        defaultClusterContainer:
            branchName: "usedefault"
        ClusterContainerS500A100W3:
            branchName: "S500A100W3ClustersBranch"
    trackContainers:
        defaultTrackContainer:
            branchName: "usedefault"
```

With the configuration shown above, the default cells, cluster and track objects are defined. These are the object which also the previously utilized Tender used. In addition, it is possible to define additional branches/containers which can have different settings. These must have custom names, \(i.e. ClusterContainerS500A100W3 with the branchName S500A100W3ClustersBranch\) and can be made for cells, clusters and tracks. It is possible to define as many of these objects as desired.

As for us currently only different clusterizers are of interest, we do not use custom cell or track objects. For data, we apply the energy, bad channel and timing corrections. As shown in the example below, there is the default configuration "CellEnergy" as well as "CellEnergy\_defaultSetting". This setting is necessary to not apply the corrections more than once. Every setting in "CellEnergy" would be applied in addition in all other custom configuration \(more on that later\).

```text
CellEnergy:
    createHistos: true
CellEnergy_defaultSetting:
    enabled: true

CellBadChannel:
    createHistos: true
CellBadChannel_defaultSetting:
    enabled: true

CellTimeCalib:
    createHistos: true
CellTimeCalib_defaultSetting:
    enabled: true
```

Therefore, the corrections are only enables in the "defaultSetting" configuration which will always be run before any other custom setting.

After the cells, the clusterizer settings are made. As we have defined an additional output object above, we also need to define an additional clusterizer for this object, see below:

```text
Clusterizer:
    createHistos: true
    clusterizer: kClusterizerv2
    cellTimeMin: -500e-9
    cellTimeMax: +500e-9
    clusterTimeLength: 1e6
    recalDistToBadChannels: true
    remapMcAod: false
    diffEAggregation: 0.0
    cellsNames:
        - defaultCells
Clusterizer_defaultSetting:
    # w0 standard is 4.5
    enabled: true
    cellE: 0.1
    seedE: 0.5
    clusterContainersNames:
        - defaultClusterContainer
Clusterizer_S500A100W3:
    enabled: true
    cellE: 0.1
    seedE: 0.5
    w0: 3
    clusterContainersNames:
        - ClusterContainerS500A100W3
```

As seen in the setting above, we again have a "Clusterizer" and "Clusterizer\_defaultSetting" configuration. Every variable set in "Clusterizer" will be also set for all other clusterizers. Meaning the setting of the v2 clusterizer, the +-500ns timing cuts, etc. The "defaultSetting" clusterizer then makes clusters with our -usually- standard settings of 500MeV seed, 100MeV aggregation and a w0 parameter of 4.5. The setting for our additional output object "S500A100W3" is different just by the setting of `w0=3`. For the clusterizer, many different settings are available and can be looked up in the default configuration AliPhysics/PWG/EMCAL/config/AliEmcalCorrectionConfiguration.yaml.

After the clusterizer, the nonlinearity correction can be applied. As we apply our own correction in AliCaloPhotonCuts.cxx, the setting here is kNoCorrection and must be applied for all configurations.

```text
ClusterNonLinearity:
    createHistos: true
    nonLinFunct: kNoCorrection
ClusterNonLinearity_defaultSetting:
    enabled: true
    clusterContainersNames:
        - defaultClusterContainer
ClusterNonLinearity_S500A100W3:
    enabled: true
    clusterContainersNames:
        - ClusterContainerS500A100W3
```

## Local running

For a local test, using the correction framework we now have to add the corresponding tasks for our default setting and the final setting that we want to use in the analysis. This would look like the following in the local test macro:

```text
const UInt_t  kPhysSel  = AliVEvent::kAnyINT | AliVEvent::kCentral | AliVEvent::kSemiCentral;
AliEmcalCorrectionTask::BeamType iBeamType = AliEmcalCorrectionTask::kpp;
AliEmcalCorrectionTask * correctionTask = AliEmcalCorrectionTask::AddTaskEmcalCorrectionTask("defaultSetting");
   correctionTask->SelectCollisionCandidates(kPhysSel);
   correctionTask->SetForceBeamType(iBeamType);
   correctionTask->SetUserConfigurationFilename("PWGGA_CF_config.yaml");
   correctionTask->Initialize();
AliEmcalCorrectionTask * correctionTaskSpezial = AliEmcalCorrectionTask::AddTaskEmcalCorrectionTask("S500A100W3");
   correctionTaskSpezial->SelectCollisionCandidates(kPhysSel);
   correctionTaskSpezial->SetForceBeamType(iBeamType);
   correctionTaskSpezial->SetUserConfigurationFilename("PWGGA_CF_config.yaml");
   correctionTaskSpezial->Initialize();
```

The task needs to be defined with the configuration name handed as argument. Basic settings must be made and the configuration file needs to be set. Each task then needs to be initialized to properly apply the settings.

The above configuration would add the following configurations and components. Notice, how the cell corrections are only applied once and in "defaultSetting".

```text
I-AliEmcalCorrectionTask::InitializeComponents: Successfully added correction task: AliEmcalCorrectionClusterNonLinearity_defaultSetting
AliEmcalCorrectionTask_defaultSetting Settings:
Correction components:
    AliEmcalCorrectionCellEnergy_defaultSetting
    AliEmcalCorrectionCellBadChannel_defaultSetting
    AliEmcalCorrectionCellTimeCalib_defaultSetting
    AliEmcalCorrectionClusterizer_defaultSetting
    AliEmcalCorrectionClusterNonLinearity_defaultSetting

I-AliEmcalCorrectionTask::InitializeComponents: Successfully added correction task: AliEmcalCorrectionClusterNonLinearity_S500A100W3
AliEmcalCorrectionTask_S500A100 Settings:
Correction components:
    AliEmcalCorrectionClusterizer_S500A100W3
    AliEmcalCorrectionClusterNonLinearity_S500A100W3
```

This now allows us to use the new configuration "S500A100W3" in our analysis tasks via: `AliAnalysisTask *taskEMC = AddTask_GammaCalo_pp(0,intMCrunning,1,1, "",conversionAODCutnumber ,periodName,kFALSE,kFALSE,5,kFALSE,kTRUE,3.,periodName,kFALSE,"","",kTRUE,kFALSE,"S500A100W3", "450" );`

## Grid running

**The correction framework can also be used on the grid, however, this part is still under development and will be added in the future.**

