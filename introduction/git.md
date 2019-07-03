# Git

Git is a very powerful version control system which is very popular \(and it is also used for all our software repositories\). You are expected to know about Git and to be able to work with it. If you don't know how to push, pull, rebase and configure Git, you should have a look at the given links below and learn about Git.

It is recommended to use a visualization tool as it eases your workflow and gives you direct insight into the state of a repository and the status of all the branches. There are two different tools which are recommended to use:

1: _gitk_

In general, you can install it via your package manager, for example:

> sudo apt-get install gitk

For more information see [gitk](https://git-scm.com/docs/gitk).

2: _tig_

In general, you can install it via your package manager, for example:

> sudo apt-get install tig

For more information see [tig](http://jonas.nitro.dk/tig/manual.html).

## Suggested workflow

[Suggested workflow](https://dberzano.github.io/alice/git/#workflow)

## Basic GIT workflow in our repositories

Checkout your development branch in the given repository

> git checkout UserBranch

make your changes to the macros and/or add new files \(i.e. ExtractSignalBinning.h\)

> git add ExtractSignalBinning.h

Write a commit message and make the commit itself via:

> git commit -m "Changed binning for some energy"

Checkout the master branch and rebase to the latest version

> git checkout master
>
> git pull --rebase

Checkout your branch again and rebase it to the latest master version

> git checkout UserBranch
>
> git rebase master

If everything works with the rebase, then push the changes.

> git push origin UserDevel

Afterwards, a merge request can be made on the git repositories website.

## Useful Links

* [General Git tutorial](https://git-scm.com/doc)
* [ALICE Git tutorial](https://dberzano.github.io/alice/git/)

