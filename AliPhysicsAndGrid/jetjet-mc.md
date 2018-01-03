# How to start with a new JetJet Monte Carlo simulation

This section becomes important if you need to work with a new JetJet Monte Carlo simulation.

In the following it will be explained how to get information about the simulation itself and how to obtain the pT hard bin weights that are necessary for your analysis.

### 1. Get information about the JetJet simulation \(or any other simulation\)

On [MonALISA](https://alimonitor.cern.ch/trains/)  select in the sidebar Production info/MC production cycles and scroll to the relevant production. For this example, I will use LHC17g8b.![](/assets/mcoverview.png)On this page you have several important pieces of information already available. You can see if the simulation is "Completed" or still "Running" or currently in "Quality check 10%".

Furthermore, the corresponding run ranges in data to which the simulation is anchored are shown as well as the total statistics produced.

The most important information can be found in the associated Jira ticket which is given by the ending of the second column. In this case "ALIROOT-7270" which is the ending of the link [https://alice.its.cern.ch/jira/browse/ALIROOT-7270](https://alice.its.cern.ch/jira/browse/ALIROOT-7270).

On this Jira page, the full generation information is available. This covers the AliPhysics version, generator information, run lists, intermediate and final QA as well as further information in the comments section.![](/assets/JiraInfo.png)From the description you can now see that the simulation is anchored to 16r and 8 Mio events per pT hard bin were simulated.

In order to get further information about the generator PWGGA:EPOSLHC\_Pythia\_GammaTriggerAndJet one has to refer to the [Data Preparation Group](https://twiki.cern.ch/twiki/bin/viewauth/ALICE/AliceDPG)s Git repository [https://github.com/alisw/AliDPG](https://github.com/alisw/AliDPG).

In this repository, the used generator config can be found in AliDPG/MC/CustomGenerators/PWGGA/EPOSLHC\_Pythia\_GammaTriggerAndJet.C where the setting for the process "Pythia8Jets" are set. The process itself is defined in AliDPG/MC/GeneratorConfig.C where we get infromation about the eta, phi, $$p_{T}^{hard}$$, quenchin and structure function that are used for the simulation.

### 2. Extract $$p_{\rm T}^{\rm hard}$$ bin weights

Due to the nature of the JetJet simulation which requires a jet with a transverse energy of at least 5 GeV, several trial are necessary \(N\_trials\). For each event, Pythia also calculates the cross-section to which the gernerated sample of events corresponds on average. As only a small part of the full phase space for each $$p_{T}^{hard}$$ bin is sampled, a certain weight has to be applied. The weight is calculated as $$\omega=\frac{\sigma_{evt}}{N_{trials}/N_{evt.gen.}}$$.

In order to obtain the weights, GammaConv or GammaConvCalo task output is required for each $$p_{T}^{hard}$$ bin. These can either be obtained from the Legotrains or from a local test where for each $$p_{T}^{hard}$$bin at least three input files were used.

The files are fed into TaskV1/PlotJetJetMCProperties.C in our AnalysisSoftware repository via an input text that is structured as follows:

```
LHC17g8c/266437/1_GammaCalo_345.root 5 7
LHC17g8c/266437/2_GammaCalo_345.root 7 9
LHC17g8c/266437/3_GammaCalo_345.root 9 12
LHC17g8c/266437/4_GammaCalo_345.root 12 16
LHC17g8c/266437/5_GammaCalo_345.root 16 21
LHC17g8c/266437/6_GammaCalo_345.root 21 28
.....
```

In each line the input file for the given $$p_{T}^{hard}$$bin is given followed by the lower and upper $$p_{T}^{hard}$$ limits of this bin. The macro can then be run via:

```
root -x -l -b -q 'TaskV1/PlotJetJetMCProperties.C+("pPbJJWeightsLHC17g8c.txt","80000513_2444400051013200000_0163103100000010",5,20,"pdf","pPb_8TeV","LHC17g8b",kFALSE)'
```

where the input text file must be given, the cutnumber in the GammaCalo or GammaConvCalo output, the mode \(in this case PHOS\), the total number of $$p_{T}^{hard}$$ bins \(here 20\), the energy \(here "pPb\_8TeV"\), the MC period \(here "LHC17g8b"\) and a QA flag.

