#!/usr/bin/env bash

# Note that this will be invoked by the git hook from the repo root, so cd .. isn't required

# These only need to be run once per workstation but are included to try and ensure they are present
./nhsd-git-secrets/git-secrets --add-provider -- cat nhsd-git-secrets/nhsd-rules-deny.txt

# Just scan the files changed in this commit
./nhsd-git-secrets/git-secrets --pre_commit_hook
