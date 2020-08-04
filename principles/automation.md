# Automation

## Context

* These notes are part of a broader set of [principles](../principles.md)
* Useful reading: [Google's view of toil](https://landing.google.com/sre/sre-book/chapters/eliminating-toil/)
* See also:
    * [Continuous integration](continuous-integration.md)
    * [Test automation](test-automation.md)

## Principles

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
