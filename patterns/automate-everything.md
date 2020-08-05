# Continuous assurance

## Context

* These notes are part of a broader set of [principles](../principles.md)
* See also:
    * [Continuous integration](../practices/continuous-integration.md)
    * [Testing](../practices/testing.md)

## The pattern

Regularly review *every* manual process that the team performs. Automate it, but be pragmatic: choose where to invest your time. Error-prone, high impact and frequent activities are all high priorities for automation.

## Benefits

TO DO

## Examples &mdash; what to automate

* Process to rebuild a developer laptop
* Stress testing / Soak testing
* Manually telling someone that the build is ready for testing / ready for a review
* Manually updating a release log
* Automated [tests](testing.md).
* Automated [security](security.md) verification.
* Automated [governance](governance-side-effect.md).

## Examples &mdash; how to automate

TO DO: runners (e.g. bash, Python) and orchestrators (CI tools, step functions); event driven (human and monitoring) vs scheduled