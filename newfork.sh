#! /bin/bash

FORKFROM=$1
FORKTO=$2
OLDREPONAME=`echo $FORKFROM | awk 'BEGIN { FS = "/" } ; { print $2 }' | awk 'BEGIN { FS = "." } ; { print $1 }'`
NEWREPONAME=`echo $FORKTO | awk 'BEGIN { FS = "/" } ; { print $2 }' | awk 'BEGIN { FS = "." } ; { print $1 }'`

if [[ -z $OLDREPONAME || -z $NEWREPONAME || $OLDREPONAME == *"/"* || $OLDREPONAME == *"github"* || $OLDREPONAME == *":"* || $NEWREPONAME == *"/"* || $NEWREPONAME == *"github"* || $NEWREPONAME == *":" ]];
then
	echo "invalid repo format $OLDREPONAME $NEWREPONAME";
	echo "usage: ./newfork.sh git@github.com/something/projecttofork.git git@github.com/something/newfork.git"
	exit 1;
fi

if [[-f $NEWREPONAME]];
then
	echo "folder exists";
	exit 1;
fi

echo "Forking $FORKFROM to $FORKTO in folder $NEWREPONAME"

git clone $FORKFROM $NEWREPONAME || { echo "$FORKFROM not set on github, exiting" && exit 1; }
cd $NEWREPONAME
pwd
git remote set-url origin $FORKTO 
git remote add upstream $FORKFROM
git push origin master || { echo "$FORKTO is not existing as a repo on github, exiting" && cd .. && rm -rf ./$NEWREPONAME/ && exit 1; }
git push --all

echo "done"

exit 0;
