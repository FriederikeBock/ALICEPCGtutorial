# Running Analysis Tasks

You need to have some ALICE data on your disk if you want to run the _Offline_ testing.
To download files from a data/MC production of ALICE from the GRID, see [Download Files from GRID](/AliPhysicsAndGrid/download.md).

## Offline

Test with local software and local files

* process runAnalysisConv.C with useGrid = kFALSE.
* make sure you have downloaded valid test files and provided the correct path.
* make sure that you set up the same tasks and make the same settings as you want to use on the train.
* also, make sure that you have installed the versions of AliRoot and AliPhysics that you want to use on the train. 

Run the macro [runLocal.C](/AliPhysicsAndGrid/runLocal.C) (right-click and save as) with 

> root -x -l -b -q 'runLocal.C("LHC12c", kFALSE, 0, 9)'

The additional macros needed are [CreateRootArchiveChain](/AliPhysicsAndGrid/CreateRootArchiveChain.C) and [CreateRootArchiveChainAOD](/AliPhysicsAndGrid/CreateRootArchiveChainAOD.C) (right-click and save as both).

The first argument chooses the data set specified in the _runLocal_ macro. The second argument selects between '_offline_' / '_GRID testing_' and the two numbers specify which files should be processed (in the example the files from folder '0' until folder '9').

* if you test AODs, you need to specify the AOD cut number. To know it, look into the aodTree in the AliAODGammaConversion.root
* if you have made major changes to the code, you should test the memory consumption (e.g. with 'top'), the processing time (e.g. with 'time') and the output file size (e.g. with 'ls -sh')

If everything works well, no errors are shown and the full output is generated, you may launch a test on GRID (next chapter).

## GRID testing

After local testing was successful, try to test by loading all files from the GRID.
For this purpose:

* specify the second argument useGrid == kTRUE for _runLocal.C_ 
* specify the path to the test files on the GRID in _runLocal.C_ (use aliensh to make sure you have specified the correct file path)
* possibly check the settings of the GRID handler in _runLocal.C_ (which tag you are using etc)

If something goes wrong, check the stderr for errors and wn.xml if the correct file was used for testing.

* keep in mind that some errors types are only visible during the GRID testing step (like streamer errors etc), therefore this kind of testing is very important!

If everything works and all outputs are fine, you have successfully tested your AnalysisTask locally.
