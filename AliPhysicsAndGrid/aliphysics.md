# GRID and AliRoot/AliPhysics

## GRID

[What is the GRID?](http://wlcg.web.cern.ch/)

You need to have a valid GRID certificate if you want to work with ALICE data.
If you don't know what a GRID certificate is, please ask your supervisor as he needs to request a certificate for you.

[How-To get/install the GRID certificate](https://dberzano.github.io/alice/alien-certificate/)

Once you have a valid, correctly installed certificate, you should be able to access: [MonALISA Repository for ALICE](http://alimonitor.cern.ch/map.jsp)

## Install AliRoot/AliPhysics using aliBuild

Please have a look at the following webpage, it provides everything you need to do / you need to know:

* [ALICE Software installation](https://dberzano.github.io/alice/install-aliroot/)
* [aliBuild documentation](http://alisw.github.io/alibuild/tutorial.html)

Unless you are not looking to analyse jets, you may run aliBuild with the following disable options to reduce the time of the build (in general, you won't need GEANT nor fastjet). If you want to analyse jets, just leave out fastjet in the disable section:

> aliBuild -z -w ../sw -d build AliPhysics --disable GEANT3,GEANT4_VMC,fastjet

## Some tweaks (optional)

Create the following files with the given contents:

* compile\_alibuild.sh

```
currentFolder=`pwd`
cd $HOME/alice/ali-master
aliBuild -z -w ../sw -d build AliPhysics --disable GEANT3,GEANT4_VMC,fastjet
cd $currentFolder
```

* compile\_aliphysics.sh

```
currentFolder=`pwd`
cd $HOME/alice/sw/BUILD/AliPhysics-latest-ali-master/AliPhysics
alienv load AliPhysics/latest-ali-master
make -j5 install
if [ $# -eq 0 ]
  then
    ctest --output-on-failure -j 4 && echo All tests OK
fi
cd $currentFolder
```

* compile\_aliroot.sh

```
currentFolder=`pwd`
cd $HOME/alice/sw/BUILD/AliRoot-latest-ali-master/AliRoot
alienv load AliPhysics/latest-ali-master
make -j5 install
if [ $# -eq 0 ]
  then
    ctest -R load_library --output-on-failure -j 4 && echo All tests OK
fi
cd $currentFolder
```

* tbrowser.C

```
{
TBrowser a;
}
```

and add the following lines to your _.bash\_aliases_ :

> alias ali='alienv load AliPhysics/latest-ali-master'
> alias aliunload='alienv unload AliPhysics/latest-ali-master'
> alias alienter='alienv enter AliPhysics/latest-ali-master'
> alias alipc='. ~/alice/compile_alibuild.sh'
> alias alis='cd ~/alice/ali-master/AliPhysics'
> alias alib='cd ~/alice/sw/BUILD/AliPhysics-latest-ali-master/AliPhysics/'
> alias alic='. ~/alice/compile_aliphysics.sh'
> alias aliroots='cd ~/alice/ali-master/AliRoot'
> alias alirootb='cd ~/alice/sw/BUILD/AliRoot-latest-ali-master/AliRoot/'
> alias alirootc='. ~/alice/compile_aliroot.sh'
> alias token='alien-token-init dmuhlhei'
> alias tb='root -l ~/alice/tbrowser.C'

Then, you just need to type '_ali_' in the command line and you are in the ALICE software environment. 
Using '_alipc_' you can re-build the whole software chain and using '_alic_' or '_alirootc_' you can trigger rebuild of AliPhysics and AliRoot respectively, no matter in which directory you currently are in the shell.
Also, you can easily enter a TBrowser by just typing '_tb_'.
