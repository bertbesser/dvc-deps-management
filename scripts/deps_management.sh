#!/bin/bash

# Replace with your GitHub repository and S3 bucket (created when you executed the walkthrough).
#
# The given (initial) configuration points to the GitHub repository and S3 bucket
# provided for your convenience. Both were created by the extended walkthrough.
# Note that the given AWS credentials provide read only access to the DVC
# cache remote (and no futher permissions).
export GIT_REPO=https://github.com/bbesser/dvc-deps-management-companion.git
export AWS_ACCESS_KEY_ID=AKIAUTWTWR37V2Q623BI
export AWS_SECRET_ACCESS_KEY=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

dvc get --rev 0.3 $GIT_REPO model/model.h5
