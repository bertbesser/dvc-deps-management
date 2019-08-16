#!/bin/bash

# disable Anonymized Usage Analytics, for those who prefer this
dvc config --global core.analytics false

# Replace with your GitHub repository and S3 bucket (created when you executed the walkthrough).
#
# The given (initial) configuration points to the GitHub repository and S3 bucket
# provided for your convenience. Both were created by the extended walkthrough.
# Note that the given AWS credentials provide read only access to the DVC
# cache remote (and no futher permissions).
export GIT_REPO=https://github.com/bbesser/dvc-deps-management-playground.git
export AWS_ACCESS_KEY_ID=AKIAUTWTWR37V2Q623BI
export AWS_SECRET_ACCESS_KEY=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

# dvc get tutorial
cd /tmp
dvc get --rev 0.3 $GIT_REPO model/model.h5

# dvc import tutorial
## create project folder and initialize repository
cd /tmp
mkdir dvc-import-tutorial
cd dvc-import-tutorial

git init
git config user.name "username"
git config user.email "username@mail.com"
dvc init
git add .
git commit -m 'initialize repository'

## add dependency
dvc import --rev 0.1 $GIT_REPO model/model.h5
ls # model.h5 was downloaded, model.h5.dvc stores versioning information
cat model.h5.dvc
git status
cat .gitignore
git add model.h5.dvc .gitignore # save version
git commit -m 'add model.h5 (version 0.1) as dependency'
git tag v0.0.1

# increase version
dvc import --rev 0.2 $GIT_REPO model/model.h5
git status
git add model.h5.dvc # save updated version
git commit -m 'update model.h5 to version 0.2'
git tag v0.0.2

# cloning a project with imports
cd /tmp
# clone project from previous section
git clone dvc-import-tutorial dvc-clone-imports-tutorial
cd dvc-clone-imports-tutorial
git checkout v0.0.1
ls # there is only model.h5.dvc
dvc update model.h5.dvc
ls # now model.h5 was downloaded
dvc update model.h5.dvc # no version change => no new download
git checkout v0.0.2
dvc update model.h5.dvc # the new version will be downloaded

