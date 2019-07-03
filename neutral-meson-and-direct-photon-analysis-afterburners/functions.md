# Useful functions

In this chapter a brief overview of the most useful functions in the framework is presented. These functions are used very often by the convenors of this tutorial and are always recommended to be used.

## Plotting

1. The **basic plotting style** can be set in your macro via the following two lines. They take care of canvas colors, font styles, etc... and should generally always be used when plotting is intended in the macro.

   ```text
    StyleSettingsThesis();
    SetPlotStyle();
   ```

2. Basic string functions:

   ```text
    TString dateForOutput   = ReturnDateStringForOutput(); //date in format: YYYY_MM_DD
    TString collisionSystem = ReturnFullCollisionsSystem(energy); //i.e. "pp, #sqrt{s} = 7 TeV"
   ```

3. Basic **marker, color and size** settings for **different reconstruction methods** with `nameDet` being a string containing either one of: `"PCM", "PHOS", "EMCal", "PCM-PHOS", "PCM-EMCal", "PCM-Dalitz", "PHOS-Dalitz", "EMCal-Dalitz", "EMCal high pT", "EMCal merged", "PCMOtherDataset"`. **These colors should ALWAYS be used if the focus of a plot is to show multiple reconstruction methods!** These styles have been used in all recent publications where our group was involved.

   ```text
    Color_t  colorDet = GetDefaultColorDiffDetectors(nameDet.Data(), kFALSE, kFALSE, kTRUE);
    Style_t  markerStyleDet = GetDefaultMarkerStyleDiffDetectors(nameDet.Data(), kFALSE);
    Size_t   markerSizeDet = GetDefaultMarkerSizeDiffDetectors(nameDet.Data(), kFALSE);
   ```

4. Basic **marker, color and size** settings for **different center of mass energies** with a string containing the energy setting, i.e. "900GeV" or "8TeV". **These colors should ALWAYS be used if the focus of a plot is to show multiple center of mass energy measurements of the same method together!** These styles have been used in all recent publications where our group was involved.

   ```text
    Color_t colorEnergy       = GetColorDefaultColor("8TeV", "", "");
    Style_t markerStyleEnergy = GetDefaultMarkerStyle("8TeV", "", "");
    Size_t markerSizeEnergy   = GetDefaultMarkerSize("8TeV", "", "");
   ```

5. Set plotting styles for graphs, histograms, TF1:

   ```text
    DrawGammaSetMarkerTGraphAsym(dummgyTGrAsym , 2, styleLineJETPHOX, colorJETPHOX, colorJETPHOX, widthLinesBoxes, kTRUE, colorJETPHOX,kTRUE);
   ```

6. Canvas setup:

   ```text
    TCanvas* canvas = new TCanvas("canvas","",200,10,1350,900);  // gives the page size
    DrawGammaCanvasSettings( canvas, 0.08, 0.01, 0.01, 0.09); // sets margins (left, right, top, bottom)
   ```

   usually one directly sets the textsize in pixels for other plotting functions by using the canvas vertical pixel count \(here 900\) with:

   ```text
    Int_t textSizeLabelsPixel = 900*0.04;
   ```

7. Make and format legends quickly:

   ```text
    TLegend* legendExample   = GetAndSetLegend2(0.12, 0.14, 0.45, 0.14+(0.04*expectedLinesInLegend), textSizeLabelsPixel, 2, "", 43, 0);
    legendExample->AddEntry(dummgyTGrAsym,"legend text","p"); // last argument: p (point), l (line), f (fill), e (error), combinations possible, ie "pf", "lep", ...
    legendExample->Draw();
   ```

## Calculation

## Useful code

1. Cutting TGraphs to a certain x-range with while loop:

   ```text
   // remove points below 1.5 GeV/c
   while(exampleGraph->GetX()[0] < 1.5)
      exampleGraph->RemovePoint(0);

   // remove points above 20 GeV/c
   while(exampleGraph->GetX()[exampleGraph->GetN()-1] > 20)
      exampleGraph->RemovePoint(exampleGraph->GetN()-1);
   ```

