# Systematic Uncertainties

The systematic uncertainty on the neutral meson measurements is evaluated, like in most analyses, by varying the selection cuts. These variations are chosen such that a reasonable deviation to the default selection criteria is tested.

**For example we vary the rapidity selection of the reconstructed meson:**

| Default | Variation 1 | Variation 2 |
| :--- | :--- | :--- |
| -0.8 &lt; y &lt; 0.8 | -0.6 &lt; y &lt; 0.6 | -0.5 &lt; y &lt; 0.5 |

We then compare the corrected yield of each variation, as function of transverse momentum, to the corrected yield of the default selection cut. We always vary one cut at a time. In the case of our neutral mesons we can vary the cuts for photon and meson reconstruction. The full evaluation of the systematic uncertainty for a neutral meson analysis is handled in two parts, first by running all the different selection cuts on the grid, and then by the afterburner.

## 1. Setting up the cut configurations

The reconstruction of the meson depends on many cut selections and most of them are listed below.

### Photon: PCM

* Material budget
* Min pt
* Chi2/ndf
* Psi pair
* TPC selection cuts
* Armenteros Podolanski variables \(alpha and qt\)
* ...

### Photon: Calo

* Energy correction
* Material budget
* Cell timing
* Track Matching
* Min energy of cluster
* Min number of cells cluster
* Shower shape parameters
* ....

### Meson: all

* Rapidity meson
* Opening angle photons
* energy asymmetry photons
* ...

We modify the AddTask accordingly

**Default cut:**

```text
cuts.AddCut("80000113","1111141057032230000","01631031000000d0"); // 1 cell lead cell, 17mrad open
```

Variations 1:

```text
cuts.AddCut("80000113","1111141057032230000","01631031000000a0"); // 1 cell lead cell, 0mrad open
```

Variations 2:

```text
cuts.AddCut("80000113","1111141057032230000","01631031000000b0"); // 1 cell lead cell, 15mrad open
```

In the AddTask we would include these variations like this:

```text
} else if (trainConfig == 21){ // default cutstring, 1cell distance lead cell
    cuts.AddCut("80000113","1111141057032230000","01631031000000a0"); // 1 cell lead cell
    cuts.AddCut("80000113","1111141057032230000","01631031000000d0"); // 1 cell lead cell, 17mrad open
    cuts.AddCut("80000113","1111141057032230000","01631031000000b0"); // 1 cell lead cell, 15mrad open
```

Remember to not put more than 4 or 5 cut variations in a single configuration, since that would consume too much memory on the grid.

## 2. Running all the cuts

After successfully running all the cut variations on the grid we need run the full meson analysis on all of them. Please check the following things:

* All the fits converge
* There is enough statistics available for all pt bins in both data and MC
* ...

## 3. Calculating the deviations to the default cut

After running the cuts we need to add the information to the CutStudies folder. For each set of variations we do it like\(now an example for varying Alpha\):

```text
# # Alpha
echo -e "80000113_00200009327000008250400000_2444451041013200000_0163103100000010\n80000113_00200009327000008250400000_2444451041013200000_0163105100000010\n80000113_00200009327000008250400000_2444451041013200000_0163106100000010" > CutSelectionAlpha.log
    echo -e "Alpha\nLHC13bc\n3\nY\npPb5\nY\n/home/mike/2_pPb_EMC/0_analysis/170803_final_EMC/CocktailEMC_4Mio.root\n0.80\nN\nY\nY" > answersAlpha.txt
    cp CutSelectionAlpha.log CutSelection.log
    bash start_FullMesonAnalysis_TaskV3.sh -dgammaOff bla eps < answersAlpha.txt
```

Note that this does not refit the mass peaks, it skips that part and runs the CutStudiesOverview on the variations and the default cut and stores it in the corresponding folder. This part is needed for the next macro that generates the systematic uncertainties.

After this procedure is done for all variations we use the following macro to calculate the systematic error:

```text
FinaliseSystematicErrorsMETHOD_system.C
```

So for pPb it would be the following:

```text
FinaliseSystematicErrorsConvCalo_pPb.C
```

In this macro we decide which of the cut variations to smooth and which contribute to the total systematic uncertainty.

**Watch out**: Using only one variation for a cut will result in an underestimate of the systematic uncertainties, because we calculate the mean of the highest positive and negative difference per bin which for one variation will divide your uncertainties by 2.

### 3.1 Use the Settings of the _TaskV1/CutStudiesOverview.C_

As an alternative to run _start_FullMesonAnalysis_TaskV3_ to start _CutStudiesOverview_ you can also run _TaskV1/CutStudiesOverview.C_ directly using the following:

```text
# # Alpha
echo -e "80000113_00200009327000008250400000_2444451041013200000_0163103100000010\n80000113_00200009327000008250400000_2444451041013200000_0163105100000010\n80000113_00200009327000008250400000_2444451041013200000_0163106100000010" > CutSelectionAlpha.log
    NameStudy="Alpha"
    NCuts=`cat CutSelectionAlpha.log | wc -l`
    root -l -q -b TaskV1/CutStudiesOverview.C+'("CutSelectionAlpha.log","eps","Pi0","kFALSE","","2_pPb_EMC","'$NameStudy'",'$NCuts',0,"","LHC13bc", 3, kFALSE, 0, kFALSE)'
    root -l -q -b TaskV1/CutStudiesOverview.C+'("CutSelectionAlpha.log","eps","Pi0","kTRUE","","2_pPb_EMC","'$NameStudy'",'$NCuts',0,"","LHC13bc", 3, kFALSE, 0, kFALSE)'
    root -l -q -b TaskV1/CutStudiesOverview.C+'("CutSelectionAlpha.log","eps","Eta","kFALSE","","2_pPb_EMC","'$NameStudy'",'$NCuts',0,"","LHC13bc", 3, kFALSE, 0, kFALSE)'
    root -l -q -b TaskV1/CutStudiesOverview.C+'("CutSelectionAlpha.log","eps","Eta","kTRUE","","2_pPb_EMC","'$NameStudy'",'$NCuts',0,"","LHC13bc", 3, kFALSE, 0, kFALSE)'
```

this Method lets you use the Settings of the _TaskV1/CutStudiesOverview.C_ macro.
```test
void CutStudiesOverview(......,
                        Bool_t doBarlow                         = kFALSE,
                        Int_t smoothing                         = 0,
                        Bool_t doRebin                          = kFALSE
                       ){
```
* Bool_t **doBarlow**: enables a Barlow check (not default)
* Bool_t **doRebin**: enables an automatic rebinning procedure that makes sure that all bins have a reasonable statistical accuracy, obviously this has its limits, and can be finetuned if needed using the variables maxError and maxrebins.
* Int_t **smoothing** 8this can make the next step _4. Smoothing_ easier or even unnecessary):
    * **0**: Off (default)
    * **2**: Uses the root function TH1::Smooth() to smooth the ratio of the variations.
    * **1, 3, 4**: there are additional _experimental_ options (not recommended)
        * **1**: Uses two TCM fit to the yields and uses the ratio of those fits for the following uncertainty evaluation
        * **3**: Uses the root TH1 function Smooth() to smooth the yields of the standard and all variations
        * **4**: Fitting the ratio of the variations with polynom

Please carefully check the additionally created plot <meson>_<data/MC>_Monitor.<eps,pdf,png,..>.

I recommend to at least look at **doRebin=kTRUE** and **smoothing=2 + doRebin=kTRUE**. This can make your life way easier for the next Step _4. Smoothing_. Also applying **doRebin** will most likely reduce the contamination of statistical uncertainties in your evaluation of the systematic uncertainties.




## 4. Smoothing the deviations

Most of the deviations we observe should have a certain trend as function of transverse momentum and should not fluctuate too much bin by bin. For example think of the opening angle cut between the two photons, for any reconstruction method. In this case it would make no sense if you see the following trend:

| bin 4 | bin 5 | bin 6 | bin 7 | bin 8 |
| :--- | :--- | :--- | :--- | :--- |
| 5% difference | 7% difference | 1% difference | 11% difference | 13% difference |

We see that the deviation to the default cut increases rather linearly, but for bin 6 there is almost no difference observed. This is then most likely due to a statistical fluctuation. By interpolation one could put bin 6 at 9% systematic error. This is the concept of smoothing. Please be aware that this needs to be done with the physics in mind.

There is one contribution to the systematic uncertainty that is very rarely smoothed; the yield extraction. This quantity does and should fluctuate bin by bin, so it should not be smoothed.

## 5. Generating the final result

For generating the final result we use the following macro:

```text
TaskV1/ProduceFinalResultsPatchedTriggers.C
```
