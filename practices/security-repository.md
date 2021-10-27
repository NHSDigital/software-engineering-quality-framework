# Securing repositories

This guide lays out security best practice for Github repositories. This set of practices is a minimum (nothing stops you from doing more), and they should be implemented alongside other relevant ones that contribute to [security](security.md) as a whole. These are discussed in more detail as part of the [Quality Checks](../quality-checks.md).

## Prerequisites
[Publishing Code](../quality-checks.md#publishing-code) within the Quality Checks page lists a minimum set of practices that should be in place before code is published. This implies that:
* Repositories can only be secure once the listed practices meet the relevant amber/green thresholds (which should also be reflected in a [Quality Dashboard](../insights/metrics.md)).
* The guidelines in this page are a necessary, but not a sufficient, condition for code overall being secure.

## Access controls
### Organisation-level settings
* All users must have MFA enabled.
* Baseline visibility for private repositories must be no permissions.
* Ability to change repository view from private to public must be reserved to admins only.

### Repository-specific settings
* In line with the [Service Manual](https://service-manual.nhs.uk/service-standard/12-make-new-source-code-open), new repositories should be public by default, unless there is good reason not to - this avoids costly rework to secure private information further down the line.
* Private repositories must disable forking.
* There must be no outside collaborators in private repositories.

## Code security
* Enable, at a minimum, [Dependabot](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/) alerts for vulnerabilities and respond to them appropriately.
* Disable ability to push to the default branch for everyone, admins included (`applies-to-admin` option).
* Refer to [Quality Checks](../quality-checks.md) for further code security practices.

### Branch protection
* Require [pull request code reviews](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#require-pull-request-reviews-before-merging), by at least one code owner, to merge a branch.
* Require [signed commits](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#require-signed-commits), and, accordingly, check that commits are verified before merging.
* Invalidate existing reviews when new commits are pushed (`fresh-commits-invalidate-existing-reviews` option).
* Require adequate automated status checks prior to merging. This should always include checking that branches are up to date.
