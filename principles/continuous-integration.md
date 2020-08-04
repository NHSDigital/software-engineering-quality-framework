# Continuous Integration

## Context

* These notes are part of a broader set of [principles](../principles.md)
* TO DO: Further reading / training courses about test automation
  * https://martinfowler.com/articles/continuousIntegration.html
* TO DO: Reference to the Automation Working Group (link to terms of reference?)
* TO DO: Notes on expected coverage & CI strategies (e.g. load & performance testing, security testing, dependency scanning, scanning for secrets, accessibility testing, etc, etc)
  merge parts of [https://nhsd-confluence.digital.nhs.uk/display/DE/Pipeline+Healthcheck]

* See also:
    * [Continuous assurance](continuous-assurance.md)
    * [Testing](testing.md)

## Principles

* **Avoid collisions**
  Changes (application and infrastructure) should be independent of other concurrent changes (i.e. any release can safely be taken at any time)

* **Use IDE integration for instant feedback**
  Lints, SonarQube, Unit Tests, Security scanning, etc. can all be triggered locally - giving instant feedback, without having to wait for a pipeline build.

* **Everything as code**
  Pipelines should be written as code, and treated like code: source controlled, code reviewed, refactored, unit tested, etc.

* **Deploy what you tested**
  Never rebuild a deployment artefact for final release.

* **Quick build**
  Feedback loop on simple changes should fast. A good default is to say a continuous integration build process should complete within 10 minutes. Use techniques such as parallelisation and caching (Maven, Docker, etc) to improve build speeds.

* **Flexible pipelines**
  Prefer short and wide pipelines (LINK) rather than long-running sequential pipelines. This enables the team to choose the shortest responsible path to done.
  Through this mechanism, the team can optionally incorporate long-running checks and tests (e.g. Soak/Stress testing) into builds and deployments.

* **Address build failures immediately**
  False / Intermittant failures will reduce the confidence that the team have in the pipeline, leading to wasted investigation effort, and wasteful "safety net" processes on top.

* **Make failures clear and concise**
  Build failures should be easily available, clear and concise. Consider chat notifications from your build tools, rather than emails. Invest time in reducing unnecessary noise in the build output, and add logging to your builds to enable easy analysis of failures.

* ***Replace* manual testing with automated testing**
  Aim for the traditional pyramid structure (LINK). Don't automate and then continue the same amount of manual testing on top!

* ***Trust* your automated tests**
  Quick-running, reliable automate tests allow you to refactor.  Use that reduction in risk to regularly refactor and improve code.

* **Automate quality gates**
  Quality gates should be applied and evidenced by the build pipeline (not via manual processes)

* **Favour fix-forward**
  Avoid "roll-back scripts" in favour of being able to quickly build and deploy a fix.
  Phased Blue-Green (LINK) / Canary (LINK) / etc. deployments should be used where appropriate, to reduce high-risk deployments.

* **Run pipelines regularly**
  Even if *you* haven't made any changes! There may have been changes to shared code, infrastructure patches, dependencies, etc. It's vital to stay up to date, and to discover any issues as soon as possible.

