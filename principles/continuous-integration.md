# Continuous Integration

## Context

* These notes are part of a broader set of [principles](../principles.md)
* TO DO: Further reading / training courses about test automation
* TO DO: Reference to the Automation Working Group (link to terms of reference?)
* See also:
    * [Automation](automation.md)
    * [Test automation](test-automation.md)

## Principles

* Feedback loop on simple changes must be within 10 minutes (i.e. a continuous integration build process must complete within 10 minutes)
* Application changes should be independent of other concurrent changes (i.e. releases can safely be taken at any time)
* Quality gates should be applied and evidenced by the build pipeline (not via manual processes)
* Prefer short and wide pipelines rather than long running sequential pipelines, so that the team can choose the shortest responsible path to done
* TO DO: Notes on expected coverage & CI strategies (e.g. load & performance testing, security testing, dependency scanning, scanning for secrets, accessibility testing, etc, etc)
