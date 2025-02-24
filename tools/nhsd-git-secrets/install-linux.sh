#!/bin/bash
echo "[1/5] Cloning Git Secrets"
installPath="$HOME/git-secrets-temp"
if [ -d "$installPath" ];
then
  echo "Git secrets already cloned"
else
  git clone https://github.com/awslabs/git-secrets.git $installPath
fi

echo "" && echo "[2/5] Installing Git Secrets and Adding to PATH"
pushd $installPath
make install PREFIX="$HOME/git-secrets"
echo 'export PATH="$HOME/git-secrets/bin":$PATH' >> ~/.bashrc
source ~/.bashrc
popd

echo "" && echo "[3/5] Adding Git Hooks"
git-secrets --install -f

echo "" && echo "[4/5] Removing Temp Git Secrets Repo"
rm -rf $installPath

echo "" && echo "[5/5] Updating Pre-Commit Hook"
projectRoot=$(dirname $PWD)
preCommitHook="$projectRoot/.git/hooks/pre-commit"
hookScript="nhsd-git-secrets/pre-commit.sh"
replaceString='git secrets --pre_commit_hook -- "$@"'
sed -i -e "s,$replaceString,./$hookScript," "$preCommitHook"
chmod +x "$projectRoot/$hookScript"

echo "" && echo "Git Secrets Installation Complete"
