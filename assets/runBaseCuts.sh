#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_20_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_20_D.root eps < answersMBPCMEMC.txt
referenceDirectoryData=/mnt/additionalStorage/OutputLegoTrains/pPb/Legotrain-vAN20170525FF-newDefaultPlusSys
referenceDirectoryMC=/mnt/additionalStorage/OutputLegoTrains/pPb/Legotrain-vAN20170525FF-newDefaultPlusSys

cocktailFile=/home/fbock/Photon/Software/PCGGIT/CocktailGridRuns/EMCocktail_pPb5TeV_PCMEMC_defaultParam_20170901.root

if [ $1 = "full" ]; then
    echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010" > CutSelection.log
    echo -e "2\nN\npPb5\nY\n$cocktailFile\n0.80\nYPCMEMC\n28\nY\nN\nG\nY" > answersMBPCMEMC.txt
    bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_20_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_20_A.root eps < answersMBPCMEMC.txt

elif [ $1 = "sysMB" ]; then

    echo -e "2\nN\npPb5\nY\n$cocktailFile\n0.80\nYPCMEMC\n28\nY\nN\nG\nY" > answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_20_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_20_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_20_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_20_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_21_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_21_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_21_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_21_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_21_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_21_C.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_22_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_22_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_22_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_22_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_22_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_22_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_22_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_22_D.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_22_E.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_22_E.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_22_F.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_22_F.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_22_G.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_22_G.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_23_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_23_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_23_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_23_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_23_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_23_C.root eps < answersMBPCMEMC.txt
    bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_23_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_23_D.root eps < answersMBPCMEMC.txt
    bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_20_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_20_A.root eps <    answersMBPCMEMC.txt

#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_24_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_24_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_24_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_24_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_24_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_24_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_24_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_24_D.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_24_E.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_24_E.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_25_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_25_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_25_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_25_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_25_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_25_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_25_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_25_D.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_25_E.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_25_E.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_26_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_26_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_26_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_26_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_26_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_26_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_26_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_26_D.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_26_E.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_26_E.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_27_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_27_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_27_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_27_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_27_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_27_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_27_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_27_D.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_28_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_28_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_28_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_28_B.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_29_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_29_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_29_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_29_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_29_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_29_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_29_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_29_D.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_30_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_30_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_30_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_30_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_30_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_30_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_30_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_30_D.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_30_E.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_30_E.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_31_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_31_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_31_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_31_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_31_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_31_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_31_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_31_D.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_32_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_32_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_32_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_32_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_32_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_32_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_32_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_32_D.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_33_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_33_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_33_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_33_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_33_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_33_C.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_34_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_34_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_34_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_34_B.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_34_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_34_C.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_34_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_34_D.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_10_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_10_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_10_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_11_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_11_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_11_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_12_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_12_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_12_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_14_A.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_14_B.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_14_C.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt
#     bash start_FullMesonAnalysis_TaskV3.sh -etaOff $referenceDirectoryData/GammaConvCalo_LHC13bc-pass2_14_D.root $referenceDirectoryMC/GammaConvCalo_MC_LHC13b2_efix_p1_p2_p3_p4_19_A.root eps < answersMBPCMEMC.txt

elif [ $1 = "sysVar" ]; then

#
# #
# # # #     Non lin variation
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008250400000_1111100057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111101057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111102057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111143057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111144057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111153057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111154057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111151057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111152057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111142057032230000_0163103100000010
# # # 80000113_00200009327000008250400000_1111101057032230000_0163103100000010\n80000113_00200009327000008250400000_1111102057032230000_0163103100000010\n80000113_00200009327000008250400000_1111143057032230000_0163103100000010\n80000113_00200009327000008250400000_1111144057032230000_0163103100000010\n80000113_00200009327000008250400000_1111153057032230000_0163103100000010\n80000113_00200009327000008250400000_1111154057032230000_0163103100000010\n
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111151057032230000_0163103100000010\n80000113_00200009327000008250400000_1111152057032230000_0163103100000010\n80000113_00200009327000008250400000_1111142057032230000_0163103100000010" >  CutSelectionClusterNonLin.log
#     echo -e "ClusterNonLinearity\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterNonLin.txt
#     cp CutSelectionClusterNonLin.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterNonLin.txt
#
# #
# # #     material
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008250400000_1111341057032230000_0163103100000010
# # 80000113_00200009327000008250400000_1112141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111341057032230000_0163103100000010\n80000113_00200009327000008250400000_1112141057032230000_0163103100000010" >  CutSelectionClusterMaterial.log
#     echo -e "ClusterMaterialTRD\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterMaterial.txt
#     cp CutSelectionClusterMaterial.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterMaterial.txt
# #
# #     NCells
# #     80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# #     80000113_00200009327000008250400000_1111141057031230000_0163103100000010
# #     80000113_00200009327000008250400000_1111141057033230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057031230000_0163103100000010" >  CutSelectionClusterNCells.log
#     echo -e "ClusterNCells\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterNCells.txt
#     cp CutSelectionClusterNCells.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterNCells.txt
# #
# # #     M02
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008250400000_1111141057032200000_0163103100000010
# # 80000113_00200009327000008250400000_1111141057032250000_0163103100000010
# # 80000113_00200009327000008250400000_1111141057032260000_0163103100000010
# #     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032200000_0163103100000010\n80000113_00200009327000008250400000_1111141057032250000_0163103100000010\n80000113_00200009327000008250400000_1111141057032260000_0163103100000010" >  CutSelectionClusterM02.log
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032200000_0163103100000010" >  CutSelectionClusterM02.log
#     echo -e "ClusterM02\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterM02.txt
#     cp CutSelectionClusterM02.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterM02.txt
#
# # #     track matching
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008250400000_1111141053032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111141056032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111141058032230000_0163103100000010
# # 80000113_00200009327000008250400000_1111141059032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141053032230000_0163103100000010\n80000113_00200009327000008250400000_1111141056032230000_0163103100000010\n80000113_00200009327000008250400000_1111141058032230000_0163103100000010\n80000113_00200009327000008250400000_1111141059032230000_0163103100000010" >  CutSelectionClusterTM.log
#     echo -e "ClusterTrackMatching\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterTM.txt
#     cp CutSelectionClusterTM.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterTM.txt
#
# # #     Alpha variation
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008250400000_1111141057032230000_0163105100000010
# # 80000113_00200009327000008250400000_1111141057032230000_0163106100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163105100000010\n80000113_00200009327000008250400000_1111141057032230000_0163106100000010" >  CutSelectionAlpha.log
#     echo -e "Alpha\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersAlpha.txt
#     cp CutSelectionAlpha.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersAlpha.txt
#
# # #     min energy
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008250400000_1111141057042230000_0163103100000010
# # 80000113_00200009327000008250400000_1111141057052230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057042230000_0163103100000010\n80000113_00200009327000008250400000_1111141057052230000_0163103100000010" >  CutSelectionClusterMinE.log
#     echo -e "ClusterMinEnergy\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterMinE.txt
#     cp CutSelectionClusterMinE.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterMinE.txt
#
# # #     TPC cluster
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200006327000008250400000_1111141057032230000_0163103100000010
# # 80000113_00200008327000008250400000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200006327000008250400000_1111141057032230000_0163103100000010\n80000113_00200008327000008250400000_1111141057032230000_0163103100000010" >  CutSelectionTPCCluster.log
#     echo -e "TPCCluster\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersTPCCluster.txt
#     cp CutSelectionTPCCluster.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersTPCCluster.txt
#
# # #     dEdxE
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009127000008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009227000008250400000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009127000008250400000_1111141057032230000_0163103100000010\n80000113_00200009227000008250400000_1111141057032230000_0163103100000010" >  CutSelectiondEdxE.log
#     echo -e "dEdxE\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersdEdxE.txt
#     cp CutSelectiondEdxE.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersdEdxE.txt
# #
# # #     Conv Phi
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00202209327000008250400000_1111141057032230000_0163103100000010
# # 80000113_00204409327000008250400000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00202209327000008250400000_1111141057032230000_0163103100000010\n80000113_00204409327000008250400000_1111141057032230000_0163103100000010" >  CutSelectionConvPhi.log
#     echo -e "ConvPhi\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersConvPhi.txt
#     cp CutSelectionConvPhi.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersConvPhi.txt
# #
# # #     Qt variations
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000009250400000_1111141057032230000_0163103100000010
# # 80000113_00200009327000002250400000_1111141057032230000_0163103100000010
# # 80000113_00200009327000003250400000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000009250400000_1111141057032230000_0163103100000010\n80000113_00200009327000002250400000_1111141057032230000_0163103100000010\n80000113_00200009327000003250400000_1111141057032230000_0163103100000010" >  CutSelectionQt.log
#     echo -e "Qt\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersQt.txt
#     cp CutSelectionQt.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersQt.txt
#
# # #     Psi Pair/ chi2
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008260400000_1111141057032230000_0163103100000010
# # 80000113_00200009327000008280400000_1111141057032230000_0163103100000010
# # 80000113_00200009327000008850400000_1111141057032230000_0163103100000010
# # 80000113_00200009327000008860400000_1111141057032230000_0163103100000010
# # 80000113_00200009327000008880400000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008260400000_1111141057032230000_0163103100000010\n80000113_00200009327000008280400000_1111141057032230000_0163103100000010\n80000113_00200009327000008850400000_1111141057032230000_0163103100000010\n80000113_00200009327000008860400000_1111141057032230000_0163103100000010\n80000113_00200009327000008880400000_1111141057032230000_0163103100000010" >  CutSelectionChi2.log
#     echo -e "Chi2\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersChi2.txt
#     cp CutSelectionChi2.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersChi2.txt
# #
# # #     To close V0s
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009327000008250401000_1111141057032230000_0163103100000010
# # 80000113_00200009327000008250402000_1111141057032230000_0163103100000010
# # 80000113_00200009327000008250403000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250401000_1111141057032230000_0163103100000010\n80000113_00200009327000008250402000_1111141057032230000_0163103100000010\n80000113_00200009327000008250403000_1111141057032230000_0163103100000010" >  CutSelectionToCloseV0s.log
#     echo -e "ToCloseV0s\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersToCloseV0s.txt
#     cp CutSelectionToCloseV0s.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersToCloseV0s.txt
#
# # #     Single pt
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200019327000008250400000_1111141057032230000_0163103100000010
# # 80000113_00200049327000008250400000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200019327000008250400000_1111141057032230000_0163103100000010\n80000113_00200049327000008250400000_1111141057032230000_0163103100000010" >  CutSelectionSinglePt.log
#     echo -e "SinglePt\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersSinglePt.txt
#     cp CutSelectionSinglePt.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersSinglePt.txt
#
# # #     dEdxPi
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000113_00200009315600008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009317000008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009317300008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009320000008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009325000008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009327300008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009327400008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009327600008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009347400008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009357000008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009367400008250400000_1111141057032230000_0163103100000010
# # 80000113_00200009387300008250400000_1111141057032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009315600008250400000_1111141057032230000_0163103100000010\n80000113_00200009317000008250400000_1111141057032230000_0163103100000010\n80000113_00200009317300008250400000_1111141057032230000_0163103100000010\n80000113_00200009320000008250400000_1111141057032230000_0163103100000010\n80000113_00200009325000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327300008250400000_1111141057032230000_0163103100000010\n80000113_00200009327400008250400000_1111141057032230000_0163103100000010\n80000113_00200009327600008250400000_1111141057032230000_0163103100000010\n80000113_00200009347400008250400000_1111141057032230000_0163103100000010\n80000113_00200009357000008250400000_1111141057032230000_0163103100000010\n80000113_00200009367400008250400000_1111141057032230000_0163103100000010\n80000113_00200009387300008250400000_1111141057032230000_0163103100000010" >  CutSelectiondEdxPi.log
#     echo -e "dEdxPi\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersdEdxPi.txt
#     cp CutSelectiondEdxPi.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersdEdxPi.txt
#
#     # #    ClusterTiming
#     # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
#     # 80000113_00200009327000008250400000_1111141007032230000_0163103100000010
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141007032230000_0163103100000010" >  CutSelectionClusterTiming.log
#     echo -e "ClusterTiming\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterTiming.txt
#     cp CutSelectionClusterTiming.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterTiming.txt


    # #    Cocktail
    # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
    echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010" >  CutSelectionClusterTiming.log
    echo -e "Cocktail\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterTiming.txt
    cp CutSelectionClusterTiming.log CutSelection.log
    bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterTiming.txt

#     # #    IntRange
#     # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
#     echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000113_00200009327000008250400000_1111141057032230000_0163103100000010" >  CutSelectionClusterTiming.log
#     echo -e "IntRange\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersClusterTiming.txt
#     cp CutSelectionClusterTiming.log CutSelection.log
#     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersClusterTiming.txt
#
# #
# # #    PF protection
# # 80000113_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000313_00200009327000008250400000_1111141007032230000_0163103100000010
# # 80000413_00200009327000008250400000_1111141007032230000_0163103100000010
# # 80000513_00200009327000008250400000_1111141007032230000_0163103100000010
# # echo -e "80000113_00200009327000008250400000_1111141057032230000_0163103100000010\n80000313_00200009327000008250400000_1111141007032230000_0163103100000010\n80000413_00200009327000008250400000_1111141007032230000_0163103100000010\n80000513_00200009327000008250400000_1111141007032230000_0163103100000010" >  CutSelectionSinglePt.log
# #     echo -e "PFProtection\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersPFProtec.txt
# #     cp CutSelectionSinglePt.log CutSelection.log
# #     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersPFProtec.txt
#
# # #    PF protection
# # 80000313_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000313_00200009327000008250400000_1111141047032230000_0163103100000010
# # 80000313_00200009327000008250400000_1111141007032230000_0163103100000010
# # 80000313_00200009327000008250400000_1111141017032230000_0163103100000010
# # echo -e "80000313_00200009327000008250400000_1111141017032230000_0163103100000010\n80000313_00200009327000008250400000_1111141047032230000_0163103100000010\n80000313_00200009327000008250400000_1111141007032230000_0163103100000010\n80000313_00200009327000008250400000_1111141017032230000_0163103100000010" >  CutSelectionTimingPF.log
# #     echo -e "PFProtectionTiming\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersPFProtec.txt
# #     cp CutSelectionTimingPF.log CutSelection.log
# #     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersPFProtec.txt
#
# # #    PF protection
# # 80000413_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000413_00200009327000008250400000_1111141047032230000_0163103100000010
# # 80000413_00200009327000008250400000_1111141007032230000_0163103100000010
# # 80000413_00200009327000008250400000_1111141017032230000_0163103100000010
# #     echo -e "80000413_00200009327000008250400000_1111141017032230000_0163103100000010\n80000413_00200009327000008250400000_1111141047032230000_0163103100000010\n80000413_00200009327000008250400000_1111141007032230000_0163103100000010\n80000413_00200009327000008250400000_1111141017032230000_0163103100000010" >  CutSelectionTimingPF.log
# #     echo -e "PFProtectionTiming2\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersPFProtec.txt
# #     cp CutSelectionTimingPF.log CutSelection.log
# #     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersPFProtec.txt
#
# # #    PF protection
# # 80000513_00200009327000008250400000_1111141057032230000_0163103100000010 # default
# # 80000513_00200009327000008250400000_1111141047032230000_0163103100000010
# # 80000513_00200009327000008250400000_1111141007032230000_0163103100000010
# # 80000513_00200009327000008250400000_1111141017032230000_0163103100000010
# #     echo -e "80000513_00200009327000008250400000_1111141017032230000_0163103100000010\n80000513_00200009327000008250400000_1111141047032230000_0163103100000010\n80000513_00200009327000008250400000_1111141007032230000_0163103100000010\n80000513_00200009327000008250400000_1111141017032230000_0163103100000010" >  CutSelectionTimingPF.log
# #     echo -e "PFProtectionTiming3\nLHC13bc\n2\nY\npPb5\nY\n$cocktailFile\n0.80\nY\n28\nY\nY" > answersPFProtec.txt
# #     cp CutSelectionTimingPF.log CutSelection.log
# #     bash start_FullMesonAnalysis_TaskV3.sh -detaOff fileName eps < answersPFProtec.txt
#


elif [ $1 = "sysFinal" ]; then

    root -b -x -q -l 'FinaliseSystematicErrorsConvCalo_Gammas_pPb.C+("CutStudies/pPb_5.023TeV/Gamma_SystematicErrorCuts.root","pPb_5.023TeV","0-100%","Gamma",24,0.8,14.0,"pdf",2)'
    root -b -x -q -l 'FinaliseSystematicErrorsConvCalo_Gammas_pPb.C+("CutStudies/pPb_5.023TeV/Gamma_SystematicErrorCuts.root","pPb_5.023TeV","0-100%","IncRatio",24,0.8,14.0,"pdf",2)'
    root -b -x -q -l 'FinaliseSystematicErrorsConvCalo_Gammas_pPb.C+("CutStudies/pPb_5.023TeV/Gamma_SystematicErrorCuts.root","pPb_5.023TeV","0-100%","DoubleRatio",24,0.8,14.0,"pdf",2)'

elif [ $1 = "combTM" ]; then
    # without binshift for eta/pi0
#     root -l -b -x -q 'TaskV1/ProduceFinalResultsPatchedTriggers.C+("TriggerComp_noPileup.dat",2,6,"eps","data","2.76TeV","LHC11a+LHC13g",kTRUE,16,kTRUE,kTRUE,16,kTRUE)'

    #with binshift for eta/pi0
    root -l -b -x -q 'TaskV1/ProduceFinalResultsPatchedTriggers.C+("TriggerComp_noPileupTM.dat",2,1,"eps","data","pPb_5.023TeV","LHC13[b-c]",kTRUE,20,kFALSE,kTRUE,16,kFALSE,kFALSE,"FitsPaperPPpPb5023GeV_2017_08_15.root",kTRUE,"")'

elif [ $1 = "gammaFinal" ]; then
    root -l -b -x -q 'TaskV1/ProduceFinalGammaResultsV2.C+("configFilePCMpPbDirGamma.txt","pPb_5.023TeV","eps",2)'
fi
