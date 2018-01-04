#Merged Cluster Analysis

In addition to the already explained invariant mass based analysis methods using PCM and/or the calorimeters there is also the merged cluster analysis that is instead a particle identification analysis. It therefore relies heavily on the quality of the Monte Carlo simulation to obtain correct acceptance, efficiency and purity corrections.

The most important cut in the merged analysis is made on M02, the eigenvalue of the larger axis of an ellipse around the cluster. The cut on M02 allows the selection of unsymmetrical clusters with an elongation along one axis. Elongated clusters originate very likely from two particles that hit the calorimeter surface too close to each other and therefore the clusterizer incorporated the signal of both particles in one single cluster. Clusters in the EMCal start to merge above 10 GeV/c whereas in PHOS this happens much higher in pT due to the smaller cell size. 

Due to the nature of this analysis, triggered data is of great importance to select mainly events that contain merged clusters. The EMCal triggers EMC7 and EGA are based on different energy thresholds and therefore enhance the yield above different transverse momenta. In the following example, pp 8 TeV data is used including its three triggers V0AND(MB), EMC7 and EGA.

The merged analysis is done with the following classes/macros in our repositories:
  
**GRID**: AddTask_GammaCaloMerged_pp/pPb ->  AliAnalysisTaskGammaCaloMerged

**Afterburner**: ExtractSignalMergedMeson -> CorrectSignalMerged

The task on the grid uses the same cut classes as the other calorimeter tasks, however, contrary to the standard calorimeter task two AliCaloPhotonCuts cutnumbers are defined. One cut is applied on the standard cluster and one on the merged clusters. The cutnumbers have the following format:

```
00010113_1111111067032200000_1111111067022700001_0163300000000000"
  event       cluster           merged cluster         meson
```

The task provides in the end an output file called GammaCaloMerged.root.
