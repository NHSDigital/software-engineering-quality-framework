# Securing repositories

This guide lays out security best practice for Github repositories, building on other policies such as [Coding in the Open](https://aalto.digital.nhs.uk/#/document/viewer/41a587a6-8266-46b4-860c-f41a906648b9?resetBreadcrumbPath=false&library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0). Github is the default tool for code repositories, and should generally be used unless there is good reason otherwise. 

This set of practices is a minimum (nothing stops you from doing more), and they should be implemented alongside other relevant ones that contribute to [security](security.md) as a whole. These are discussed in more detail as part of the [Quality Checks](../quality-checks.md).

## Prerequisites
[Publishing Code](../quality-checks.md#publishing-code) within the Quality Checks page lists a minimum set of practices that should be in place before code is published. This implies that:
* Repositories can only be secure once the listed practices meet the relevant amber/green thresholds (which should also be reflected in a [Quality Dashboard](../insights/metrics.md)).
* The guidelines in this page are a necessary, but not a sufficient, condition for code overall being secure.

## Access controls
* All users should have MFA enabled. *Note*: as we consider moving to Github Enterprise, this may be automated by way of authentication via short code.
* In line with the [Service Manual](https://service-manual.nhs.uk/service-standard/12-make-new-source-code-open), all new repositories should be public by default, unless there is good reason not to - this avoids costly rework to secure private information further down the line.
* Private repositories should disable forking.
* There should be no outside collaborators in private repositories.
* Ability to change repository view from private to public should be reserved to admins only. *Note*: this will be routinely enforced at the organisation level.

## Code security
* Enable, at a minimum, [Dependabot](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/) alerts for vulnerabilities and respond to them appropriately.
* Disable ability to push to master for everyone, admins included (`applies-to-admin` option)
* Refer to [Quality Checks](../quality-checks.md) for further code security practices.

### Branch protection
* Require pull request code reviews to merge a branch.
  * Choose reviewers wisely - avoid bottlenecks and single points of failure, but ensure meaningful feedback can be provided.
* Invalidate existing reviews when new commits are pushed (`fresh-commits-invalidate-existing-reviews` option).
* Require adequate automated status checks prior to merging. This should always include checking branches are up to date.
