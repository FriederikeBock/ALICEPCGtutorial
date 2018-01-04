# Cluster QA

**This part of the QA must be run for any calorimeter related analysis (for EMCal/PHOS/DCal and hybrid analyses PCM-EMCal, PCM-PHOS, PCM-DCal)**

## Identify Bad Cells

For bad cell identification, we need the output from GammaCalo with cellQA output contained (perferably option '5') downloaded runwise.

1. Run QA_RunwiseV2.C 
with doEventQA = kTRUE and doClusterQA = kTRUE (doMergedQA for EMCal merged analysis) with doExtQA == 2! (important for cell level output) using data + MC input in order to generate all needed histograms + txt-files for bad cell identification

2. CellQA step: identify dead and warm/hot cells comparing data and MC information
Check histograms created in _ExtQA/*_ and especially _ExtQA/MissingCells/*_ for dead cells. Dead/warm/hot cell identification by comparing the cells EFrac to mean EFrac of neighboring cells 

> (EFrac = cells energy fraction of full cluster energy, summed over all events --> turned out to be a much better discriminator than just looking how often cells fired)

We have a dead cell candidate:
> if((nCurrentEFrac<mean/3 && mean>=80) || (nCurrentEFrac<mean/5 && mean>=40 && mean<80) || (nCurrentEFrac<mean/8 && mean>=10 && mean<40) || (nCurrentEFrac<mean/10 && mean<10))

A warm/hot cell candidate:
> if((nCurrentEFrac>2*mean && nCurrentEFrac>80) || (nCurrentEFrac>3*mean && nCurrentEFrac>20) || (nCurrentEFrac>4*mean && nCurrentEFrac>8) || (nCurrentEFrac>5*mean && nCurrentEFrac>5))

Above conditions for dead/warm/hot cell candidate identification are being applied in function _CheckHotAndColdCellsEFracRunwise_ in QA.h! 
The resulting dead/warm/hot cells are written to respective _*.log_ files that can be found in the output folder. 
The next steps 3./4. are needed as by statistical fluctuations some cells can fire more often or less often than usual, therefore need to apply further conditions for dead/hot cell identification:

3. Run ClusterQA_DeadCellCompare.C (needs to be configured within macro - not _yet_ included in steering macros)
Determination of dead cells using for-loop around _line 280_. 
Different decisions when to consider dead cells:
> if cell is dead cell candidate in consecutive number of runs (currently set up with 4), 
> if at least 10 dead cell candidates are found with in the same run range or cell candidate is identified to be dead in a given % of analysed runs, represented by fractionThesh.

4. Run ClusterQA_HotCellCompare.C (needs to be configured within macro - not _yet_ included in steering macros)
Determination of warm/hot cells using for-loop around line 180 via 'threshNFired' and 'threshNTotalFired' for 3.+4. produce output log-files which summarize the bad cells to be excluded in OADB from runwise dead/warm/hot cell determination. 

After identifying dead/hot cells on runwise level, the general periodwise level CellQA + ClusterQA step follows

5. CellQA step on periodwise level via running of ClusterQA.C:
identify bad cells on periodwise level by using data and MC information. 

> Setting for bad cell identification are defined in QAV2.C (Double_t arrQAEnergy[4]; Double_t arrQATime[4]; Double_t arrQAHotCells1D[4]; Double_t arrmin2D[9]; Double_t arrmax2D[9];)

Compare data/MC energy and time distributions for all bad cell candidates found in 5. Also use 8. 

Then, merge bad cell candidate list from 5. with lists found in 3. and 4. to be excluded in OADB 

6. Runwise ClusterQA step by analysing output from ClusterQA_Runwise.C: 
Carefully check all output from runwise histograms with special focus on data/MC comparison (Is the MC able to reproduce all QA histograms extracted from data? Does the MC follow the trends seen in data? Are there any suspicious runs or any observations that cannot be explained?...)

7. ClusterQA step by analysing output from ClusterQA.C: Carefully check all output from histograms with special focus on data/MC comparison (Is the MC able to reproduce all QA histograms extracted from data? Does the MC follow the distributions seen in data? Are there any suspicious observations or is there anything that cannot be explained?...)

8. Run ClusterQA_CellCompare (needs to be configured within macro - not _yet_ included in steering macros) to visualize bad cell candidates found in step 5.

9. Optional: run ClusterQA_Compare (needs to be configured within macro - not _yet_ included in steering macros) to compare different data sets (MB vs calorimeter trigger for example for a given dataset; needs input from runwiseQA and periodwiseQA) 

## Run Cluster QA

The cluster QA covers general cluster+cell properties like:

**generated histograms (list of examples)** (full set of generated histograms can be deduced from the macros themselves/or from the output generated)
* Cut overview histograms (vs. $$p_T$$)
* Cell histograms (number of cells fired, cell energy/timing,...)
* Cluster histograms (number of clusters per event, eta/pi distributions,...)

> Running the ClusterQA(_Runwise).C will save the output into the following folder structure: _CUTNUMBER/SYSTEM/EventQA/_ 
> In addition, *.root files will be generated in _CUTNUMBER/SYSTEM/_ containing all the histograms as well.

Carefully check all output from runwise/full output with special focus on data/MC comparison (Is the MC able to reproduce all QA histograms extracted from data? Does the MC follow the trends seen in data? Are there any suspicious runs or any observations that cannot be explained?...) In general, they should be stable vs. run number - however, one of the exceptions is pileup which may vary from run to run -> need to be taken with special care!
