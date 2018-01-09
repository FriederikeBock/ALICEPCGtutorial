# Download Files from GRID

There are two (different) approaches to download files from the GRID.
Using a C++ macro (1.) and using a bash script (2.).
Both approaches have their (dis-)advantages, you may decide what is more convenient for you:

## 1. via C++ macro

### Download ESD/AODs from the GRID (data / MC production)

The download macro may be found here: [DL-macro](/AliPhysicsAndGrid/GridJobFileListDL.C) (right-click and save as). It can be called with:

> root -x -l -b -q 'GridJobFileListDL.C("list1.txt","pp/LHC12c/pass2","YOURPATH/LocalFiles")'

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

### Download LEGO train output (analysis)

Over the past few years we also implemented quite some shell scripts to download the data from the grid in particular for the lego train outputs, they can be found in [**AnalysisSoftware/DownloadAndDataPrep**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/DownloadAndDataPrep/). They are usually data set & analysis method specific and take care of the correct download and merging of the corresponding lego train outputs. As such they are in a lot of cases very specific and might need a bit more adjustments when adapting for a new data set. At the same time they also allow very specific modifications (i.e. adjusting the download and merging of specific run-lists only). Furthermore, also the download of partially unmerged runs is slightly easier and the number of downloads can be a bit optimized by for instance always downloading the full _root\_archive.zip_ and only deleting the corresponding files in the end.
The download scripts are named according to the following scheme:
* GetGamma\[Calo,Conv,ConvCalo,CaloMerged\]FilesFromGridAndMergeThem\_\[$COLLSYS/$ENERGY/$PERIODNAME\].sh
  i.e `GetGammaCaloFilesFromGridAndMergeThem_PbPbLHC10h.sh` or `GetGammaConvCaloFilesFromGridAndMergeThem_pPbRun2_5TeV.sh`

As the script scripts got better we recommend to always have a look at the lastest scripts which have been added to the repository, as these most likely contain the most recent features. Currently the best developed are the ones for `pPbRun2_5TeV` & `XeXe`. These are based already on the common functions file [_basicFunction.sh_](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/DownloadAndDataPrep/basicFunction.sh) in which all functions, which had been used more frequently have now been implemented. The shell scripts rely on the actual shell interface of alien meaning the programs:
```
alien_ls
alien_cp
alien_mkdir
alien_find
...
```
These programs can be executed directly from the bash once you initialized your alice-environment. As such the parsing of files is sometimes more convenient and consequently more straight forwards to parse. Often also basic shell programs as `sed, cat, grep, find` and so on are used. Thus if you are not sure what a certain option does just type `man $PROGRAMNAME` and have a look at the corresponding man-page directly or ask us.

The most complex call for the scripts is :
```
bash GetGammaCaloFilesFromGridAndMergeThem_pPbRun2.sh fbock 0 fast _FAST _fast
```
However usually only the first two arguments after the script-name are defined. Where the first one defines your username and in accordance with that some global settings, which you need to add to:
```
if [ $1 = "fbock" ]; then
    BASEDIR=/mnt/additionalStorageExternal/OutputLegoTrains/pPb
elif [ $1 = "dmuhlhei" ]; then
    BASEDIR=~/data/work/Grid
fi

```
in the beginning of the script. The corresponding outputs are gonna be stored in this base directory with the folder-name $TRAINDIR. In addition depending on this-base directory ($BASEDIR) the number of slashes to reach a certain file is calculated as follows: 
```
# Definitition of number of slashes in your path to different depths
NSlashesBASE=`tr -dc '/' <<<"$BASEDIR" | wc -c`
NSlashes=`expr $NSlashesBASE + 4`
NSlashes2=`expr $NSlashes - 1`
NSlashes3=`expr $NSlashes + 1`
NSlashes4=`expr $NSlashes + 2`
echo "$NSlashesBASE $NSlashes $NSlashes2 $NSlashes3 $NSlashes4"
```
In addition various global variables are set, which allow you to switch on the downloading of the periods, single runs as well as enabling the merging
```
DOWNLOADON=1            # 0/1 - dowload off/on
MERGEON=1               # 0/1 - global merging of multiple periods switched off/on
SINGLERUN=1             # 0/1 - download single runs off/on
SEPARATEON=1            # 0/1 - switch off/on separation of cutnumber into different files
MERGEONSINGLEData=1     # 0/1 - disable/enable merging for single runs of data
MERGEONSINGLEMC=1       # 0/1 - disable/enable merging for single runs of MC
CLEANUP=1               # 0/1 - disable/enable cleaning up of directory
CLEANUPMAYOR=$2         # 0/1 - disable/enable mayor cleaning up of directory handed as second argument to shell-script
number=""               # temporary variable
```

Afterwards the general data set variable are created and the corresponding booleans are enabled. The latter should be 1 if the data set is there and will be automatically put to 0, if they are not.
```
# check if train configuration has actually been given
HAVELHC16q=1
HAVELHC16t=1
HAVETOBUILDData=0
HAVELHC17f2b=1
HAVELHC17f2afix=1

# default trainconfigurations
LHC16qData="";
LHC16tData="";
LHC16qtData="";
LHC17f2bMC="";
LHC17f2a_fixMC="";

passNr="1";
```
Last but not least of the configurations the train-numbers which you want to download are handed as data set names, and the script will parse the corresponding train runs.
```
TRAINDIR=Legotrain-vAN20171005-dirGammaRun2
# woSDD (CENT)
 LHC16qtData="679"; #pass 2
 LHC16qData="child_1"; #pass 3
 LHC16tData="child_2"; #pass 2
 LHC17f2bMC="1090";
 LHC17f2a_fixMC="1088";
```

Then the script checks if the train runs exist and downloads the files as specified. If needed this is done run-wise.
```
 CopyFileIfNonExisitent $OUTPUTDIR_LHC17f2a_fix "/alice/cern.ch/user/a/alitrain/PWGGA/GA_pPb_MC/$LHC17f2a_fixMC/merge" $NSlashes "" kTRUE
```

For the new pPb data-set (16q,r,s,t) multiple reconstructions are available. Thus, in order to correctly download the run-wise output for MC, the arguments `fast _FAST _fast`, `woSDD _CENT_woSDD _cent_woSDD` or `wSDD _CENT_wSDD _cent` had to be added to the shell script call. The first one defining the runlist-name addition, the second defining the data additional name and the third the MC additional name. 
Afterwards the files are merged according to certain runlists defined in [**AnalysisSoftware/DownloadAndDataPrep/runlists**](https://gitlab.cern.ch/alice-pcg/AnalysisSoftware/tree/master/DownloadAndDataPrep/runlists)
```
 MergeAccordingToSpecificRunlist fileLHC17f2a_fix.txt $OUTPUTDIR_LHC17f2a_fix $NSlashes3 GammaCalo All runlists/runNumbersLHC17f2a_fix_$3_all.txt
```

and brought into a common naming scheme and format, also containing the runlist name.
```
 ChangeStructureIfNeededCalo $fileName $OUTPUTDIR_LHC16q $NSlashes "LHC16q_$3-pass$passNr-All" "-All"
```

Lastly the sub-periods which can be merged are merged using `hadd` as well as the corresponding MC's if need be. 

If the second option of the scripts was a `1` the script will only do the cleanup of the runwise outputs, so make sure you really wanna do that, if you set it.