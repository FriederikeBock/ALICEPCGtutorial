TChain* CreateRootArchiveChainAOD(TString path, Int_t offset, Int_t until)
{
    TChain* chain = new TChain("aodTree");
    TChain* friendChain = new TChain("aodTree");
    for(Int_t i=offset; i<=until; i++)
    {
        TString local(path.Data());
        TString local_friend(path.Data());
        TString local_suffix("/AliAOD.root/aodTree");
        TString local_suffix_friend("/AliAODGammaConversion.root/aodTree");
        local+=i;
        local+=local_suffix;
        local_friend+=i;
        local_friend+=local_suffix_friend;
        chain->AddFile(local.Data());
        friendChain->AddFile(local_friend.Data());
        cout << "Adding file: " << local.Data() << endl;
        cout << "Adding friend file: " << local_friend.Data() << endl;
    }
    chain->AddFriend(friendChain);
    return chain;
}
