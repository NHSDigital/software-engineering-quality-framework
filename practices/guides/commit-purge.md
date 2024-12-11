# Guidance for removing sensitive data from GitHub

## Overview

There are multiple steps required to ensure sensitive data committed to a GitHub hosted Git repository is fully removed. 

Engineering teams must take all necessary precautions to ensure that sensitive data does not leak into Source Control Management Systems. This includes secrets being pushed to a remote branch, as well as merging into the default branch. Teams must consider **any** secret posted to a branch of a public repository as compromised and must take necessary steps to revoke and rotate this secret. For Private and Internal repositories teams must still treat leaked credentials as compromised and revoke and rotate them. 

Teams must also review their Near Miss reporting requirements and ensure that necessary steps are taken. 

Teams must ensure that a [Secret scanner](https://github.com/NHSDigital/software-engineering-quality-framework/tree/main/tools/nhsd-git-secrets) is enabled on their repositories. 

Teams must also ensure that developers follow standard processes to ensure any pre-commit hooks are enabled and enforced to reduce the risk of sensitive information being accidentally published. Teams should also contribute to the rule set for these tools to ensure secrets are identified correctly.

If a secret or other sensitive information is identified as having been pushed to a remote repository in GitHub then the following steps ***must*** be undertaken to ensure removal of the information. Please note that just removing the data from the git history is **not** sufficient as views can be cached by the UI.

### Remediation Steps

1. Rotate the secrets that have been revealed – whether the repository is public or private this is a key step in reducing the risk of any accidental publishing of secrets.
2. A security incident **must** be raised for all sensitive date committed. This ensures that our Cyber teams can support in assessing the level of risk of the exposure. Contributors must raise an incident following your internal processes.
3. Undertake steps to [remove the sensitive data from your Git history](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository#purging-a-file-from-your-repositorys-history).
4. Once the history has been cleansed we need to request that GitHub purge their cache – please [raise a request](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository#fully-removing-the-data-from-github) with the internal Github admins mailbox.
