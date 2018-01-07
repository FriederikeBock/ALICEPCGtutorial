# Systematic Uncertainties



The systematic uncertainty on the neutral meson measurements is evaluated, like in most analyses, by varying the selection cuts. These variations are chosen such that a reasonable deviation to the default selection criteria is tested. 

**For example we vary the rapidity selection of the reconstructed meson:**

| Default | Variation 1 | Variation 2 |
| :--- | :--- | :--- |
| \|y\| meson &lt; 0.8 | \|y\| meson &lt; 0.6 | \|y\| meson &lt; 0.5 |

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

```
cut 1
```

Variations 1:

```
cut 2
```

Variations 2:

```
cut 3
```

Remember to not put all cut variations in a single configuration, since that would consume too much memory on the grid.

## 2. Running all the cuts

After successfully running all the cut variations on the grid we need run the full meson analysis on all of them. Please check the following things:

* All the fits converge
* There is enough statistics available for all pt bins in both data and MC
* ...

## 3. Calculating the deviations to the default cut



```
macro.c
```



## 4. Smoothing the deviations

Most of the deviations we observe should have a certain trend as function of transverse momentum and should not fluctuate too much bin by bin. For example think of the opening angle cut between the two photons, for any reconstruction method. In this case it would make no sense if you see the following trend:

| bin 4 | bin 5 | bin 6 | bin 7 | bin 8 |
| :--- | :--- | :--- | :--- | :--- |
| 5% difference | 7% difference | 1% difference | 11% difference | 13% difference |

We see that the deviation to the default cut increases rather linearly, but for bin 6 there is almost no difference observed. This is then most likely due to a statistical fluctuation. By interpolation one could put bin 6 at 9% systematic error. This is the concept of smoothing. Please be aware that this needs to be done with the physics in mind.

There is one contribution to the systematic uncertainty that is very rarely smoothed; the yield extraction. This quantity does and should fluctuate bin by bin, so it should not be smoothed.

## 5. Generating the final result

For generating the final result we use the following macro:

```
macro.c
```



