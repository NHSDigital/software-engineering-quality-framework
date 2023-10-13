# Example: Get GitHub App access token in Bash

Dependencies are `openssl`, `curl`, `jq` and `gh`.

Prepare environment:

```bash
export GITHUB_APP_ID=...
export GITHUB_APP_PK_FILE=...
export GITHUB_ORG="nhs-england-tools"
```

Run script:

```bash
$ cd docs/adr/assets/ADR-003/examples/bash
$ ./script.sh
GITHUB_TOKEN=ghs_...
```

Check the token:

```bash
$ GITHUB_TOKEN=ghs_...; echo "$GITHUB_TOKEN" | gh auth login --with-token
$ gh auth status
github.com
  ✓ Logged in to github.com as nhs-england-update-from-template[bot] (keyring)
  ✓ Git operations for github.com configured to use https protocol.
  ✓ Token: ghs_************************************
```

See the [example (script.sh)](./script.sh) implementation. This script has been written to illustrate the concept in a clear and simple way. It is not a production ready code.
