#!/bin/bash -x
read -p "enter branch name" branchname
read -p "enter commit message" msg
git add .
git commit -m "$msg"
git checkout master
git merge "$branchname"
git push
git checkout $branchname
git push origin $branchname

