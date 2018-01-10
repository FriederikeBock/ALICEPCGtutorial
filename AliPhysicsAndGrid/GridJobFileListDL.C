#include <stdlib.h>
void readin(TString fileRuns, std::vector<TString> &vec);
Bool_t copyAli2Local(TString where, TString loc, TString rem);
Bool_t copyAlien2Local(TString where, TString loc, TString rem);

void GridJobFileListDL(
                       TString file = "list1.txt",
                       TString subfolder = "pp/LHC12c/pass2",
                       TString folder = "/home/daniel/data/work/LocalFiles",
                       TString location = "")
{
    cout<<"Connecting to Alien..."<<endl;
    TGrid::Connect("alien://");
    cout<<"==============================="<<endl;
    cout<<"Successfully connected to Alien"<<endl;
    cout<<"==============================="<<endl;

	std::vector<TString> vecPath;
    TString fPathGrid;
    TString fPathLocal;

	vecPath.clear();
	cout << "\n------------------------------------------------------" << endl;
	if(!readin(file, vecPath)) {cout << "ERROR, could not find file or empty? Returning..." << endl; return;}
	cout << "------------------------------------------------------" << endl;

	for(Int_t j=0; j<vecPath.size(); j++)
	{
		fPathGrid = (vecPath.at(j));
        if(!location.IsNull()) {fPathGrid+="@"; fPathGrid+=location;}
		cout << "\tCopying from (grid): " << fPathGrid.Data() << endl;
		if(subfolder.CompareTo("")==0) fPathLocal = Form("%s/%i", folder.Data(), j);
		else fPathLocal = Form("%s/%s/%i", folder.Data(), subfolder.Data(), j);
		gSystem->Exec(Form("mkdir -p %s",fPathLocal.Data()));
		fPathLocal+="/"; fPathLocal+="root_archive.zip";
		cout << "\tCopying to (local): " << fPathLocal.Data() << endl;
		TFile fileCheck(fPathLocal.Data());
		if(!fileCheck.IsZombie()) {cout << "Info: ROOT-File |" << fPathLocal.Data() << "| does already exist! Continue..." << endl; continue;}
        if(!copyAli2Local("",fPathGrid,fPathLocal)){ cout << "Err: copyAlien2Local(), continue..." << endl; continue;}
		TString fPath = fPathLocal;
		fPath.Remove(fPath.Length()-16,16);
		cout << "\tExecuting: " << Form("unzip -o %s -d %s",fPathLocal.Data(),fPath.Data()) << endl;
		gSystem->Exec(Form("unzip -o %s -d %s",fPathLocal.Data(),fPath.Data()));
		cout << "\tExecuting: " << Form("rm %s",fPathLocal.Data()) << endl;
		gSystem->Exec(Form("rm %s",fPathLocal.Data()));
	}

    return;
}

Bool_t readin(TString fileRuns, std::vector<TString> &vec)
{
    cout << Form("Reading from %s...", fileRuns.Data()) << endl;
    fstream file;
    TString fVar;
    Int_t totalN=0;
    file.open(fileRuns.Data(), ios::in);
    if(file.good())
    {
        file.seekg(0L, ios::beg);
        cout << "Processing Runs: \"";
        while(!file.eof())
        {
            file >> fVar;
            if(fVar.Sizeof()>1)
            {
                cout << fVar.Data() << ", ";
                vec.push_back(fVar);
                totalN++;
            }
        }
        cout << "\"" << endl;
    }
    file.close();
    cout << "...done!\n\nIn total " << totalN << " Runs will be processed!" << endl;
    if(totalN > 0) return kTRUE;
    else return kFALSE;
}

Bool_t copyAli2Local(TString where, TString loc, TString rem)
{
   system(Form("alien_cp -o alien://%s file://%s",loc.Data(), rem.Data()));
   return true;
}

Bool_t copyAlien2Local(TString where, TString loc, TString rem)
{
   TString sl(Form("alien://%s", loc.Data()));
   TString sr(Form("file://%s", rem.Data()));
   Bool_t ret = TFile::Cp(sl,sr);
   if (!ret) {
      Warning(where.Data(), "Failed to copy %s to %s", sl.Data(), sr.Data());
   }
   return ret;
}
