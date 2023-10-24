# Example: Get GitHub App access token in Node.js TypeScript (using Octokit)

Dependencies are listed in the `package.json` file.

Prepare environment:

```bash
export GITHUB_APP_ID=...
export GITHUB_APP_PK_FILE=...
export GITHUB_ORG="nhs-england-tools"
```

Run script:

```bash
$ cd docs/adr/assets/ADR-003/examples/nodejs
$ yarn install
$ yarn start
[
  {
    name: 'repository-template',
    full_name: 'nhs-england-tools/repository-template',
    private: false,
    owner: {
      login: 'nhs-england-tools',
      ...
```

See the [example (main.ts)](./main.ts) implementation. This script has been written to illustrate the concept in a clear and simple way. It is not a production ready code.
