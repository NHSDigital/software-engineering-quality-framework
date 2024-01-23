#!/usr/bin/env bash
 
cd ..

export PATH=$PATH:.

# # These only need to be run once per workstation/slave/agent but are included to try and ensure they are present
./git-secrets --register-aws
./git-secrets --add-provider -- cat nhsd-git-secrets/nhsd-rules-deny.txt
./git-secrets --add --allowed '.*git-secrets/.*:*'
./git-secrets --add --allowed '.*terraform.tfstate.*:*'

# Scan all files within this repo for this commit
./git-secrets --scan-history
