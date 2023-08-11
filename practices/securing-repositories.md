# Securing repositories

- [Securing repositories](#securing-repositories)
  - [Prerequisites](#prerequisites)
  - [Access controls](#access-controls)
    - [Organisation-level settings](#organisation-level-settings)
    - [Repository-specific settings](#repository-specific-settings)
    - [Teams setup](#teams-setup)
  - [Code security](#code-security)
    - [Branch protection](#branch-protection)

This page lists requirements for securing code repositories. This guide includes specific configuration settings for GitHub, but  these requirements apply to all code repositories.

This set of practices is a minimum (nothing stops you from doing more), and they should be implemented alongside other relevant ones that contribute to [security](security.md) as a whole. These are discussed in more detail as part of the [Quality Checks](../quality-checks.md).

## Prerequisites

[Publishing Code](../quality-checks.md#publishing-code) within the Quality Checks page lists a minimum set of practices that should be in place before code is published. This implies that:

- Repositories can only be secure once the listed practices meet the relevant amber/green thresholds (which should also be reflected in a [Quality Dashboard](../insights/metrics.md)).
- The guidelines in this page are a necessary, but not a sufficient, condition for code overall being secure.

## Access controls

### Organisation-level settings

- All users must have MFA enabled.
- Baseline visibility for private repositories must be `No Permission`.
- Ability to change repository view from private to public must be reserved to admins only.

### Repository-specific settings

- In line with the [Service Manual](https://service-manual.nhs.uk/service-standard/12-make-new-source-code-open), new repositories should be public by default, unless there is good reason not to - this avoids costly rework to secure private information further down the line.
- Private repositories must disable forking.
- There must be no outside collaborators in private repositories.
- Enable abuse reporting by <!-- markdown-link-check-disable -->[accepting content reports](https://docs.github.com/en/communities/moderating-comments-and-conversations/managing-how-contributors-report-abuse-in-your-organizations-repository)<!-- markdown-link-check-enable -->

### Teams setup

Because of baseline visibility configurations, you must setup GitHub teams in order to provide team members access to repositories. The minimum recommended setup is as follows:

- Create one team with the name of your programme (e.g. `Engineering Quality Framework`). Add all required members to this team.
- Create one child team within the team, for admins only (e.g. `Engineering Quality Framework Admins`). Add admins only to this team.
- Create a second child team, for code owners (e.g. `Engineering Quality Framework Code Owners`). Add relevant members to this team, and reference in the CODEOWNERS file (example [here](https://github.com/NHSDigital/software-engineering-quality-framework/blob/master/.github/CODEOWNERS)).
- For each repo in your programme (e.g. `software-engineering-quality-framework`), under the `Manage Access` option in `Settings`, set the general team to have `Write` access and the admins team to have `Admin` access.

Child teams inherit the parent's access permissions, simplifying permissions management for large groups. Members of child teams also receive notifications when the parent team is `@mentioned`, simplifying communication with multiple groups of people.

Depending on your use case, you may want to create additional teams (e.g. a read-only access team, or different teams granting access to different projects). This is welcomed by the framework, as long as the teams provide clarity on the role they encompass, remain consistent and are applied consistently to your repositories.

## Code security

- Enable, at a minimum, [Dependabot](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/) alerts for vulnerabilities and respond to them appropriately.
- Generate [SBOM (Software Bill of Materials)](../tools/dependency-scan/README.md) for your repository content and all the artefacts that are build as part of the CI/CD process
- Disable ability to push to the default branch for everyone, admins included (`applies-to-admin` option).
- Refer to [Quality Checks](../quality-checks.md) for further code security practices.

### Branch protection

- Require <!-- markdown-link-check-disable -->[pull request code reviews](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#require-pull-request-reviews-before-merging)<!-- markdown-link-check-enable -->, by at least one code owner, to merge a branch.
- Require <!-- markdown-link-check-disable -->[signed commits](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#require-signed-commits)<!-- markdown-link-check-enable -->, and, accordingly, check that commits are verified before merging. Git treats authentication and identity separately - any authenticated user can impersonate another developer when committing code. This means that even if a junior account is compromised it could have significant consequences, for example impersonating the lead developer in the hope of an easy merge. Only by requiring signing can identity truly be verified. [Setup Guides](guides/commit-signing.md) for macOS, Windows, GitHub Actions, and AWS CodePipeline.
- Invalidate existing reviews when new commits are pushed (`fresh-commits-invalidate-existing-reviews` option).
- Require adequate automated status checks prior to merging. This should always include checking that branches are up to date.
