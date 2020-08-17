# Quality assessment tool

This is part of a broader [quality framework](README.md)

This tool aims to:
* Help teams understand what "good" looks like — and to contribute to that shared understanding.
* Measure themselves against this shared standard.
* Identify and prioritise improvement work.
* Escalate and ask for help in driving improvements.

# Metrics
These hard figures help us to measure the effect of improvement work over time.

## Essential:

| Measure | Definition (each calculated over the last 28 days) |
|:---|:---|
| Deployment frequency | Number of deployments

## Recommended:

| Measure | Definition (each calculated over the last 28 days) |
|:---|:---|
| Lead time | Median time between an item being started to when it is done.
| Change failure rate | Percentage of deployments which result in an incident.
| Overall incident rate: P1 | Total number of priority 1 incidents which occurred.
| Mean time to restore service: P1 | Mean time from priority 1 incident starting to when it is resolved.
| Overall incident rate: P1 | Total number of priority 2 incidents which occurred.
| Mean time to restore service: P2 | Mean time from priority 2 incident starting to when it is resolved.
| Overall incident rate: P3 | Total number of priority 3 incidents which occurred.
| Mean time to restore service: P3 | Mean time from priority 3 incident starting to when it is resolved.

# Scores and actions

Focus on one area at a time, e.g. mission, plan.

As a team, assign a 1–5 score as below. You could use "planning poker" style blind voting.
1. Major problems to fix or work to do.
1. Significant issues, worries or gaps. A key area for improvement.
1. Some issues or gaps which need focus to improve.
1. Not a primary focus for improvement. A few rough edges, but no major concerns.
1. May not be perfect, but we hold this as an example of how to do things well.

Discuss why that score and not higher or lower. Pay particular attention when there are large differences in scoring between individuals. These are a great opportunity to build more consensus and shared understanding.

Finally (and most importantly) identify actions to move the score upward.

#### Example

|Area|Score|Comments|Actions|
|:---|:---|:---|:---|
|Mission|2|We don't validate our user needs|Identify customers to participate in focus groups|
|Plan|3|Plan is a bit out of date and feature focused|Begin regular fortnightly backlog refinement and roadmap refresh session.<br>One off review to make sure operational readiness is adequately represented.|
|Pawns or players|5|We have great autonomy|No action|

## Team

### 1. Mission
* We have clear goals.
* User needs are well understood. They validated through user research.
* We know the metrics which will measure success and how they will be measured.
* Non-functional requirements are understood and based on user needs.

### 2. Plan
* Our plan guides us.
* It is up to date and complete.
* It changes when it should but is stable enough.
* It gives our stakeholders a clear forecast of what is most likely to happen over the coming time periods.
* It makes sure we work on the right things first and helps us predict and avoid issues.
* Functionality is delivered in [thin vertical slices](https://docs.google.com/document/u/1/d/1TCuuu-8Mm14oxsOnlk8DqfZAA1cvtYu9WGv67Yj_sSk/pub), starting by building a [steel thread](https://www.agiledevelopment.org/agile-talk/111-defining-acceptance-criteria-using-the-steel-thread-concept) / [walking skeleton](https://www.henricodolfing.com/2018/04/start-your-project-with-walking-skeleton.html).
* Risky items and dependencies are clearly indicated and work to reduce risk is prioritised.
* The plan gets the right balance between delivering features and operational aspects.
* We track risks, issues, assumptions and dependencies ('RAID') and work creatively to resolve them.
* We keep a log of key technical and product decisions and who approved them.

### 3. Fast, reliable and safe delivery
* We work well together to keep the work flowing.
* We have a defined process which we all stick to.
* Our process helps us deliver high quality work quickly.
* Our daily stand up keeps us aligned and working well as a team.
  * It helps us share and resolve impediments.
* Our regular planning sessions are efficient and effective.
* We practice [trunk-based development](https://trunkbaseddevelopment.com/) using short-lived feature branches off master.
  * Tests must pass before code is merged.
* We can see when the build has broken or tests are failing and we fix them before carrying on.
* Our definition of "done" is "deployed to production".
* We explicitly limit work in progress (WIP).
* Our lead time is typically two days or less.
  * (Lead time = time from picking an item up to it being done.)
* The onboarding process for new team members is simple and straightforward.

### 4. Fun
* The team is a fun place to be every day.
* We have great team spirit and help each other out.
* We give each other honest feedback.
* We learn something every day.
* We look forward to our retrospectives and they drive valuable improvements.

### 5. Pawns or players
* As a team, we are in control of our destiny!
* We decide what to build and how to build it.

### 6. Outside support
* We always get great support and help from outside the team when we ask for it!
* We are listened to and our ideas are used to improve the organisation.

## Individual component or system
You may wish to score each individual component or system separately for these aspects.
> Identify components based on natural seams in the system. Ultimately, the aim is to make it easy to decide what the appropriate score is for each "component". If you can"t decide between a low and high score for an aspect then this may indicate that component should be broken down to allow finer grained scoring.
>
> Example components:
> * React web UI
> * Individual APIs or services
> * The cloud platform
> * The CI/CD system

### 7. Skills and knowledge
* We have the skills and knowledge we need.
* Skills and knowledge are well spread between team members.
* We are familiar with the tech in use and know how to use it well.
* We know the codebase and are comfortable making changes in it.
* We know how to operate the live system reliably and diagnose and fix things when they break.
* We have the skills and knowledge for what we will be doing next.

### 8. Tech and architecture
* The tech helps us deliver value.
* We enjoy working with it and it supports fast, reliable and safe delivery.
* The architecture is clean.
* The tech and architecture make testing, local development and live operations easy.
* We use serverless or ephemeral infrastructure.

### 9. Healthy code base
* We're proud of the quality of our code!
* It is clean, easy to read, and safe to work with.

### 10. Testing
* We have great test coverage.
* Testing is everyone's responsibility.
* The time we spend on testing is really worthwhile.
* We use the right mixture of tools and techniques, e.g.
  * code-level unit and integration tests, and maybe behaviour-driven development
  * running-system component, integration and whole-system tests
* Our tests focus on individual components and the contracts between them, not on testing the whole system together.
* We use stubs to insulate our tests from other components and systems.
* Our components have versioned APIs.
* Breaking changes are detected and clearly indicated.
  * e.g. using Consumer-Driven Contract testing and semantic versioning.
* We understand user needs and non-functional requirements and our tests prove they are being met.
  * e.g. accessibility, browser compatibility, performance, capacity, resilience.
* Test data is automatically generated and has the right properties and scale.

### 11. Easy to release
* It is easy and straightforward to release a change to production.
* We can release on demand, typically multiple times per day.
* Every code merge triggers the creation of a potentially releasable build artifact.
  * That same artifact is deployed to each environment (e.g. dev, test, prod) rather than a new build being done for each.
* We can deploy any recent version.
* Our deployments are automated, including everything needed to build an environment from scratch.
* Our test and production environments are all in a known state, including configuration parameters.
* The CI/CD system has secure access control and credentials to deploy to each environment are handled securely.
* We use blue-green/canary deployments to safely verify each deployment before fully switching over to the new version.
* Our non-prod environments are cleared down automatically when they're no longer needed.

### 12. Operations
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
* We design for failure and we're confident our service will self-heal from most issues.
* Our service is immutable: rather than make changes, we tear down and rebuild every time.
* We can see what is currently deployed in each environment, including configuration and feature flags, and can see the history of changes.
* Our infrastructure scales automatically.
* We have clear visibility of our environment costs, and we regularly check for waste.

### 13. Security and compliance
* We are confident our systems are secure.
* We model threats and design systems to be secure.
* Security is baked into our software delivery process.
  * e.g. in analysis, coding and testing.
* We understand typical vulnerabilities and how to guard against them.
  * e.g. OWASP Top Ten.
* We understand the sensitivity of the data we process and handle it accordingly.
* We know which regulations apply, and ensure we meet their requirements.
  * e.g. GDPR, PCI, ISO.
* Data is encrypted in transit and at rest where needed.
* Sensitive data is not leaked via application logs.
* We use role based access control with minimum privileges for internal tools and the systems we build.
* Identity and access management is modern and secure.
  * e.g. OAuth/OIDC with MFA.
* Security is treated as an unspoken user need and functional tests ensure security measures work as intended.
* Automated checks are in place for vulnerabilities in dependencies such as code libraries and container or VM base images.
* There is strong separation (e.g. different AWS accounts) for test and production systems.
* Humans don't have write access to production, except via time-limited "break-glass" permissions.
* We keep the versions of technology in our service up to date.



