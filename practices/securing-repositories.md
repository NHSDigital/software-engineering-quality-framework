# Securing repositories

- [Securing repositories](#securing-repositories)
  - [Access controls](#access-controls)
    - [Organisation-level settings](#organisation-level-settings)
    - [Repository-specific settings](#repository-specific-settings)
    - [Teams setup](#teams-setup)
  - [Code security](#code-security)
    - [Branch protection](#branch-protection)
  - [Repository content](#repository-content)

In line with [NCSC guidance](https://www.ncsc.gov.uk/collection/developers-collection/principles/protect-your-code-repository) it is important to secure your code repository.

This guide describes our minimum set of requirements to secure & configure our code repositories, with specific guidance for GitHub-based repositories.

This minimum set of requirements should be implemented alongside other relevant guidance which contribute to [security](security.md) as a whole. Please also see [Quality Checks](../quality-checks.md).

## Access controls

### Organisation-level settings

- MFA must be enabled and enforced for all users.
- Baseline visibility for private repositories must be `No Permission`.
- Ability to change repository view from private to public must be reserved to admins only.

### Repository-specific settings

- In line with the [Service Manual](https://service-manual.nhs.uk/service-standard/12-make-new-source-code-open), new repositories should be public by default, unless there is good reason not to - this avoids costly rework to secure private information further down the line.
- Private repositories must disable forking.
- Outside collaborators must not be permitted in private repositories.
- Abuse reporting must be enabled by <!-- markdown-link-check-disable -->[accepting content reports](https://docs.github.com/en/communities/moderating-comments-and-conversations/managing-how-contributors-report-abuse-in-your-organizations-repository)<!-- markdown-link-check-enable -->
- In line with our [inclusive language guidance](../inclusive-language.md), the default branch must not be named "master" - we suggest "main" - please see our [inclusive language guidance](../inclusive-language.md) for how to rename the default branch.

### Teams setup

- GitHub teams must be created to provide individuals access to repositories. The minimum recommended setup is as follows:
  - Create a team for the repo (e.g. `Engineering Quality Framework`).
    - Add all required members to this team.
    - Set this team to have `Write` access (under the `Manage Access` option in `Settings`).
  - Create a child team, for admins only (e.g. `Engineering Quality Framework Admins`).
    - Add admins only to this team.
    - Set this team to have `Admin` access (under the `Manage Access` option in `Settings`).
  - Create a second child team, for code owners (e.g. `Engineering Quality Framework Code Owners`).
    - Add relevant members to this team: these are the individuals who will be permitted to approve pull request code reviews (please see Branch protection, below).
    - Use this team rather than individual accounts in the CODEOWNERS file (example [here](https://github.com/NHSDigital/software-engineering-quality-framework/blob/master/.github/CODEOWNERS)).
  - Child teams inherit the parent's access permissions, simplifying permissions management for large groups. Members of child teams also receive notifications when the parent team is `@mentioned`, simplifying communication with multiple groups of people.
  - Depending on your use case, you may want to create additional teams (e.g. a read-only access team).

## Code security

- [Dependabot](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/) alerts for vulnerabilities must be enabled and acted on appropriately.
- [SBOM (Software Bill of Materials)](../tools/dependency-scan/README.md) must be generated for your repository content and all the artefacts that are build as part of the CI/CD process.
- Refer to [Quality Checks](../quality-checks.md) for further code security practices.

### Branch protection

- Ability to push to the default branch must be disabled for everyone, including administrators (using the `applies-to-admin` option).
- Pull request <!-- markdown-link-check-disable -->[code reviews](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#require-pull-request-reviews-before-merging)<!-- markdown-link-check-enable --> must be required prior to merging a branch.
  - Code reviews must be approved by at least one code owner.
  - You may want to require multiple code owners to review pull requests.
- Commits must be <!-- markdown-link-check-disable -->[signed](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#require-signed-commits)<!-- markdown-link-check-enable --> and verified before merging.
  - Git treats authentication and identity separately - any authenticated user can impersonate another developer when committing code. This means that even if a junior account is compromised it could have significant consequences, for example impersonating the lead developer in the hope of an easy merge. Only by requiring signing can identity truly be verified.
  - For further details, please see [Setup Guides](guides/commit-signing.md) for macOS, Windows, GitHub Actions, and AWS CodePipeline.
- Existing reviews must be invalidated automatically when new commits are pushed (using the `fresh-commits-invalidate-existing-reviews` option).
- Merging must be blocked if the branch is not up to date.
- Consider any further automated status checks which should be enforced prior to merging a branch

## Repository content

- The following minimum set of files must be included in the repository, to support others to navigate the repository content:
  - README.md
  - CONTRIBUTING.md
  - LICENSE.md
  - .github/PULL_REQUEST_TEMPLATE.md
  - .github/SECURITY.md
- We recommend the use of a repository template, for example [NHS England Repository Template](https://github.com/nhs-england-tools/repository-template)
