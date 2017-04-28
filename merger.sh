#!/usr/bin/env bash
set -ex
git reset --hard
git clean -f
if [ -f .git/refs/heads/$1 ]; then
   git checkout $1
else 
   if [ -f .git/refs/remotes/origin/$1 ]; then
      git checkout -b $1 origin/$1
   else
      git checkout -b $1
   fi
fi
git reset --hard master
git reset HEAD@{1}
BASE_IMAGE=$(basename $(dirname $(find -name baseimage)))
./branch.sh $1 $2
git add --all
git commit -m "sync to the master" || true
git checkout master
