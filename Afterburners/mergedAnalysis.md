#Merged Cluster Analysis

In addition to the already explained invariant mass based analysis methods using PCM and/or the calorimeters there is also the merged cluster analysis that is instead a particle identification analysis. It therefore relies heavily on the quality of the Monte Carlo simulation to obtain correct acceptance, efficiency and purity corrections.

The most important cut in the merged analysis is made on M02, the eigenvalue of the larger axis of an ellipse around the cluster. The cut on M02 allows the selection of unsymmetrical clusters with an elongation along one axis. Elongated clusters originate very likely from two particles that hit the calorimeter surface too close to each other and therefore the clusterizer incorporated the signal of both particles in one single cluster. Clusters in the EMCal start to merge above 10 GeV/c whereas in PHOS this happens much higher in pT due to the smaller cell size.

Due to the nature of this analysis, triggered data is of great importance to select mainly events that contain merged clusters. The EMCal triggers EMC7 and EGA are based on different energy thresholds and therefore enhance the yield above different transverse momenta. In the following example, pp 8 TeV data is used including its three triggers V0AND(MB), EMC7 and EGA.

The merged analysis is done with the following classes/macros in our repositories:
  
**GRID**: AddTask_GammaCaloMerged_pp/pPb, AliAnalysisTaskGammaCaloMerged

**Afterburner**: ExtractSignalMergedMeson, CompareShapeMergedClusterQuantities, CorrectSignalMerged

The task on the grid uses the same cut classes as the other calorimeter tasks, however, contrary to the standard calorimeter task two AliCaloPhotonCuts cutnumbers are defined. One cutnumber is used on all clusters and one to select the merged clusters. The merged analysis cutnumbers have the following format:

```
00010113_1111111067032200000_1111111067022700001_0163300000000000"
  event       cluster           merged cluster         meson
```

The task provides in the end an output file called GammaCaloMerged.root. This output is fed, as shown in the flow chart, into the AnalysisSoftware afterburners.

![](/assets/MergedAnalysisOverview.jpg)

Running ExtractSignalMergedMeson produces several plots in the outputfolder `$CUTNUMBER/$ENERGY/ExtractSignalMergedMeson`. Control plots showing the energy dependend M02 cut in Pi0_data_EVsM02_AllAcceptedMesons are produced for data and MC, see:
![](/assets/Pi0_data_EVsM02_AllAcceptedMesons.jpg)
Furthermore, the M02 distributions for each pT bin are shown as well as the corresponding invariant mass distributions for the merged cluster pion candidates.
![](/assets/Pi0_data_MesonM02_00081113_1111111067032200000_1111111067022700001_0163300000000000.jpg)
![](/assets/Pi0_data_MesonInvMass_00081113_1111111067032200000_1111111067022700001_0163300000000000.jpg)

The second macro in the analysis chain (CompareShapeMergedClusterQuantities) makes necessary comparison plots between data and MC for different quantities (cluster energy, M02, number of cells per merged cluster and invariant mass). It can be seen that in Monte Carlo less cells per cluster will be present, however the invariant mass and M02 distributions agree quite acceptable, see:

![](/assets/Pi0_MesonM02Compared_00081113_1111111067032200000_1111111067022700001_0163300000000000.jpg)

The correction of the raw yields from the merged clusters is done in CorrectSignalMerged. Here, acceptance, efficiency, secondary contamination and purity are determined from Monte Carlo and applied.
In the following, the background contributions and corresponding purity correction are shown.
![](/assets/Pi0_MC_BGRatioPtCleaner_00081113_1111111067032200000_1111111067022700001_0163300000000000.jpg)
![](/assets/Pi0_data_TruePurity_00081113_1111111067032200000_1111111067022700001_0163300000000000.jpg)
Furtheremore, the acceptance correction is given:
![](/assets/Pi0_Acceptance_00081113_1111111067032200000_1111111067022700001_0163300000000000.jpg)
The secondary raw yields are shown below:
![](/assets/Pi0_data_RAWYieldSecPt_00081113_1111111067032200000_1111111067022700001_0163300000000000.jpg)
