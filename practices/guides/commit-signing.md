# Git Commit Signing Setup Guide

- [From Workstations](#From-Workstations):
  - [macOS](#macOS)
  - [Windows](#Windows)
- [From Pipelines](#From-Pipelines):
  - [GitHub Actions](#GitHub-Actions)
  - [AWS CodePipeline](#AWS-CodePipeline)
- [Troubleshooting](#Troubleshooting)

<br>

# From Workstations:

## macOS
- Install the Brew package manager: https://brew.sh
```
brew upgrade
brew install gnupg pinentry-mac
gpg --full-generate-key
```
- Accept the defaults, Curve 25519 etc.
- Enter your GitHub account name as the Real Name
- Enter your GitHub account email as the Email Address
- You can use the privacy *@users.noreply.github.com* email address listed in the GitHub *Profile > Settings > Email*
- Define a passphrase and keep it in your password manager
```
gpg --armor --export ${my_email_address} | pbcopy
```
 
- Public key is now in your clipboard - in your GitHub account add it to your profile here:
*Settings > SSH and GPG Keys> Add New GPG Key*
- Paste it in
```
git config --global user.email ${my_email_address} # same one used during key generation
git config --global user.name ${my_username}
git config --global commit.gpgsign true
echo export GPG_TTY=\$\(tty\) >> ~/.zshrc
source ~/.zshrc
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```
The first time you commit you will be prompted to add the GPG key passphrase to the macOS Keychain. Thereafter signing will happen seamlessly without prompts.

Most of the published solutions for this don't work because *brew* seems to have moved the default folder for binaries, plus many guides contain obsolete settings for *gnupg*.

<br>

## Windows
- Install Git for Windows, which includes Bash and GnuPG: https://git-scm.com/download/win
- Right-click on the Desktop > _Git Bash Here_
```
gpg --full-generate-key
```
- Pick _RSA and RSA_, or _RSA (sign only)_
- Set key size to 4096 bit, the minimum accepted for GitHub
- Enter your GitHub account name as the Real Name
- Enter your GitHub account email as the Email Address
- You can use the privacy *@users.noreply.github.com* email address listed in the GitHub *Profile > Settings > Email*
- Define a passphrase and keep it in your password manager
```
gpg --armor --export ${my_email_address} | clip
```
 
- Public key is now in your clipboard - in your GitHub account add it to your profile here:
*Settings > SSH and GPG Keys> Add New GPG Key*
- Paste it in
```
git config --global user.email ${my_email_address} # same one used during key generation
git config --global user.name ${my_username}
git config --global commit.gpgsign true
echo export GPG_TTY=\$\(tty\) >> ~/.zshrc
source ~/.zshrc
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```
The first time you commit you will be prompted to add the GPG key passphrase to the macOS Keychain. Thereafter signing will happen seamlessly without prompts.

Most of the published solutions for this don't work because *brew* seems to have moved the default folder for binaries, plus many guides contain obsolete settings for *gnupg*.


<br>

# From Pipelines:

## GitHub Actions
A GitHub Actions workflow will by default authenticate using a [GITHUB_TOKEN](https://docs.github.com/en/actions/security-guides/automatic-token-authentication) which is generated automatically.

However, at the time of writing, to sign commits the workflow will need to use a dedicated GitHub identity (in which to register the GPG public key).

The workflow would then use a Personal Access Token, stored with the GPG private key in the repo secrets, like so:
```
steps:
  - name: Checkout
    uses: actions/checkout@v3
    with:
      token: ${{ secrets.BOT_PAT }}
      ref: main
```
Example run action script excerpt:
```
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

<br>

## AWS CodePipeline

The cryptographic libraries in the default Amazon Linux 2 distro are very old, and do not support elliptic curve cryptography. When using pre-existing solution elements updating the build container is not always an option. This restricts the GPG key algorithm to RSA. You should use RSA-4096, which is the required minimum for GitHub.

Furthermore, the Systems Manager Parameter Store will not accept a key that is generated for both signing and encrypting (which will contain a second key for the encryption). It will be too large to be pasted in as a valid parameter. So when generating the GPG key you must select type RSA (sign only) if you intend to use Parameter Store rather than AWS Secrets Manager.

Example AWS CodeBuild Buildspec excerpt:
```
# Create SSH identity for connecting to GitHub 
BOT_SSH_KEY=$(aws ssm get-parameter --name "/keys/ssh-key" --query "Parameter.Value" --output text --with-decryption 2> /dev/null || echo "None")
if [[ ${BOT_SSH_KEY} != "None" ]]; then
  mkdir -p ~/.ssh
  echo "Host *" >> ~/.ssh/config
  echo "StrictHostKeyChecking yes" >> ~/.ssh/config
  echo "UserKnownHostsFile=~/.ssh/known_hosts" >> ~/.ssh/config
  echo "${BOT_SSH_KEY}" > ~/.ssh/ssh_key
  echo -e "\n\n" >>  ~/.ssh/ssh_key
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
git clone git@github.com:${GITHUB_ORG_NAME}/${SSO_CONFIG_REPO_NAME}.git

# Make git repository source code changes here

git add .
git commit ${GITHUB_SIGNING_OPTION} -am "Automated commit from ${SCRIPT_URL}"
git push
```

<br>

# Troubleshooting
Re-run your git command prefixed with GIT_TRACE=1

Usually it will fail because the name or email don't quite match up with the values use to generate the GPG key, so git cannot auto-select a key. However you are able to [force a choice of signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key).

