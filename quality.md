# Quantitative metrics
| Measure | Definition (each calculated over the last 28 days) |
|:---|:---|
| Deployment frequency | Number of deployments
| Lead time | Median time between an item being started to when it is done.
| Change failure rate | Percentage of deployments which result in an incident.
| Overall incident rate: P1 | Total number of piority 1 incidents which occurred.
| Mean time to restore service: P1 | Mean time from priority 1 incident starting to when it is resolved.
| Overall incident rate: P1 | Total number of piority 1 incidents which occurred.
| Mean time to restore service: P2 | Mean time from priority 2 incident starting to when it is resolved.
| Overall incident rate: P3 | Total number of piority 3 incidents which occurred.
| Mean time to restore service: P3 | Mean time from priority 3 incident starting to when it is resolved.

# Team

## Mission
* We have a clear mission that we share with all stakeholders.
* We understand what is important to our customers and validate our thinking regularly.

## Plan
* Our plan guides us.
* It makes sure we work on the right things first and helps us predict and avoid issues.
* Risky items are clearly indicated and work to reduce risk is prioritised.
* The plan gets the right balance between delivering features and operational aspects.

## Fast, reliable and safe delivery
* We work rapidly together.
* Our process helps us deliver high quality work quickly.
* Our daily stand up keeps us aligned and working well as a team.
  * It helps us share and resolve impediments.
* Our regular planning sessions are efficient and effective.
* We use short-lived feature branches off master.
  * Tests must pass before code is merged.
* We can see when the build has broken or tests are failing and fix them before we carry on.
* Our definition of "done" is ready to deploy to production.
* We explicitly limit work in progress (WIP).
* Our lead time is typically two days or less.
  * (Lead time = time from picking an item up to it being done.)
* The onboarding process for new team members is simple and straightforward.

## Fun
* The team is a fun place to be every day.
* We have great team spirit and help each other out.
* We give each other honest feedback.
* We learn something every day.
* We look forward to our retrospectives and they drive valuable improvements.

## Pawns or players
* We are in control of our destiny!
* We decide what to build and how to build it.

## Outside support
* We always get great support and help when we ask for it!
* We are listened to and our ideas are used to improve the organisation.

# Individual component or system
You may wish to score each individual component or system separately for these aspects.
> Identify components based on natural seams in the system. Ultimately, the aim is to make it easy to decide what the appropriate score is for each "component". If you can"t decide between a low and high score for an aspect then this may indicate that component should be broken down to allow finer grained scoring.
>
> Example components:
> * React web UI
> * Individual APIs or services
> * The cloud platform
> * The CI/CD system

## Tech and architecture
* The tech helps us deliver value.
* We enjoy working with it.
* The architecture is clean.
* The tech and architecture make delivery and live operations easy and enjoyable.

## Healthy code base
* We're proud of the quality of our code!
* It is clean, easy to read, and has great test coverage.

## Testing
* We have great test coverage.
* Testing is everyone's responsibility.
* The time we spend on testing is really worthwhile.
* We use the right mixture of tools and techniques, e.g.
  * code level unit and integration tests, and maybe behaviour-driven development
  * running system component, integration and whole-system tests
* Our tests focus on individual components and the contracts between them, not on testing the whole system together.
* We use stubs to insulate our tests from other components and systems.
* Our components have versioned APIs.
* Breaking changes are detected and clearly indicated.
  * e.g. using Consumer-Driven Contract testing and semantic versioning.
* We understand user needs and non-functional requirements and our tests prove they are being met.
    * e.g. accessibility, browser compatibility, performance, capacity, resilience.
* Test data is automatically generated and has the right properties and scale.

## Easy to release
* It is easy and straightforward to release a change to production.
* We can release on demand, typically multiple times per day.
* Every code merge triggers the creation of a potentially releasable build artifact.
  * That same artifact is deployed to each environment (e.g. dev, test, prod) rather than a new build being done for each.
* We can deploy any recent version.
* Our deployments are automated, including everything needed to build an environment from scratch.
* Our test and production environments are all in a known state,including configuration parameters.
* We can see what is currently deployed in each environment, including configuration and feature flags, and can see the history of changes.
* We use blue-green/canary deployments to safely verify each deployment before fully switching over to the new version.

## Operations
* We consider operations from day one and design the system to be easy to operate.
* We include operability features throughout delivery, treating them as user needs of the support team.
  * e.g. monitoring and log aggregation.
* Our systems are reliable.
* We have great insight into how live systems are functioning.
* e.g. metrics dashboards, request tracing and application logs.
* We detect potential issues and take action to prevent them.
  * e.g. TLS certificate expiry, hitting quota limits.
* We detect incidents before our users tell us about them and have a slick process for resolving them.
* We classify incidents and work to agreed protocols according to the Service Level Agreement (SLA) for each.
* We learn from incidents using blameless postmortems.
* We use Service Level Objectives (SLOs) and error budgets to balance speed of change with operational reliability.

## Security and compliance
* We are confident our systems are secure.
* We model threats and design systems to be secure.
* Security is baked into our software delivery process.
  * e.g. in analysis, coding and testing.
* We understand typical vulnerabilities and how to guard against them
  * e.g. OWASP Top Ten.
* We understand the sensitivity of the data we process and handle it accordingly.
* We know which regulations apply, and ensure we meet their requirements.
  * e.g. GDPR, PCI, ISO.
* Data is encrypted in transit and at rest where needed.
* Sensitive data is not leaked via application logs.
• We use role based access control with minimum privileges for internal tools and the systems we build.
* Identity and access management is modern and secure.
  * e.g. OAuth/OIDC with MFA.
* Security is treated as an unspoken user need and functional tests ensure security measures work as intended.
* Automated checks are in place for vulnerabilities in dependencies such as code libraries and container or VM base images.

