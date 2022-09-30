Write-Host "[1/6] Cloning Git Secrets"
$installPath = $($Env:USERPROFILE + "\git-secrets-temp")
if (-not (Test-Path $installPath))
{
  git clone https://github.com/awslabs/git-secrets.git $installPath
}
else
{
  Write-Host "Git secrets already cloned"
}

Write-Host "`n[2/6] Installing Git Secrets"
Push-Location $installPath
& ".\install.ps1"
Pop-Location

Write-Host "`n[3/6] Adding Git Hooks"
git secrets --install

Write-Host "`n[4/6] Removing Temp Git Secrets Repo"
Remove-Item $installPath -Recurse -Force

Write-Host "`n[5/6] Adding Git Bash to PATH"
Write-Host "Checking if git bash already exists in path..."
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
$gitInstallDirectory = "C:\Program Files\Git\bin"
if ($currentPath -notlike "*$gitInstallDirectory*")
{
    Write-Host "Adding to path..."
    $newPath = $currentPath
    if (-not ($newPath.EndsWith(";")))
    {
        $newPath = $newPath + ";"
    }
    $newPath = $newPath + $gitInstallDirectory
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    Write-Host "Added to path"
}
else
{
    Write-Host "Already in Path"
}

Write-Host "`n[6/6] Updating Pre-Commit Hook"
$projectRoot = Split-Path -Path $PSScriptRoot -Parent
$preCommitHook = $projectRoot + '\.git\hooks\pre-commit'
(Get-Content $preCommitHook) | ForEach-Object { 
  if ($_.ReadCount -eq 2) { 
    $_ -replace '^.*$','./nhsd-git-secrets/pre-commit.sh' 
  } else { 
    $_ 
  } 
} | Set-Content $preCommitHook

Write-Host "`nGit Secrets Installation Complete"