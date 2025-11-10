# Git commit signing setup guide

Using GPG, SSH, or S/MIME, you can sign commits and tags locally. These commits and tags are marked as verified on GitHub so other people can be confident that the changes come from a trusted source (see the full GitHub documentation [here](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)).

> You should only set up **one** of these options - **don't attempt to set up GPG and SSH commit signing**!

The instructions on this page focus on the recommended method - GPG.

## GPG commit signing

### From Workstations

If you have already committed and need to retrospectively sign commits, follow the instructions below, then follow the [retrospective commit signing instructions](./retrospective-commit-signing.md).

#### macOS

1. Install `gnupg` & `pinentry-mac` with [Brew](https://brew.sh):

    ```bash
    brew upgrade
    brew install gnupg pinentry-mac
    sed -i '' '/^export GPG_TTY/d' ~/.zshrc
    echo export GPG_TTY=\$\(tty\) >> ~/.zshrc
    source ~/.zshrc
    PINENTRY_BIN=$(whereis -q pinentry-mac)
    mkdir -p ~/.gnupg
    touch ~/.gnupg/gpg-agent.conf
    sed -i '' '/^pinentry-program/d' ~/.gnupg/gpg-agent.conf
    echo "pinentry-program ${PINENTRY_BIN}" >> ~/.gnupg/gpg-agent.conf
    gpgconf --kill gpg-agent
    ```

1. Create a new GPG key:

    ```bash
    gpg --full-generate-key
    ```

    1. Pick `ECC (sign and encrypt)` then `Curve 25519` ([Ed25519](https://en.wikipedia.org/wiki/EdDSA#Ed25519) offers the strongest encryption at time of writing)
    1. Select a key expiry time (personal choice)
    1. `Real name` = Your GitHub handle
    1. `Email address` = An email address [registered against your GitHub account](https://github.com/settings/emails) - to enable [Smart Commits](https://nhsd-confluence.digital.nhs.uk/x/SZNYRg#UsingtheGitHubintegrationinJira-SmartCommits) ([Jira/GitHub integration](https://support.atlassian.com/jira-software-cloud/docs/process-issues-with-smart-commits/)), use your `@nhs.net` address

        > If instead you opt for the private *@users.noreply.github.com* email address, consider enabling `Block command line pushes that expose my email`.

    1. Avoid adding a comment (this *may* prevent git from auto-selecting a key - see Troubleshooting section below)
    1. Review your inputs and press enter `O` to confirm
    1. Define a passphrase for the key

1. Test the key is visible and export the PGP public key (to your clipboard):

    ```bash
    gpg -k # This should list the new key
    gpg --armor --export <my_email_address> | pbcopy
    ```

    > Your PGP public key is now in your clipboard!

1. [Add the public key to your GitHub account](https://github.com/settings/gpg/new) (`Settings` -> `SSH and GPG keys` -> `New GPG key`)

    > Note the `Key ID` as you'll need this in the next step.

1. Set your local git config to use GPG signing:

    ```bash
    git config --global user.email <my_email_address> # same one used during key generation
    git config --global user.name <github_handle>
    git config --global user.signingkey <key_id>
    git config --global commit.gpgsign true
    git config --global tag.gpgsign true
    ```

1. Test it works:

    1. Create a temporary branch of your favourite repository.
    1. Make an inconsequential whitespace change.
    1. Commit the change.
        1. You will be prompted for your GPG key passphrase - optionally select to add it to the macOS Keychain.
    1. Check the latest commit shows a successful signing:

        ```bash
        $ git log --show-signature -1
        ...
        gpg: Good signature from "<github_handle> <<my_email_address>>" [ultimate]
        Author: <github_handle> <<my_email_address>>
        ...
        ```

#### Windows/WSL

1. Install (as administrator) [Git for Windows](https://git-scm.com/download/win) (which includes Bash and GnuPG)
1. Open `Git Bash`
1. Create a new GPG key:

    ```bash
    gpg --full-generate-key
    ```

    1. Pick `ECC (sign and encrypt)` then `Curve 25519` ([Ed25519](https://en.wikipedia.org/wiki/EdDSA#Ed25519) offers the strongest encryption at time of writing)
    1. Select a key expiry time (personal choice)
    1. `Real name` = Your GitHub handle
    1. `Email address` = An email address [registered against your GitHub account](https://github.com/settings/emails) - to enable [Smart Commits](https://nhsd-confluence.digital.nhs.uk/x/SZNYRg#UsingtheGitHubintegrationinJira-SmartCommits) ([Jira/GitHub integration](https://support.atlassian.com/jira-software-cloud/docs/process-issues-with-smart-commits/)), use your `@nhs.net` address

        > If instead you opt for the private *@users.noreply.github.com* email address, consider enabling `Block command line pushes that expose my email`.

    1. Avoid adding a comment (this *may* prevent git from auto-selecting a key - see Troubleshooting section below)
    1. Review your inputs and press enter `O` to confirm
    1. A new window called pinentry will appear prompting you to enter a passphrase.

1. Test the key is visible and export the PGP public key (to your clipboard):

    ```bash
    gpg -k # This should list the new key
    gpg --armor --export <my_email_address> | clip
    ```

    > Your PGP public key is now in your clipboard!

1. [Add the public key to your GitHub account](https://github.com/settings/gpg/new) (`Settings` -> `SSH and GPG keys` -> `New GPG key`)

    > Note the `Key ID` as you'll need this in the next step.

1. Set your local git config to use GPG signing:

    ```bash
    git config --global user.email <my_email_address> # same one used during key generation
    git config --global user.name <github_handle>
    git config --global user.signingkey <key_id>
    git config --global commit.gpgsign true
    git config --global tag.gpgsign true
    ```

1. Now your key is created, make it available within Windows:

    1. Export the key:

        ```bash
        gpg --output <GitHub handle>.pgp --export-secret-key <my_email_address>
        ```

    1. Install (as administrator) [Gpg4win](https://www.gpg4win.org/) (which includes GnuPG and Kleopatra)

        > **Ensure both `GnuPG` and `Kleopatra` are installed!**

    1. Open Kleopatra -> `Import` -> Select the `<GitHub handle>.pgp` file created in the first step
    1. In `cmd`, test the key is visible and set your local git config to use GPG signing:

        ```bash
        gpg -k # This should list the new key
        git config --global user.email <my_email_address> # same one used during key generation
        git config --global user.name <github_handle>
        git config --global user.signingkey <key_id>
        git config --global commit.gpgsign true
        git config --global tag.gpgsign true
        ```

1. Now make it available within WSL:

    1. Within Ubuntu:

        ```bash
        sudo ln -s /mnt/c/Program\ Files\ \(x86\)/GnuPG/bin/gpg.exe /usr/local/bin/gpg
        sudo ln -s gpg /usr/local/bin/gpg2
        ```

    1. Close and reopen your Ubuntu terminal

    1. Test the key is visible and set your local git config to use GPG signing:

        ```bash
        gpg -k # This should list the new key
        git config --global user.email <my_email_address> # same one used during key generation
        git config --global user.name <github_handle>
        git config --global user.signingkey <key_id>
        git config --global commit.gpgsign true
        git config --global tag.gpgsign true
        ```

1. Test it works:

    1. Create a temporary branch of your favourite repository.
    1. Make an inconsequential whitespace change.
    1. Commit the change.
        1. You will be prompted for your GPG key passphrase.
    1. Check the latest commit shows a successful signing:

        ```bash
        $ git log --show-signature -1
        ...
        gpg: Good signature from "<github_handle> <<my_email_address>>" [ultimate]
        Author: <github_handle> <<my_email_address>>
        ...
        ```

### From Pipelines

#### GitHub Actions

A GitHub Actions workflow will by default authenticate using a [GITHUB_TOKEN](https://docs.github.com/en/actions/security-guides/automatic-token-authentication) which is generated automatically.

However, at the time of writing, to sign commits the workflow will need to use a dedicated GitHub identity (in which to register the GPG public key).

The workflow would then use a Personal Access Token, stored with the GPG private key in the repo secrets, like so:

```yaml
steps:
  - name: Checkout
    uses: actions/checkout@v5
    with:
      token: ${{ secrets.BOT_PAT }}
      ref: main
```

Example run action script excerpt:

```bash
# Configure GPG Key for signing GitHub commits
if [ -n "${{ secrets.BOT_GPG_KEY }}" ]; then
  echo "GPG secret key found in repo secrets, enabling GitHub commmit signing"
  GITHUB_SIGNING_OPTION="-S"
  echo "${BOT_GPG_KEY}" | gpg --import
  # Highlight any expiry date
  gpg --list-secret-keys
fi
git add .
git config --global user.name "${GITHUB_USER_NAME}"
git config --global user.email "${GITHUB_USER_EMAIL}"
git commit ${GITHUB_SIGNING_OPTION} -am "Automated commit from GitHub Actions: ${WORKFLOW_URL}"
git push
```

#### AWS CodePipeline

The cryptographic libraries in the default Amazon Linux 2 distro are very old, and do not support elliptic curve cryptography. When using pre-existing solution elements updating the build container is not always an option. This restricts the GPG key algorithm to RSA. You should use RSA-4096, which is the required minimum for GitHub.

Furthermore, the Systems Manager Parameter Store will not accept a key that is generated for both signing and encrypting (which will contain a second key for the encryption). It will be too large to be pasted in as a valid parameter. So when generating the GPG key you must select type RSA (sign only) if you intend to use Parameter Store rather than AWS Secrets Manager.

Example AWS CodeBuild Buildspec excerpt:

```bash
# Create SSH identity for connecting to GitHub
BOT_SSH_KEY=$(aws ssm get-parameter --name "/keys/ssh-key" --query "Parameter.Value" --output text --with-decryption 2> /dev/null || echo "None")
if [[ ${BOT_SSH_KEY} != "None" ]]; then
  mkdir -p ~/.ssh
  echo "Host *" >> ~/.ssh/config
  echo "StrictHostKeyChecking yes" >> ~/.ssh/config
  echo "UserKnownHostsFile=~/.ssh/known_hosts" >> ~/.ssh/config
  echo "${BOT_SSH_KEY}" > ~/.ssh/ssh_key
  echo -e "\n\n" >> ~/.ssh/ssh_key
  chmod 600 ~/.ssh/ssh_key
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/ssh_key
fi

gpg --version
echo
BOT_GPG_KEY=$(aws ssm get-parameter --name "/keys/gpg-key" --query "Parameter.Value" --output text --with-decryption 2> /dev/null || echo "None")
if [ "${BOT_GPG_KEY}" != "None" ]; then
  echo "Encrypted GPG secret key found in the Parameter Store, enabling GitHub commmit signing"
  GITHUB_SIGNING_OPTION="-S"
  echo "${BOT_GPG_KEY}" | gpg --import
  # Highlight any expiry date
  gpg --list-secret-keys
  gpg-agent --daemon
  echo
fi

# GitHub publishes its public key fingerprints here:
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
# The known_hosts entry below was obtained by validating the fingerprint on a separate computer
echo "github.com ssh-ed25519 ${GITHUB_FINGERPRINT}" >> ~/.ssh/known_hosts

git config --global advice.detachedHead false
git config --global user.name "${GITHUB_USER_NAME}"
git config --global user.email "${GITHUB_USER_EMAIL}" # same one used during key generation
git clone git@github.com:${GITHUB_ORG_NAME}/${GITHUB_REPO_NAME}.git

# Make git repository source code changes here

git add .
git commit ${GITHUB_SIGNING_OPTION} -am "Automated commit from ${SCRIPT_URL}"
git push
```

### Troubleshooting

Re-run your git command prefixed with `GIT_TRACE=1`.

A failure to sign a commit is usually because the name or email does not quite match those which were used to generate the GPG key, so git cannot auto-select a key. Ensure that these are indeed consistent. (If you added a comment when creating your GPG key, this *may* cause a mismatch: the comment will be visible when listing your GPG keys, e.g. `RealName (Comment) <EmailAddress>`.) You are able to [force a choice of signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key), though this should not be necessary.
