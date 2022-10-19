# Setup (Linux/WSL only)

## Setup

Make sure to copy the `nhd-git-secrets` folder into the root of the project repository, and then navigate the terminal to the repo root

* `cd nhsd-git-secrets`
* `cp .gitallowed-base ../.gitallowed`
* `./install-linux.sh`

Next time you do a commit the git secrets hook should be invoked.

### Troubleshooting

You should have 3 new files in the `.git/hooks` folder in the repository. If these are not present, then make sure you have ran the install script and that this script ran successfully.
If you get an output containing:

```bash
[3/5] Adding Git Hooks
./install-linux.sh: line 18: git-secrets: command not found
```

* Run this command anywhere: `export PATH="$HOME/git-secrets/bin":$PATH`
* Then re-run the install script (`./nhsd-git-secrets/install-linux.sh`)

### Custom configuration (per repo / per service team)

* Add individual regex expressions to the existing `repo_root/nhsd-git-secrets-nhsd-rules-deny.txt` file
* Or, create your own file for regex rules and add it as a provider within the [pre-commit script](pre-commit.sh) e.g.:
 `./nhsd-git-secrets/git-secrets --add-provider -- cat nhsd-git-secrets/nhsd-rules-deny.txt`

* Add file/dir excludes within the `repo_root/.gitallowed`, e.g. `.*terraform.tfstate.*:*`

* Control full scan vs staged files scan within [pre-commit script](pre-commit.sh) by commenting/uncommenting the mode to run e.g.:

 ```bash
 # Just scan the files changed in this commit
 # ./nhsd-git-secrets/git-secrets --pre_commit_hook

 # Scan all files within this repo for this commit
 ./nhsd-git-secrets/git-secrets --scan
 ```

## Testing and Usage

To test that the hooks have been enabled correctly:

* make sure you have done git add if you have changed anything within git-Secrets
* create a file containing one or more patterns from the `git-secrets/nhsd-rules-deny.txt` file (e.g.: `password = “test”`)
* stage and commit the file

You should see an output similar to: `“[ERROR] Matched one or more prohibited patterns…”`.

**Note** This message may appear differently depending on the tools used.

> If you have a *false-positive* match, and your changes do not contain sensitive credentials then you can add the `--no-verify` flag to the commit command to **skip the checking**.

## Docker version

Alternatively, you might find this [dockerfile](nhsd-git-secrets.dockerfile) convenient, which:

1. Copies your source code into a docker image
1. Downloads latest version of the secret scanner tool
1. Downloads latest regex patterns from software-engineering-quality-framework
1. Runs a scan
