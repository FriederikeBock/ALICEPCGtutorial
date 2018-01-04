AliAnalysisGrid* CreateAlienHandler(const char* uniqueName, const char* gridDir, const char* gridMode, const char* runNumbers,
                                     const char* pattern, TString additionalCode, TString additionalHeaders, Int_t maxFilesPerWorker,
                                     Int_t workerTTL, Bool_t isMC);

void runLocal(TString DataSet = "LHC15h1a1",
              Bool_t useGrid = kFALSE,
              Int_t setBegin = -1,
              Int_t setEnd = -1
              )
{

  cout<<"Connecting to Alien..."<<endl;
  TGrid::Connect("alien://");
  cout<<"==============================="<<endl;
  cout<<"Successfully connected to Alien"<<endl;
  cout<<"==============================="<<endl;

	TString localFolder = "/home/daniel/data/work/LocalFiles/";
	Int_t begin = 0;
	Int_t end = 0;
    TString pass = "1";
    Int_t isMC = 1;
    Bool_t isESD = kTRUE;
    TString dataSetName = "";

    const char* gridMode            = "test"; // set the grid run mode (can be "full", "test", "offline", "submit" or "terminate")
    const char* pattern             = "*/AliESDs.root";
    const char* gridDir             = "/alice/data/2012/LHC12c/000180130/pass2";
    const char* runNumbers          = "180130";
    const char* uniqueName          = "GammaConv";
    Int_t       maxFilesPerWorker   = 4;
    Int_t       workerTTL           = 7200;

//========= Choose Data Set ====
    if(DataSet.CompareTo("LHC12d")==0){
        begin=0; end=23;
        pass = "2";
        isMC = 0;
        dataSetName = "LHC12d";
        localFolder+="pp/LHC12d/pass2/";
	}else if(DataSet.CompareTo("LHC15h1a1")==0){
		begin=0; end=19;
        pass="2";
        dataSetName = "LHC15h1a1";
		localFolder+="pp/LHC15h1a1/pass2/";
    }else if(DataSet.CompareTo("LHC15h1a1-AOD")==0){
        begin=0; end=9;
        pass="2";
        isESD = kFALSE;
        dataSetName = "LHC15h1a1";
        localFolder+="pp/AOD/LHC15h1a1/pass2/";
	}else if(DataSet.CompareTo("LHC14j4b")==0){
		begin=0; end=10;
        pass="4";
        dataSetName = "LHC14j4b";
		localFolder+="pp/LHC14j4b/pass4/";
	}else if(DataSet.CompareTo("LHC11a")==0){
		begin=0; end=14;
        pass="4";
        isMC = 0;
        dataSetName = "LHC11a";
		localFolder+="pp/LHC11a/pass4/";
    }else if(DataSet.CompareTo("LHC16c2-1")==0){
        begin=0; end=8;
        pass="2";
        isMC = 2;
        dataSetName = "LHC16c2";
        localFolder+="pp/AOD/LHC16c2/1/pass2/";
        isESD = kFALSE;
    }else if(DataSet.CompareTo("LHC16c2-14")==0){
        begin=0; end=4;
        pass="2";
        isMC = 2;
        dataSetName = "LHC16c2";
        localFolder+="pp/LHC16c2/14/pass2/";
    }else if(!useGrid){
		cout << "ERROR: Selection not available: " << DataSet.Data() << ", returning..." << endl;
		return;
	}

    Bool_t bMC = (isMC>0)?kTRUE:kFALSE;

//========= Load libs ====
   if(bMC){
    TString libName = "libqpythia";
    TString getLib = gSystem->GetLibraries(libName.Data(),"",kFALSE);
    cout << "Loading lib '" << libName.Data() << "'" << endl;
    if ( getLib.IsNull() ) gSystem->Load(libName.Data());

    libName = "libAliPythia6";
    getLib = gSystem->GetLibraries(libName.Data(),"",kFALSE);
    cout << "Loading lib '" << libName.Data() << "'" << endl;
    if ( getLib.IsNull() ) gSystem->Load(libName.Data());
  }
   cout << __LINE__ << endl;
//========= Setup Chain ====
	if(setBegin>-1) begin = setBegin;
	if(setEnd>-1 && setEnd>=setBegin && setEnd<=end) end=setEnd;
	TChain *chain = 0;
    if(isESD){
        gROOT->LoadMacro("CreateRootArchiveChain.C");
		chain = CreateRootArchiveChain(localFolder.Data(),begin,end);
    }else{
        gROOT->LoadMacro("CreateRootArchiveChainAOD.C");
        chain = CreateRootArchiveChainAOD(localFolder.Data(),begin,end);
    }

//========= Create Analysis Manager ====
    AliAnalysisManager *mgr = new AliAnalysisManager("Analysis");

//========= Add InputHandlers ====
    cout << __LINE__ << endl;
    if(isESD){
        AliESDInputHandler* esdH = new AliESDInputHandler();
        mgr->SetInputEventHandler(esdH);
    }else{
        AliAODInputHandler* aodH = new AliAODInputHandler();
        mgr->SetInputEventHandler((AliAODInputHandler*)aodH);
    }

    if(isESD){
      AliMCEventHandler* mcHandler = 0x0;
      if(bMC){
         mcHandler = new AliMCEventHandler();
         mcHandler->SetPreReadMode(AliMCEventHandler::kLmPreRead);
         mcHandler->SetReadTR(kTRUE);
         mgr->SetMCtruthEventHandler(mcHandler);
      }
    }

//========= Add CDBManager ====
    cout << __LINE__ << endl;
    gROOT->LoadMacro("$ALICE_PHYSICS/PWGPP/PilotTrain/AddTaskCDBconnect.C");
    //AliTaskCDBconnect *taskCDB = AddTaskCDBconnect("local:///home/daniel/alice/ali-master/AliRoot/OCDB");
    AliTaskCDBconnect *taskCDB = AddTaskCDBconnect("cvmfs:");
    ((AliTaskCDBconnect*)(mgr->GetTask("CDBconnect")))->SetFallBackToRaw(kTRUE);

//========= Add PID Reponse ====
    cout << __LINE__ << endl;
    AliAnalysisTask * taskPID = 0x0;
    if(!bMC){
      gROOT->LoadMacro("$ALICE_ROOT/ANALYSIS/macros/AddTaskPIDResponse.C");
      taskPID = AddTaskPIDResponse();
    }else{
      gROOT->LoadMacro("$ALICE_ROOT/ANALYSIS/macros/AddTaskPIDResponse.C");
      taskPID = AddTaskPIDResponse(bMC,kFALSE,kTRUE,pass);
    }

//========= Add Physics Selection ====
  cout << __LINE__ << endl;
  AliPhysicsSelectionTask* physSelTask = 0x0;
  if(isESD){
    gROOT->LoadMacro("$ALICE_PHYSICS/OADB/macros/AddTaskPhysicsSelection.C");
    if(bMC){
      physSelTask = AddTaskPhysicsSelection(kTRUE);
      mgr->RegisterExtraFile("event_stat.root");
      mgr->AddStatisticsTask(AliVEvent::kAny);
    }else{
      physSelTask = AddTaskPhysicsSelection(kFALSE,kTRUE);
    }
  }

//========= Add EMCALTender ====
  cout << __LINE__ << endl;
  gROOT->LoadMacro("$ALICE_PHYSICS/PWG/EMCAL/macros/AddTaskEMCALTender.C");
  AliAnalysisTask *TenderEMCal = 0x0;

   if(bMC){
     TenderEMCal = AddTaskEMCALTender(kTRUE, kTRUE, kTRUE, kTRUE, kFALSE, kFALSE, kTRUE, kFALSE, kFALSE, kTRUE,
                                      AliEMCALRecoUtils::kNoCorrection, kTRUE, 0.5, 0.1, AliEMCALRecParam::kClusterizerv2,
                                      kFALSE, kFALSE, -500e9, 500e9, 1e6);
   }else{
     TenderEMCal = AddTaskEMCALTender(kTRUE, kTRUE, kTRUE, kTRUE, kFALSE, kFALSE, kTRUE, kTRUE, kTRUE, kTRUE,
                                      AliEMCALRecoUtils::kNoCorrection, kTRUE, 0.5, 0.1, AliEMCALRecParam::kClusterizerv2,
                                      kFALSE, kFALSE, -500e-9, 500e-9, 1e6);
   }

//========= Add PHOSTender ====
//      gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/PHOSTasks/PHOS_PbPb/AddAODPHOSTender.C");
//      AliAnalysisTask* tenderPHOS = AddAODPHOSTender("PHOSTenderTask", "PHOSTender",DataSet.Data(), 1, bMC);

   cout << __LINE__ << endl;
//========= Add Analysis Tasks ====
//      gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaConvCalo_pp.C");
//      AddTask_GammaConvCalo_pp(100, isMC, 2, 1, "alien:///alice/cern.ch/user/d/dmuhlhei/cellID.root", "00000003_06000008400100001000000000", 5, dataSetName, kFALSE, kFALSE, kFALSE, kTRUE, kTRUE, 3., dataSetName, kFALSE, kFALSE, "", "",kTRUE,kFALSE,kFALSE,1.,0.,0.,kFALSE);
//      AddTask_GammaConvCalo_pp(101, isMC, 0, 0, "alien:///alice/cern.ch/user/d/dmuhlhei/cellID.root", "00000003_06000008400100001000000000", 0, dataSetName, kFALSE, kFALSE, kFALSE, kFALSE, kTRUE, 3., dataSetName, kTRUE, kFALSE, "", "",kTRUE,kTRUE,kFALSE,1.,0.025,0.025,kTRUE,"0_INVMASSCLUSTree_MODIFYACCModAccEMCAL");
//      AddTask_GammaConvCalo_pp(108, isMC, 0, 0, "", "00000003_06000008400100001000000000", 1, dataSetName, kFALSE, kFALSE, kFALSE, kTRUE, kTRUE, 3., dataSetName, kFALSE, kFALSE, "", "",kTRUE,kFALSE);
//      AddTask_GammaConvCalo_pp(110, isMC, 1, 1, "", "00000003_06000008400100001000000000", 0, dataSetName, kFALSE, kFALSE, kFALSE/*, kTRUE, kTRUE, 3., dataSetName*/);
//      AddTask_GammaConvCalo_pp(31, isMC, 1, 1, "", "00000003_06000008400100001000000000", 2, dataSetName, kFALSE, kFALSE, kFALSE, kTRUE, kFALSE, 3.,dataSetName);

     gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaCalo_pp.C");
     AddTask_GammaCalo_pp(103, isMC, 1, 2, "", "00000003_06000008400100001000000000", dataSetName, kFALSE, kFALSE, 1, kFALSE, kTRUE, 3, dataSetName, kFALSE, "","",kTRUE,kFALSE,"0_EPCLUSTree_LOCALDEBUGFLAG2");
//     AddTask_GammaCalo_pp(101, isMC, 1, 1, "alien:///alice/cern.ch/user/d/dmuhlhei/cellID.root", "00000003_06000008400100001000000000", dataSetName, kFALSE, kFALSE, 1, kFALSE, kTRUE, 3, dataSetName, kFALSE, "","",kTRUE,kTRUE,"0_EPCLUSTree_MODIFYACCSM1");
//     AddTask_GammaCalo_pp(101, isMC, 1, 1, "", "00000003_06000008400100001000000000", dataSetName, kFALSE, kFALSE, 0, kTRUE, kTRUE, 3, dataSetName, kFALSE, "","",kTRUE,kTRUE,"0");
//     AddTask_GammaCalo_pp(100, isMC, 4, 0, "", "00000003_06000008400100001000000000", dataSetName, kFALSE, kFALSE, 0, kTRUE, kFALSE, 3, dataSetName, kFALSE, "","",kTRUE,kFALSE);
//     AddTask_GammaCalo_pp(115, isMC, 1, 1, "", "00000003_06000008400100001000000000", dataSetName, kFALSE, kFALSE, 2, kTRUE, kFALSE, 3, dataSetName, kFALSE);
//     AddTask_GammaCalo_pp(161, isMC, 1, 1, "", "00000003_06000008400100001000000000", dataSetName, kFALSE, kFALSE, 5, kTRUE, kFALSE, 3, dataSetName, kFALSE, "","",kTRUE,kFALSE);

//   gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaConvV1_pp.C");
//   AddTask_GammaConvV1_pp(31, isMC, 1, 1, "", "00000003_06000008400100001000000000",dataSetName, kFALSE, kFALSE, kFALSE, kFALSE, 3., dataSetName);
//   AddTask_GammaConvV1_pp(69, isMC, 1, 1, "", "00000003_06000008400100001000000000",dataSetName, kFALSE, kFALSE, kFALSE, kFALSE, 3., dataSetName);
//   AddTask_GammaConvV1_pp(89, isMC, 1, 1, "", "00000003_06000008400100001000000000",dataSetName, kFALSE, kFALSE, kFALSE, kFALSE, 3., dataSetName);

//    gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaConvNeutralMesonPiPlPiMiPiZero_CaloMode_pp.C");
//    AddTask_GammaConvNeutralMesonPiPlPiMiPiZero_CaloMode_pp(9, bMC, kTRUE, "", kFALSE, "", "", 1.0,"2");
//    gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaConvNeutralMesonPiPlPiMiPiZero_ConvMode_pp.C");
//    AddTask_GammaConvNeutralMesonPiPlPiMiPiZero_ConvMode_pp(9, bMC, kTRUE, "", kFALSE, "", "", 1.0,"2");
//    AddTask_GammaConvNeutralMesonPiPlPiMiPiZero_ConvMode_pp(21, bMC, kTRUE, "", kFALSE, "", "", 0.5);
//    gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaConvNeutralMesonPiPlPiMiPiZero_MixedMode_pp.C");
//    AddTask_GammaConvNeutralMesonPiPlPiMiPiZero_MixedMode_pp(9, bMC, kTRUE, "", kFALSE, "", "", 1.0,"2");

    gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaCaloMerged_pp.C");
    AddTask_GammaCaloMerged_pp(116, isMC, 1, 1, "", "00000003_06000008400100001000000000", dataSetName,kFALSE, 5, kTRUE, kFALSE, 3., dataSetName, 1, kFALSE, kTRUE, kFALSE, 1.0, kFALSE);
    AddTask_GammaCaloMerged_pp(117, isMC, 1, 1, "", "00000003_06000008400100001000000000", dataSetName,kFALSE, 5, kTRUE, kFALSE, 3., dataSetName, 1, kFALSE, kTRUE, kFALSE, 1.0, kFALSE);
//    AddTask_GammaCaloMerged_pp(130, isMC, 0, 0, "", "00000003_06000008400100001000000000", dataSetName,kFALSE, 0, kTRUE, kFALSE, 3., dataSetName, 1, kFALSE, kTRUE, kTRUE, 1.0, kFALSE);
//    AddTask_GammaCaloMerged_pp(132, isMC, 0, 0, "", "00000003_06000008400100001000000000", dataSetName,kFALSE, 0, kTRUE, kFALSE, 3., dataSetName, 1, kFALSE, kTRUE, kTRUE, 1.0, kFALSE);

//    gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaConvCalo_pPb.C");
//    AddTask_GammaConvCalo_pPb(1, isMC, 1, 1, "", 0, "", "8000000060084000001500000", 2, kTRUE);
//    AddTask_GammaConvCalo_pPb(2, isMC, 1, 1, "", 0, "", "8000000060084000001500000", 2, kTRUE);

//    gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_GammaCalo_pPb.C");
//    AddTask_GammaCalo_pPb(6, isMC, 1, 1, "", 0, "", "8000000060084000001500000", kFALSE, 3);


//    gROOT->LoadMacro("$ALICE_PHYSICS/PWGGA/GammaConv/macros/AddTask_OmegaToPiZeroGamma_pp.C");
//    AddTask_OmegaToPiZeroGamma_pp(1, isMC, 1, 1, kTRUE, 0.75, 2.5, "00000003_06000008400100001000000000");
//    AddTask_OmegaToPiZeroGamma_pp(101, isMC, 1, 1, kTRUE);
//    AddTask_OmegaToPiZeroGamma_pp(201, isMC,  1, 1, kTRUE);

    AliLog::SetGlobalLogLevel(AliLog::kFatal);
    //AliLog::SetGlobalLogLevel(AliLog::kInfo);

    if (!mgr->InitAnalysis()) return;
    mgr->PrintStatus();
    cout << __LINE__ << endl;

    if(!useGrid){
      mgr->SetUseProgressBar(1, 10);
      mgr->SetDebugLevel(0);
      mgr->StartAnalysis("local", chain);
    }else{
      AliAnalysisGrid *plugin = CreateAlienHandler(uniqueName, gridDir, gridMode, runNumbers, pattern, maxFilesPerWorker, workerTTL, isMC);
      mgr->SetGridHandler(plugin);

      // start analysis
      cout << "Starting GRID Analysis...";
      mgr->SetDebugLevel(2);
      mgr->StartAnalysis("grid");
    }

    return;
}

AliAnalysisGrid* CreateAlienHandler(const char* uniqueName, const char* gridDir, const char* gridMode, const char* runNumbers,
                                    const char* pattern, Int_t maxFilesPerWorker,
                                    Int_t workerTTL, Bool_t isMC)
{
  TDatime currentTime;
  TString tmpName(uniqueName);

  // Only add current date and time when not in terminate mode! In this case the exact name has to be supplied by the user
  if(strcmp(gridMode, "terminate"))
  {
    tmpName += "_";
    tmpName += currentTime.GetDate();
    tmpName += "_";
    tmpName += currentTime.GetTime();
  }

  TString macroName("");
  TString execName("");
  TString jdlName("");
  macroName = Form("%s.C", tmpName.Data());
  execName = Form("%s.sh", tmpName.Data());
  jdlName = Form("%s.jdl", tmpName.Data());

  AliAnalysisAlien *plugin = new AliAnalysisAlien();
  plugin->SetOverwriteMode();
  plugin->SetRunMode(gridMode);

  // Here you can set the (Ali)ROOT version you want to use
  plugin->SetAliROOTVersion("vAN-20180103");

  plugin->SetGridDataDir(gridDir); // e.g. "/alice/sim/LHC10a6"
  plugin->SetDataPattern(pattern); //dir structure in run directory
//  if (!isMC)
//  plugin->SetRunPrefix("000");

//  plugin->AddRunList(runNumbers);

  plugin->SetGridWorkingDir(Form("work/%s",tmpName.Data()));
  plugin->SetGridOutputDir("output"); // In this case will be $HOME/work/output

  plugin->SetDefaultOutputs(kTRUE);
  //plugin->SetMergeExcludes("");
  plugin->SetAnalysisMacro(macroName.Data());
  plugin->SetSplitMaxInputFileNumber(maxFilesPerWorker);
  plugin->SetExecutable(execName.Data());
  plugin->SetTTL(workerTTL);
  plugin->SetInputFormat("xml-single");
  plugin->SetJDLName(jdlName.Data());
  plugin->SetPrice(1);
  plugin->SetSplitMode("se");

  return plugin;
}
