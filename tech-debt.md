# Technical debt

## Context

* This is part of a broader [quality framework](README.md)

## Overview

"Technical debt" is a term which refers to undesirable things about the way a system is built which are not apparent to users of the system, but impact the ability of the team to make changes to it quickly and safely. Tech debt arises due to processes or practices in the past, but has an ongoing impact on the present, in that it:

* Leads to bugs and loss of reliability
* Means changes take longer to develop, and makes it harder to predict how long the work will take
* Causes dissatisfaction and disengagement in the delivery team

There are many different views on what is and isn't tech debt - this is ours.

## Purpose

This definition is important because an understanding of technical debt supports teams to make prioritisation decisions such that systems will remain safe.

Teams must record technical debt in their backlog, and they must actively manage the risks associated with that debt.

## Definition

We define tech debt as: the negative results of design & implementation decisions, and how those decisions age over time if they aren’t incrementally adjusted or improved

* This includes technical decisions that are made for short-term benefit (e.g. delivery time or cost) that will slow you down or increase your costs / risks over time
* This also includes technical decisions that were appropriate at the time, but better options exist now (e.g. new technologies that weren't available at the time)

Note: it includes working practices as well as the software: the scope includes anything that's not in line with the contents of this [quality framework](README.md)

### Examples of what it IS

Here is a non-exhaustive list of examples we consider to be *in* scope of "technical debt":

* Unknown / poor code hygiene and lack of coding standards
* Unknown / poor [resilience test-automation](practices/service-reliability.md)
* Unknown / poor [security test-automation](practices/security.md)
* Unknown / poor accessibility test-automation
* Use of technologies not endorsed by the organisation
* Code you no longer need ([e.g. a new managed service is available](patterns/outsource-bottom-up.md))
* Technologies no longer needed (e.g. you've introduced something better than what you used before)
* CI issues, e.g. lack of [fast feedback](patterns/fast-feedback.md), or intermittent [build failures](practices/continuous-integration.md)
* [Code-repository configuration issues](practices/security-repository.md), e.g. lack of branch protection rules
* Manual processes that could be [automated](patterns/automate-everything.md)
* Software components with inappropriate / confused [domain boundaries](patterns/architect-for-flow.md)
* Use of obsolete / unsupported technologies
* Self-run tooling where a [SaaS offering](patterns/outsource-bottom-up.md) exists, e.g. sonarqube vs sonarcloud

### Examples of what it ISN'T

Here is a non-exhaustive list of examples we consider to be *out of* scope of "technical debt":

* "Architectural debt", for example:
  * A business capability within a product that doesn't need to exist within that product, because a dedicated / strategic service is now available to perform the same function
  * Use of no-longer-preferred architectural patterns, e.g. monolith pattern
* "Functional debt", for example:
  * Bugs
  * New features that haven't been built yet
* Operational issues within the delivery & operational teams, for example:
  * Poor communication channels from/to end users, between operational teams, or within teams
  * Silos of knowledge / single points of failure within the team
  * Poorly understood team responsibilities
  * Poorly aligned contracts / organisation-level-agreements across suppliers / teams

## Instrumentation

The collection of tech debt should be fully automated. Some aspects of the above "in scope" list are much easier to collect than others - many of the above are reflected in [metrics](insights/metrics.md).

TO DO: further details around instrumentation
