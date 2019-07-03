# Energy Calibration of Calorimeters

A detailed explanation of the procedure can be found in Analysis Notes [EMCal @ pp 8 TeV](https://aliceinfo.cern.ch/Notes/node/489), [PCM-EMCal @ pp 8 TeV](https://aliceinfo.cern.ch/Notes/node/411) as well as [EMCal @ pp 2.76 TeV](https://aliceinfo.cern.ch/Notes/node/468) and [PCM-EMCal @ pp 2.76 TeV](https://aliceinfo.cern.ch/Notes/node/387).

The macros needed to perform the energy calibration can be found in _AnalysisSoftware/TaskV1_, which are **CorrectCaloNonLinearityV4** and **CorrectCaloNonLinearityV4\_Compare**. They can be run using:

> root -x -l -b -q 'TaskV1/CorrectCaloNonLinearityV4.C+\("config.txt", "eps", kFALSE\)'
>
> root -x -l -b -q 'TaskV1/CorrectCaloNonLinearityV4\_Compare.C+\("config.txt", "eps", kFALSE\)'

The first argument is the config-file, for which example configs can be found in _TaskV1/ExampleConfigs_. Then the output format of the figures is given as well as a flag to give further debug output with cout's.

Important things to look for:

* Is the background subtraction working properly?
* Cross-check the fits: do they all converge?
* Are the transverse momentum bins defined properly? If you have massive statistics, split them. Otherwise merge bins. Especially check high momentum bins, if signal extraction is viable.
* Are triggers available for the data? If yes, use them as they will give you much better handle on the higher momenta.
* Compare the different calibrations, do they make sense? In principle, the different procedures CMF, CRF, CCMF, CCRF \(-&gt; see analysis notes for explanations\) etc should give very similar results.

Once you obtained the correction function, it must be implemented in AliPhysics into the helper task _AliCaloPhotonCuts_.

* Check, if the MC you are working on is already implemented in the framework.
* Add your calibration to the function _ApplyNonLinearity_ in _AliCaloPhotonCuts_ for the MC you are working on.
* Check, if you have the correct cut-numbers available in your AddTasks to run the LEGO trains on the GRID -&gt; if not, add the cut configs.
* Do the commit and request the LEGO train using your calibration.

**IMPORTANT NOTE**

After applying your calibration, rerun your analysis and use your newly acquired calibration. Then repeat the calibration step explained above and verify that mass ratios are at '1'. If this is not the case, something went wrong and you need to look for the issue.

