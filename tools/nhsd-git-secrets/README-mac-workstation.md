# Setup (Mac only)

Ensure you have the [pre-commit framework](https://pre-commit.com/) set up first.

## TL;DR

* `pre-commit --version` (to check whether it's installed)
* `brew install pre-commit`
* `cd <project repo root>`
* `pre-commit install`

## Setup

Make sure to copy the nhd-git-secrets folder into the root of the project repository, and then navigate the terminal to the repo root

* `cd nhsd-git-secrets`
* `cp git-secrets ..`
* `cp .gitallowed-base ../.gitallowed`

Then if you don't have an existing .pre-commit-config.yaml in the root of your repo:

* `cp .pre-commit-config.example.yaml ../.pre-commit-config.yaml`

Otherwise integrate the git-secrets example config into your existing file.

Then:

* `cd ..`
* `pre-commit install`
* `git add .pre-commit-config.yaml`

Next time you do a commit the git secrets hook should be invoked.

## Custom configuration (per repo / per service team)

* Add individual regex expressions to the existing `repo_root/nhsd-git-secrets-nhsd-rules-deny.txt` file
* Or, create your own file for regex rules and add it as a provider within the [pre-commit script](pre-commit.sh) e.g.:

 `git secrets --add-provider -- cat git-secrets/nhsd-rules-deny.txt`

* Add file/dir excludes within the `repo_root/.gitallowed` file, e.g. `.*terraform.tfstate.*:*`

* Control full scan vs staged files scan within [pre-commit (mac) script](pre-commit-mac.sh) by commenting/uncommenting the mode to run e.g.:

 ```bash
 # Just scan the files changed in this commit
 # git secrets --pre_commit_hook

 # Scan all files within this repo for this commit
 git secrets --scan
 ```

## Testing-a

* make sure you have done git add if you have changed anything within git-Secrets
* Run: `pre-commit run git-secrets`

## Docker version

Alternatively, you might find this [dockerfile](nhsd-git-secrets.dockerfile) convenient, which:

1. Copies your source code into a docker image
1. Downloads latest version of the secret scanner tool
1. Downloads latest regex patterns from software-engineering-quality-framework
1. Runs a scan
