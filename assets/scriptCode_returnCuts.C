#include <Riostream.h>
#include <fstream>
#include "TMath.h"
#include <fstream>
#include <math.h>
#include <TROOT.h>
#include <TSystem.h>
#include <TString.h>
#include "CommonHeaders/PlottingGammaConversionHistos.h"
#include "CommonHeaders/PlottingGammaConversionAdditional.h"
#include "CommonHeaders/FittingGammaConversion.h"
#include "CommonHeaders/ConversionFunctionsBasicsAndLabeling.h"
#include "CommonHeaders/ConversionFunctions.h"


//void scriptCode_returnCuts(TString cutNumberAdv = "00000113_00200009227302008250400000_0152103500000000",TString optionPeriod = "7TeV",Int_t mode = 0){
void scriptCode_returnCuts(TString cutNumberAdv = "00000113_00200009227302008250404000_0152103500000000",TString optionPeriod = "7TeV",Int_t mode = 0){ //lucas
//~ void scriptCode_returnCuts(TString cutNumberAdv = "00010113_00200008386302001200400000_0152103500000000",TString optionPeriod = "8TeV",Int_t mode = 0){

	TString fEventCutSelection                              = "";
	TString fGammaCutSelection                              = "";
	TString fClusterCutSelection                            = "";
	TString fElectronCutSelection                           = "";
	TString fMesonCutSelection                              = "";
	// disentangle cut selection
	if (mode == 9){
		ReturnSeparatedCutNumber(cutNumberAdv.Data(), fGammaCutSelection, fElectronCutSelection,fMesonCutSelection);
		fEventCutSelection                                = fGammaCutSelection(0,7);
		fGammaCutSelection                                = fGammaCutSelection(7,fGammaCutSelection.Length()-7);
	} else {
		ReturnSeparatedCutNumberAdvanced(cutNumberAdv.Data(),fEventCutSelection, fGammaCutSelection, fClusterCutSelection, fElectronCutSelection, fMesonCutSelection, mode);
	}
		TString fTrigger = fEventCutSelection(GetEventSelectSpecialTriggerCutPosition(),1);


	//~################# SpecialTrigg ###################### 
	fTrigger                                            = fEventCutSelection(GetEventSelectSpecialTriggerCutPosition(),2);
	cout << AnalyseSpecialTriggerCut(fTrigger.Atoi(), optionPeriod) << endl;      
	
	//~################# MultiplicityPP ###################### 
	TString minMult                                     = fEventCutSelection(GetEventCentralityMinCutPosition(),1);
	TString maxMult                                     = fEventCutSelection(GetEventCentralityMaxCutPosition(),1);
	cout << AnalysePPMultiplicityCut(minMult.Atoi(),maxMult.Atoi()) << endl;   
	   
	//~################# V0Reader ###################### 
	TString fV0Reader                                   = fGammaCutSelection(GetPhotonV0FinderCutPosition(fGammaCutSelection),1);
	cout << AnalyseV0ReaderCut(fV0Reader.Atoi()) << endl;      
	
	//~################# Eta ###################### 
	TString fEtaCut                                     = fGammaCutSelection(GetPhotonEtaCutPosition(fGammaCutSelection),1);
	cout << AnalyseEtaCut(fEtaCut.Atoi()) << endl;
	
	//~################# RCutAndPhotonQuality ###################### 
	TString fRCut                                       = fGammaCutSelection(GetPhotonMinRCutPosition(fGammaCutSelection),1);
	TString fPhotonQuality                              = fGammaCutSelection(GetPhotonSharedElectronCutPosition(fGammaCutSelection),1);
	cout << AnalyseRCutAndQuality(fRCut.Atoi(), fPhotonQuality.Atoi()) << endl;
	
	//~################# RCut ###################### 
	TString fRCut                                       = fGammaCutSelection(GetPhotonMinRCutPosition(fGammaCutSelection),1);
	cout << AnalyseRCut(fRCut.Atoi()) << endl;
	
	//~################# SinglePt ###################### 
	TString fSinglePtCut                                = fGammaCutSelection(GetPhotonSinglePtCutPosition(fGammaCutSelection),1);
	cout << AnalyseSinglePtCut(fSinglePtCut.Atoi()) << endl;
	
	//~################# TPCCluster ###################### 
	TString fClusterCut                                 = fGammaCutSelection(GetPhotonClsTPCCutPosition(fGammaCutSelection),1);
	cout << AnalyseTPCClusterCut(fClusterCut.Atoi()) << endl; 
	
	//~################# dEdxE ###################### 
	TString fdEdxCut                                    = fGammaCutSelection(GetPhotonEDedxSigmaCutPosition(fGammaCutSelection),1);
	cout << AnalyseTPCdEdxCutElectronLine(fdEdxCut.Atoi()) << endl;
	
	//~################# dEdxPi ###################### 
	TString fdEdxCut                                    = fGammaCutSelection(GetPhotonPiDedxSigmaCutPosition(fGammaCutSelection),3);
	cout << AnalyseTPCdEdxCutPionLine(fdEdxCut.Data()) << endl;
	
	//~################# TOF ###################### 
	TString fTOFelectronPIDCut                          = fGammaCutSelection(GetPhotonTOFelectronPIDCutPosition(fGammaCutSelection),1);
	cout << AnalyseTOFelectronPIDCut(fTOFelectronPIDCut.Atoi()) << endl;
	
	//~################# Qt ###################### 
	TString fQtCut                                      = fGammaCutSelection(GetPhotonQtMaxCutPosition(fGammaCutSelection),1);
	cout << AnalyseQtMaxCut(fQtCut.Atoi()) << endl;
	
	//~################# Chi2 ###################### 
	TString fChi2Cut                                    = fGammaCutSelection(GetPhotonChi2GammaCutPosition(fGammaCutSelection),1);
	TString fPsiPairCut                                 = fGammaCutSelection(GetPhotonPsiPairCutPosition(fGammaCutSelection),1);
	cout << AnalyseChi2GammaCut(fChi2Cut.Atoi(), fPsiPairCut.Atoi()) << endl;
	
	//~################# PsiPairAndR ###################### 
	TString fPsiPairCut                                 = fGammaCutSelection(GetPhotonPsiPairCutPosition(fGammaCutSelection),1);
	TString fRCut                                       = fGammaCutSelection(GetPhotonMinRCutPosition(fGammaCutSelection),1);
	cout << AnalysePsiPairAndR(fPsiPairCut.Atoi(), fRCut.Atoi()) << endl; 
	     
	//~################# PsiPair ###################### 
	TString fPsiPairCut                                 = fGammaCutSelection(GetPhotonPsiPairCutPosition(fGammaCutSelection),1);
	TString fChi2Cut                                    = fGammaCutSelection(GetPhotonChi2GammaCutPosition(fGammaCutSelection),1);
	cout << AnalysePsiPair(fPsiPairCut.Atoi(), fChi2Cut.Atoi()) << endl;   
	
	//~################# DCAZPhoton ###################### 
	TString fDCAZCut                                    = fGammaCutSelection(GetPhotonDcaZPrimVtxCutPosition(fGammaCutSelection),1);
	cout << AnalyseDCAZPhotonCut(fDCAZCut.Atoi()) << endl;
	
	//~################# CosPoint ###################### 
	TString fCosPoint                                   = fGammaCutSelection(GetPhotonCosinePointingAngleCutPosition(fGammaCutSelection),1);
	cout << AnalyseCosPointCut(fCosPoint.Atoi()) << endl;     
	            
	//~################# PhotonQuality ###################### 
	TString fPhotonQuality                              = fGammaCutSelection(GetPhotonSharedElectronCutPosition(fGammaCutSelection),1);
	cout << AnalysePhotonQuality(fPhotonQuality.Atoi()) << endl;  
	                
	//~################# ConvPhi ###################### 
	cout << AnalyseConvPhiExclusionCut(fGammaCutSelection);  
	          
	//~################# BG ###################### 
	TString fBGCut                                      = fMesonCutSelection(GetMesonBGSchemeCutPosition(),3);
	cout << AnalyseBackgroundScheme(fBGCut.Data()) << endl; 
	  
	//~################# Rapidity ###################### 
	TString fRapidityCut                                = fMesonCutSelection(GetMesonRapidityCutPosition(),1);
	cout << AnalyseRapidityMesonCut(fRapidityCut.Atoi()) << endl; 
	     
	//~################# Alpha ###################### 
	TString fAlphaCut                                   = fMesonCutSelection(GetMesonAlphaCutPosition(),1);
	cout << AnalyseAlphaMesonCut(fAlphaCut.Atoi()) << endl;
	
	//~################# OpeningAngle ###################### 
	TString fMesonOpeningAngleCut                       = fMesonCutSelection(GetMesonOpeningAngleCutPosition(),1);
	cout << AnalyseMesonOpeningAngleCut(fMesonOpeningAngleCut.Atoi());
	
	//~################# Cent ###################### 
	cout << GetCentralityString(fEventCutSelection.Data()) << endl;
	
	//~################# DiffRapWindow ###################### 
	TString fRapidityCut                                = fMesonCutSelection(GetMesonRapidityCutPosition(),1);
	cout << AnalyseRapidityMesonCutpPb(fRapidityCut.Atoi()) << endl; 
	     
	//~################# MCSmearing ###################### 
	TString fMCSmearing                                 = fMesonCutSelection(GetMesonUseMCPSmearingCutPosition(),1);
	cout << AnalyseMCSmearingCut(fMCSmearing.Atoi()) << endl;      
	
	//~################# ClusterTrackMatchingCalo ###################### 
	TString fTrackMatching                              = fClusterCutSelection(GetClusterTrackMatchingCutPosition(fClusterCutSelection),1);
	cout << AnalyseTrackMatchingCaloCut(fTrackMatching.Atoi()) << endl;
	
	//~################# ClusterTrackMatching ###################### 
	TString fTrackMatching                              = fClusterCutSelection(GetClusterTrackMatchingCutPosition(fClusterCutSelection),1);
	cout << AnalyseTrackMatchingCut(fTrackMatching.Atoi()) << endl;
	
	//~################# ClusterMaterialTRD ###################### 
	TString fMinPhi                                     = fClusterCutSelection(GetClusterPhiMinCutPosition(fClusterCutSelection),1);
	TString fMaxPhi                                     = fClusterCutSelection(GetClusterPhiMaxCutPosition(fClusterCutSelection),1);
	cout << AnalyseAcceptanceCutPhiCluster(fMinPhi.Atoi(), fMaxPhi.Atoi()) << endl;
	
	//~################# ClusterM02 ###################### 
	TString fMinM02Cut                                  = fClusterCutSelection(GetClusterMinM02CutPosition(fClusterCutSelection),1);
	TString fMaxM02Cut                                  = fClusterCutSelection(GetClusterMaxM02CutPosition(fClusterCutSelection),1);
	cout << AnalyseM02Cut(fMinM02Cut.Atoi(), fMaxM02Cut.Atoi()) << endl;
	
	//~################# ClusterNCells ###################### 
	TString fNCellsCut                                  = fClusterCutSelection(GetClusterMinNCellsCutPosition(fClusterCutSelection),1);
	cout << AnalyseNCellsCut(fNCellsCut.Atoi()) << endl;
	
	//~################# ClusterMinEnergy ###################### 
	TString fMinEnergyCut                               = fClusterCutSelection(GetClusterMinEnergyCutPosition(fClusterCutSelection),1);
	cout << fMinEnergyCut << "\t" << GetClusterMinEnergyCutPosition(fClusterCutSelection) << "\t"<< fClusterCutSelection.Length()<<endl;
	cout << AnalyseMinEnergyCut(fMinEnergyCut.Atoi()) << endl;
	
	//~################# ClusterTiming  ###################### 
	TString fTimingCut                                  = fClusterCutSelection(GetClusterTimingCutPosition(fClusterCutSelection),1);
	cout << AnalyseClusterTimingCut(fTimingCut.Atoi()) << endl;
	
	//~################# ClusterNonLinearity ###################### 
	TString fClusterNonLinearity                        = fClusterCutSelection(GetClusterNonLinearityCutPosition(fClusterCutSelection),2);
	cout << AnalyseClusterNonLinearityCut(fClusterNonLinearity.Atoi()) << endl;
}
