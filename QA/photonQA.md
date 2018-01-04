# Photon QA 

**This part of the QA must be run for any PCM related analysis (for PCM and hybrid analyses PCM-EMCal, PCM-PHOS, PCM-DCal)**

    For your desired dataset or MC sample run the proper PhotonQA task on Grid (remember to request 'runwise' output and always run in 'slow' mode to get maximum statistics)
    Download (only) runwise output (two different sets of DL macros available in DownloadAndDataPrep/* and TaskQA/Grid_CopyFiles*.C)
    Create config files for QA_RunwiseV2.C and QAV2.C (examples can be found in AnalysisSoftware repository). Run lists are read in from DownloadAndDataPrep/runlists and need to be defined for each dataset in separate files with exact dataset names that are requested in QA_RunwiseV2.C or QAV2.C
    Run QA_RunwiseV2.C with doEventQA = kTRUE and doPhotonQA = kTRUE - it will read TTrees from runwise output and generate runwise QA plots. It will also merge the output from different runs as this is, in general, impossible to do on TTree level due to the huge file sizes.
    Carefully check all output from runwise histograms with special focus on data/MC comparison (Is the MC able to reproduce all QA histograms extracted from data? Does the MC follow the trends seen in data? Are there any suspicious runs or any observations that cannot be explained?...)
    Run QAV2.C and carefully check periodwise output and QA histograms (ask the same questions above) 
