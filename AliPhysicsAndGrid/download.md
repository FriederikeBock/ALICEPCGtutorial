# Download Files from GRID

There are two (different) approaches to download files from the GRID.
Using a C++ macro (1.) and using a bash script (2.).
Both approaches have their (dis-)advantages, you may decide what is more convenient for you:

## 1. via C++ macro

#### Download ESD/AODs from the GRID (data / MC production)

The download macro may be found here: [DL-macro](/AliPhysicsAndGrid/GridJobFileListDL.C) (right-click and save as). It can be called with:

> root -x -l -b -q 'GridJobFileListDL.C+("list1.txt","pp/LHC12c/pass2","YOURPATH/LocalFiles")'

It automatically downloads the specified files, saves them in the folder structure needed for running local tests (-> [Running AnalysisTasks](AliPhysicsAndGrid/runningTasks.md)) and unzips the compressed files.

The first argument is the list of files you want to download, an example content of list1.txt:

    /alice/data/2012/LHC12c/000180720/pass2/12000180720015.126/root_archive.zip
    /alice/data/2012/LHC12c/000180720/pass2/12000180720046.105/root_archive.zip
    /alice/data/2012/LHC12c/000180717/pass2/12000180717055.11/root_archive.zip
    /alice/data/2012/LHC12c/000179920/pass2/12000179920020.51/root_archive.zip
    /alice/data/2012/LHC12c/000182322/pass2/12000182322020.13/root_archive.zip
    /alice/data/2012/LHC12c/000179916/pass2/12000179916001.12/root_archive.zip
    /alice/data/2012/LHC12c/000182687/pass2/12000182687019.37/root_archive.zip
    /alice/data/2012/LHC12c/000182687/pass2/12000182687013.36/root_archive.zip
    /alice/data/2012/LHC12c/000182299/pass2/12000182299050.31/root_archive.zip
    /alice/data/2012/LHC12c/000182730/pass2/12000182730037.22/root_archive.zip

The second argument specifies the relative path where data should be stored ( -> need to be specified in _runLocal.C_ [Running AnalysisTasks](AliPhysicsAndGrid/runningTasks.md)) and the third argument gives the absolute path on your system.

There is a possibility to hand over a fourth argument to the function, if you want to download the files from a specific SE (in case the download is slow due to some unresponsive SEs, for exaple '_ALICE::FZK::SE_').

### Download LEGO train output (analysis)

All the macros to download LEGO train output files can be found in _AnalysisSoftware/TaskQA_.

Examples how to use can be found within the macros.
The macros are able to deal with normal LEGO train output as well as output from META-datasets trains (both examples are contained in the macros) - in the latter case you MUST download the output from each child separately, the full merging does not do what you thin.

* Grid\_CopyFiles.C

> root -x -b -l -q 'TaskQA/Grid\_CopyFiles.C+("pp", "ESD", "YOURPATH")'

The three arguments need to be adjusted to what you are downloading and where to save the files -> YOURPATH.
Inside the macro, specifiy how many data trains and how many different trains you are downloading, the data set names, the output directory, the train run numbers, the desired runlists, the files to download and which files from which sets to merge.

* Grid\_CopyFilesJetJet.C

The core of this macro is identical to the first one, but with additional features to download JetJet output per run and per momentum bin. All settings can be deduced from the macro itself.

* Grid\_CopyFiles_Runwise.C

Again, the same as _Grid\_CopyFiles.C_ but performs the runwise download of data from LEGO trains on the GRID. It reads the runlists from _DownloadAndDataPrep/runlists_ by the data set names you specify.

* Grid\_FailedMergeDLRun.C

If some merging jobs failed on GRID, you can use this macro to download the files and run the merging locally. Then you can merge with the output file from the LEGO train in order to get the full statistics.

* Grid\_CheckFiles_Missing.C

This macro checks the input for "missing tracks" in the context of AOD processing of PCM photon candidates with deltaAODs. 

* Grid\_ReadJetJet.C

This macro can read in bins/runs of a JetJet MC and plots the NTrials and XSection.
 
## 2. via bash script

To-Do (Fredi)
