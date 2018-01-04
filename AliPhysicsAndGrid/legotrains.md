# LEGO trains

The LEGO framework is a tool to run and manage analysis trains on AliEn. It builds on existing infrastructure, the analysis framework, MonALISA and LPM. LEGO provides a web interface for users and operators. All details and an extensive How-To may be found here: [Analysis Trains with the LEGO Framework](https://twiki.cern.ch/twiki/bin/viewauth/ALICE/AnalysisTrains)

An overview of all LEGO trains may be found here: [LEGO trains](https://alimonitor.cern.ch/trains/)

## Configure a LEGO train

Always test your setup locally before submitting/configuring an analysis train ([Running AnalysisTasks](/AliPhysicsAndGrid/runningTasks.md)). 
This will make it much easier for you to spot problems/errors.

In [Running AnalysisTasks](/AliPhysicsAndGrid/runningTasks.md), a working example and a complete setup of main (GammaCalo, GammaConvV1,...) and basic tasks (CDBconnect, PhysicsSelection, PIDResponse etc) is given which is needed to run the analysis using AliPhysics.

Make sure that you set the correct dependencies in the wagons you are creating.
Always have a look at existing wagons and use the cloning feature if new wagons need to be add.
Make sure to use the subwagon feature.
Double-check the set of parameters in the wagons which are handed to the AddTasks.

## Request a LEGO train

* make sure that you have tested that your code and wagon configuration works on the dataset that you want to run a train on (see [Running AnalysisTasks](/AliPhysicsAndGrid/runningTasks.md))

* make sure that all your requested wagons are already activated for the desired datasets!

* send a mail to the mailing list _alice-pwg-GA-train-operators_ with the following information:

  *  the train (e.g. GA_PbPb_AOD)
  *  the wagons; including the wagons that your analysis wagons have dependencies on. Check if your wagons have the correct output file name specified. If neccessary, ask the train operators to add the desired name to the list. Check if all wagons have the right arguments (the ones that you have tested locally), separated by commas. Check that there are no extra commas at the beginning or the end. Check if all wagons have the right dependencies specified. Activate your wagons for the dataset you want to run your train on
  *  dataset; check if the dataset is already in the list of datasets on the train page, if not ask to have it added. If you are running over a dataset for the first time, check also if the dataset is defined correctly (Reference production, global variables if used in your wagons, friend chain name "AliAODGammaConversion.root" for AODs, "AOD production"="AOD with ESD" or "AOD production", TTL, SplitMaxInputFileNumber, set Number of Files to Test depending on how many events are saved in one file so that you have a few hundred test events)
  * runlist; check that it is comma separated and that there are no extra commas at the beginning or the end.
  * if you want to have the output runwise. You might need this for QA.
  * aliphysics version (e.g. vAN-20161118-1)
  * if you want to use the slow train option
  * a comment that describes the train, e.g. the purpose or what you changed with respect to the last train on this dataset 

an example, title of email: _Train request GA\_PbPb_
> train:                    GA_PbPb
> wagons:                   PhotonQA\_5TeV\_0090, PhysicsSelectionESD, CentralityTaskESD2015, PIDResponseTaskESD2015
> dataset:                  LHC15o\_pass1\_highIR
> runwise:                  yes
> runlist:                  CentralBarrelGood
> aliphysics:               vAN-20171024
> slow-train-option:        yes
> comment:                  PhotonQA

* in case train test is successful (a green 'OK' in the test results)

  *  download output (via 'merge dir') and check if all relevant histograms for your analysis are filled and look reasonable
  *  check if train operator has made all settings correctly according to your request
  *  check memory consumption and processing time per event in the test results (there should be no red numbers! Memory should be below 2GB. If the delta values are problematic it could be due to too few test events)
  *  check the testing output log if necessary (e.g. if the correct splines are loaded) 

* in case of errors in the train test

  *  check stdout, stderr and the testing output log
  *  if necessary, redo local and grid tests on the files that were used for the train (see testing output log) and try to reproduce and debug the error (set the debug mode of the AliAnalysisManager to kDebug)
  *  if you need help, ask the train operators, the alice-project-analysis-task-force, alice-analysis-operations or one of the train experts 

* when the train is finished

  * check the success of the processing jobs (via 'processing process') and the merging jobs (via 'merging process'). In case of failed jobs, click on the PID (=process ID) to have a look at the trace and the log files. This way, check if crashes are due to grid errors or due to bugs in the code which have to be debugged.
  * check the histogram 'Input files per job'. It is not efficient when most jobs have only one or two input files. If this is the case, ask the train experts to redistribute the files
  * report on broken MC files
  * download the output, see [Download Files from GRID](/AliPhysicsAndGrid/download.md)


