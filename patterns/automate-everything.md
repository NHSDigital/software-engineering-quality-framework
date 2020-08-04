# Continuous assurance

## Context

* These notes are part of a broader set of [principles](../principles.md)
* See also:
    * [Continuous integration](../practices/continuous-integration.md)
    * [Testing](../practices/testing.md)

## The pattern

* **Automate everything**
  Regularly review *every* manual process that the team performs. Automate it, but be pragmatic: choose where to invest your time. Error-prone, high impact and frequent activities are all high priorities for automation.
  For example:
    * Interactions with change management process / tools
    * Interactions with architecture repository process / tools
    * Process to rebuild a developer laptop
    * Stress testing / Soak testing
    * Manually telling someone that the build is ready for testing / ready for a review
    * Manually updating a release log

* **Continuous checking**
  After deployment, do not stop checking and testing.
  For example:
    * Scan live deployments for new security vulnerabilities
    * Regularly run automated test packs against production
    * Scan for deprecated technologies in real-time

* Shift-left with [compliance-as-code](https://aws.amazon.com/products/management-tools/).
  * Automated [tests](testing.md).
  * Automated [security](security.md) verification.
  * Automated governance, e.g. using AWS Control Tower, AWS Organisations, AWS Service Catalog, AWS Config, AWS CloudTrail.
