TChain* CreateRootArchiveChain(TString path, Int_t offset, Int_t until)
{
    TChain* chain = new TChain("esdTree");
	for(Int_t i=offset; i<=until; i++)
    {
        TString local(path.Data());
		TString local_suffix("/AliESDs.root");
		local+=i;
        local+=local_suffix;
        chain->AddFile(local.Data());
        cout << "Adding file: " << local.Data() << endl;
    }
    return chain;
}
