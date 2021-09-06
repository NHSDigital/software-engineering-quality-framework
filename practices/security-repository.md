# Securing repositories

This guide lays out security best practice for Github repositories. Github is the default tool for code repositories, and should generally be used unless there is good reason otherwise. 

This set of practices is a minimum (nothing stops you from doing more), and they should be implemented alongside other relevant ones that contribute to [security](security.md) as a whole. These are discussed in more detail as part of the [Quality Checks](../quality-checks.md).

## Access controls
* All users should have MFA enabled. *Note*: as we consider moving to Github Enterprise, this may be automated by way of authentication via short code.
* In line with the [Service Manual](https://service-manual.nhs.uk/service-standard/12-make-new-source-code-open), all new repositories should be public - this avoids costly rework to secure private information further down the line.
* Private repositories should disable forking.
* There should be no outside collaborators in private repositories.
* Ability to change repository view from private to public should be reserved to admins only. *Note*: this will be routinely enforced at the organisation level.

## Code security
* Enable, at a minimum, [Dependabot](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/) alerts for vulnerabilities and respond to them appropriately.
* Disable ability to push to master.
* Refer to [Quality Checks](../quality-checks.md) for further code security practices.

### Branch protection
* Require pull request code reviews to merge a branch.
* Require adequate automated status checks prior to merging.
