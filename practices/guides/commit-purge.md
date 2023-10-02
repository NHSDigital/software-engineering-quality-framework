# Guidance for removing sensitive data from GitHub

## Overview

Engineering teams should take all necessary precautions to ensure that sensitive data does not leak into Source Control Management Systems. This includes secrets being pushed to a remote branch, as well as merging into the default branch. Teams should consider **any** secret posted to a branch of a public repository as compromised and should take necessary steps to revoke and rotate this secret. For Private and Internal repositories teams should still treat leaked credentials as compromised and revoke and rotate them. Teams should also review their Near Miss reporting requirements and ensure that necessary steps are taken. Teams should ensure that a [Secret scanner](https://github.com/NHSDigital/software-engineering-quality-framework/tree/main/tools/nhsd-git-secrets) is enabled on their repositories. Teams must also ensure that developers follow standard processes to ensure any pre-commit hooks are enabled and enforced to reduce the risk of sensitive information being accidentally published. Teams should also contribute to the rule set for these tools as appropriate to ensure secrets are identified correctly.

If a secret or other sensitive information is identified as having been pushed to a remote repository in GitHub then the following steps ***must*** be undertaken to ensure removal of the information. Please note that just removing the data from the git history is **not** sufficient as views can be cached by the UI.

1. Rotate the secrets that have been revealed – whether the repository is public or private this should be a key step in reducing the risk of any accidental publishing of secrets.
2. Consider whether an incident should be raised, for example has sensitive information been shared in a public repository. If in doubt raise an incident.
3. Undertake steps to [remove the sensitive data from your Git history](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository#purging-a-file-from-your-repositorys-history).
4. Once the history has been cleansed we need to request that GitHub purge their cache – please [raise a request](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository#fully-removing-the-data-from-github) with the internal Github admins mailbox.
