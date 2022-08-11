# Continuous Integration

- [Continuous Integration](#continuous-integration)
  - [Context](#context)
  - [Details](#details)
    - [Avoid collisions](#avoid-collisions)
    - [Use IDE integration for instant feedback](#use-ide-integration-for-instant-feedback)
    - [Everything as code](#everything-as-code)
    - [Deploy what you tested](#deploy-what-you-tested)
    - [Automate quality gates](#automate-quality-gates)
    - [Quick build](#quick-build)
    - [Flexible pipelines](#flexible-pipelines)
    - [Address build failures immediately](#address-build-failures-immediately)
    - [Make failures clear and concise](#make-failures-clear-and-concise)
    - [Favour fix-forward](#favour-fix-forward)
    - [Run pipelines regularly](#run-pipelines-regularly)
  - [Pipeline Healthcheck](#pipeline-healthcheck)
    - [Features](#features)
    - [Pipeline steps](#pipeline-steps)
    - [Deployments](#deployments)
    - [Runtime quality](#runtime-quality)
  - [Further reading and resources](#further-reading-and-resources)

## Context

These notes are part of a broader set of [principles](../principles.md). See also [automate everything](../patterns/automate-everything.md) and [test automation](testing.md).

## Details

### Avoid collisions

Changes (application and infrastructure) should be independent of other concurrent changes so that any release can safely be taken at any time.

### Use IDE integration for instant feedback

Code linting, static analysis, unit testing, security scanning, etc. can all be triggered locally as a githook - giving instant feedback, without having to wait for a pipeline build.

### Everything as code

Pipelines should be written as code, see the "[everything as code](../patterns/everything-as-code.md)" pattern.

### Deploy what you tested

Never rebuild a deployment artefact for final release.

### Automate quality gates

Quick-running, reliable automate tests allow you to refactor. Use that reduction in risk to regularly refactor and improve code. Quality gates (such as [tests](testing.md)) should be applied and evidenced by the build pipeline, not via manual processes.

### Quick build

Your build pipeline should run fast; a good default is under 10 minutes. Use techniques such as parallelisation and caching (Maven, Docker, etc) to improve build speeds. (See [fast feedback](../patterns/fast-feedback.md).)

### Flexible pipelines

Prefer short and wide pipelines (LINK) rather than long-running sequential pipelines. This enables the team to choose the shortest responsible path to done. Through this mechanism, the team can optionally incorporate long-running checks and tests (e.g. Soak/Stress testing) into builds and deployments.

### Address build failures immediately

False and/or intermittent failures will reduce the confidence that the team have in the pipeline, leading to wasted investigation effort, and wasteful "safety net" processes on top.

### Make failures clear and concise

Build failures should be easily available, clear and concise. Consider chat notifications from your build tools, rather than emails. Invest time in reducing unnecessary noise in the build output, and add logging to your builds to enable easy analysis of failures.

### Favour fix-forward

Avoid "roll-back scripts" in favour of being able to quickly build and deploy a fix. Phased Blue-Green (LINK) / Canary (LINK) / etc. deployments should be used where appropriate, to reduce high-risk deployments.

### Run pipelines regularly

Even if *you* have not made any changes there may have been changes to shared code, infrastructure patches, dependencies, etc. It's vital to stay up to date, and to discover any issues as soon as possible.

## Pipeline Healthcheck

A basic checklist of things to include in CI/CD. NB: This is not exhaustive, and there is no right answers, every service is different. This list is intended to get teams thinking about how to improve their build and deploy pipelines.

### Features

| Features                      | Things to consider                                                                                                                                                                                                                                                      |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Fully automated               | Is your build pipeline fully automated?                                                                                                                                                                                                                                 |
| Infrastructure                | Is your infrastructure (databases, security groups, etc.) deployed through a pipeline as well as the application? Is that fully automated by a Jenkins job?                                                                                                             |
| Written as code               | Is your pipeline written as code, or are there manual steps involved? Are there unit tests in that deployment code?                                                                                                                                                     |
| Run locally                   | Can your pipeline build be run locally?                                                                                                                                                                                                                                 |
| Parallel steps                | Do you run build steps in parallel? This can greatly improve build times                                                                                                                                                                                                |
| Quick build                   | Do your feature branch builds complete in under 10 minutes? i.e. is your team frequently sat around waiting for builds to finish?                                                                                                                                       |
| IDE integration               | Do you utilise IDE integrations for instant feedback?  e.g. Lints, Sonarqube, JaCoCo, Neoload, Unit Tests, etc. can all be triggered locally - giving instant feedback, without having to wait for a Jenkins build                                                      |
| Full build                    | Do you have a full/overnight build that runs everything? How do you manage any failures from that?                                                                                                                                                                      |
| Failure rate                  | Are your builds reliable, or do you get a high rate of false failures?                                                                                                                                                                                                  |
| Result publishing             | Are the results from your build (success/error/warn) clear and concise?  Can you always tell exactly what caused a build to fail? Do you get spammed with unnecessary emails? Do you use slack/etc. for build alerting? Are there manual steps that could be automated? |
| Effectiveness and Maintenance | Despite having a robust build pipeline, are you still seeing high bug/error/security/etc. rates in production? Are you spending too much team effort on maintaining your pipelines? Are they too complex without delivering benefits?                                   |

### Pipeline steps

| Pipeline steps           | Things to consider                                                                                                                                                                                                                                                                                                                                                                           |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Automated code tests     | Unit, Integration, etc. ("developer" tests). Do you have your tests at the right level for your system? e.g. a pyramid shape - see below                                                                                                                                                                                                                                                     |
| Acceptance tests         | Is your acceptance/regression pack fully automated as part of your pipeline? Do you have areas that are currently manually tested but could be fully, or partly, automated? Do you consider your low and high-level tests as a whole, to avoid repetition (i.e. pyramid shaped)? Do you have the tooling you require? Can tests be developed and run locally, as well as part of a pipeline? |
| Soak tests               | Do you know how long your application can run without breaking? How often do you repeat these tests? Are they fully automated? Do you have the tools to automate this?                                                                                                                                                                                                                       |
| Stress tests             | Have you tested to see where your application's bottleneck is? How often do you repeat these tests? Are they fully automated? Do you have the tools to automate this?                                                                                                                                                                                                                        |
| Load tests               | Do you frequently check that your application can cope with as-live load? Do you know how much increased load you can handle? Are these tests fully automated as part of your pipeline? How often do you repeat these tests? Do you have the tools to automate this?                                                                                                                         |
| Common bug detection     | Do you perform static code analysis to look for common coding problems? Do you also check your CSS, HTML, JSON, YAML, BASH, SQL, etc. as well as your main language? What automated tools do you use? Does the tooling integrate directly into your IDE for instant feedback? Are the results presented in such a way that acting on them is clear to you?                                   |
| Dead code detection      | Do you perform static code analysis to look for dead code? What automated tools do you use? Does the tooling integrate directly into your IDE for instant feedback?                                                                                                                                                                                                                          |
| Complexity score         | Do you perform static code analysis to look at function/file complexity? What automated tools do you use? Does the tooling integrate directly into your IDE for instant feedback? Are the results presented in such a way that acting on them is clear to you?                                                                                                                               |
| Security vulnerabilities | Do you scan for security vulnerabilities in your code? What automated tools do you use? Does the tooling integrate directly into your IDE for instant feedback? Are the results presented in such a way that acting on them is clear to you?                                                                                                                                                 |
| UI Accessibility testing | Do you check for accessibility issues? Are these fully automated as part of your pipeline? What automated tools do you use? Does the tooling integrate directly into your IDE for instant feedback?                                                                                                                                                                                          |
| HTML compliance          | Do you check your UI code for HTML compliance? Are these fully automated as part of your pipeline? What automated tools do you use? Does the tooling integrate directly into your IDE for instant feedback?                                                                                                                                                                                  |
| FHIR compliance          | Do you check your FHIR APIs for FHIR compliance? Are these fully automated as part of your pipeline? What automated tools do you use? Does the tooling integrate directly into your IDE for instant feedback?                                                                                                                                                                                |
| Tech radar check         | Have your frameworks and technologies been deprecated by NHSD? Do you currently check your application against the NHSD Tech Radar? If so, how? Does the tooling integrate directly into your IDE for instant feedback?                                                                                                                                                                      |
| Browser compatibility    | Does your build include automated checks for supported browsers? Does the tooling integrate directly into your IDE for instant feedback?                                                                                                                                                                                                                                                     |

### Deployments

| Deployments         | Things to consider                                                                                                                                                                                                                                   |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Deployment pipeline | Do you have a separate deployment pipeline?                                                                                                                                                                                                          |
| Tested              | Are you deploying exactly what you tested? Even with a baked Docker image, think about your use of ":latest" base images, or "apt update" calls                                                                                                      |
| Fully automated     | Is your deployment fully automated? Including route53, microservice discovery, etc. Are there manual waits while you check/test things? Could these be automated into a long-lived pipeline? How do you manage service versions between deployments? |
| Phased              | Is your rollout phased (blue/green, canary, etc)?                                                                                                                                                                                                    |

### Runtime quality

| Runtime quality          | Things to consider                                                              |
| ------------------------ | ------------------------------------------------------------------------------- |
| Security vulnerabilities | Do you have ongoing security vulnerability scanning. Do you act on the results? |
| Tech radar check         | Do you regularly re-check your deployed application against the Tech Radar?     |

## Further reading and resources

- [Continuous Integration](https://martinfowler.com/articles/continuousIntegration.html)
- [Patterns for Managing Source Code Branches](https://martinfowler.com/articles/branching-patterns.html)
