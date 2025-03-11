# Testing

- [Testing](#testing)
  - [Context](#context)
  - [General testing principles](#general-testing-principles)
  - [Test automation theory](#test-automation-theory)
  - [Guidelines for different types of testing](#guidelines-for-different-types-of-testing)
    - [Unit testing guidance](#unit-testing-guidance)
    - [API testing guidance](#api-testing-guidance)
    - [UI testing guidance](#ui-testing-guidance)
    - [Browser/OS testing guidance](#browseros-testing-guidance)
  - [Other tools to consider](#other-tools-to-consider)
  - [Further reading and resources](#further-reading-and-resources)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- See also:
  - [Continuous integration](continuous-integration.md)
  - [Governance as a side effect](../patterns/governance-side-effect.md)
  - [Quality Metrics](../quality-checks.md)
  - [Performance Testing](performance-testing.md)

## General testing principles

- **Design for testability**, and [shift testing left and right](https://www.redhat.com/en/topics/devops/shift-left-vs-shift-right)

  Testing is most effective when it is baked into the system design and runs across the entire lifecycle-from development to production. Teams should build systems that are inherently testable and support both early validation ("shift left") and ongoing validation in live environments ("shift right"). Key Practices:

  - Shift left, aka test early
    - Testing starts at the design and coding phase, not after.
    - Pre-commit hooks, linting, static code analysis, and unit tests run locally before code even hits a branch.
    - [Test-Driven Development (TDD)](https://www.thoughtworks.com/en-gb/insights/blog/test-driven-development-best-thing-has-happened-software-design) and [Behavior-Driven Development (BDD)](https://www.thoughtworks.com/en-gb/insights/blog/applying-bdd-acceptance-criteria-user-stories) encourage writing tests before or alongside code, ensuring clarity of requirements and better design.
    - Test planning is informed by risk analysis and [architectural decisions](../any-decision-record-template.md) made early on.
  - Design for testability
    - Systems are designed with observability, modularity, and controllability in mind.
    - Expose clear APIs, provide injection points for test doubles (mocks/stubs), and avoid tight coupling.
    - Feature toggles and dependency injection help test components in isolation without complex setups.
    - Make non-functional testing (performance, security, resilience) a first-class concern, with hooks and controls to simulate adverse conditions.
  - Design for reproducibility
    - Tests should be idempotent and easily repeatable in any environment (local, test, staging, production).
  - Shift right, aka test in production
    - Testing does not stop at deployment-continuous validation in production is essential.
    - Implement real-time monitoring, synthetic checks, health probes, and user behavior tracking.
    - Use canary deployments, blue-green releases, and feature flags to roll out changes gradually, monitoring for issues as they surface.
    - Employ chaos engineering to test system resilience under real-world failure conditions.
    - Instrument systems to detect anomalies, performance degradation, or unexpected behaviors automatically.

  In a high-throughput environment-where deploying at least once a day is the norm, adhering to the design for testability principle is paramount. The benefits include: 1) *faster feedback loops* – early testing catches issues when they are cheapest to fix, while testing later in the cycle ensures real-world readiness; 2) *increased confidence* – testing at all stages validates assumptions, improves system reliability, and supports safe, frequent releases; and 3) *higher quality by design* – systems built for testability are easier to maintain, scale, and evolve.

- **Quality is the whole team's responsibility**
  - Education on testing and testing principles should be important to the whole team.
  - Quality approaches should be driven as a team and implemented by everyone.
  - Teams should consider running regular coaching / mentoring sessions to support colleagues who are less experienced in testing to grow their skills, for example by no-blame group discussions to identify edge-case tests which have so far been missed, tests positioned incorrectly in the [test pyramid](https://martinfowler.com/articles/practical-test-pyramid.html), and pairing with a tester navigating so that the driver learns the necessary skills.
  - Testing is a shared team concern, not a tester’s job alone. Developers own testing for their code, including pipeline tests, monitoring their deploys, infrastructure and on-call responsibilities, as deploying at least once a day requires autonomy and accountability.

- **Combining business knowledge with testing knowledge yields better quality outcomes**
  - Include business knowledge and critical thinking as part of technical assurance.
  - Intrinsic knowledge and mindset of the team is key to driving quality outcomes.

- **Testing is prioritised based on risk**
  - A testing risk profile is defined and understood by the whole team, including the customer.
  - Risk appetite should be worked across the whole team, including customers and/or users.
  - Assurance risks and Clinical Safety hazards must also be considered when prioritising risks.

- **Testing is context driven**
  - Context should be considered when deciding on test techniques and tools to use.

- **Test data management is a first-class citizen**

  Frequent deployments require reliable and consistent test environments. Data drift or stale data can undermine test confidence.

  - Test data should be easy to generate, isolate and reset.
  - Use factories, fixtures or synthetic data generation.
  - Anonymised production data can improve test relevance, especially in performance or exploratory testing.

- **Consistent, CLI-driven test execution across all environments**

  Tests and test processes should execute consistently in every environment, ranging from local developer workstations to cloud-based CI/CD pipelines. Using a CLI-driven approach ensures standardisation, portability and reliability.

  - Command-Line interface (CLI) as the default test runner
    - All tests (unit, integration, functional, performance) must be executable through straightforward, repeatable CLI commands.
    - Ensure a single, consistent command can run the complete test suite, facilitating rapid local and remote execution , e.g. `make test`
  - Consistent environment configuration
    - Clearly defined and documented dependencies (IaC) ensure that test environments are reproducible, reducing "it works on my machine" scenarios.
    - Use Infrastructure as Code (IaC) or containerised test environments (e.g. Docker) to guarantee identical configurations between local machines and cloud pipelines.
  - Reproducibility and portability
    - Tests must behave identically when run locally and remotely. No tests should rely on hidden state, manual configuration, or proprietary local tooling.
    - Standardise environment configuration through version-controlled configuration files or scripts, enabling teams to replicate exact test runs on any workstation or CI/CD environment effortlessly.
  - Dependency isolation and management
    - Dependencies should be explicitly declared and managed using tools appropriate to your technology stack (e.g. Python’s requirements.txt, Node’s package.json, etc.).
    - Employ dependency management tools (e.g. virtual environments, containers, package managers) to enforce consistency.
  - Environment parity between development and production
    - Aim to eliminate differences between local, staging and production environments. Running tests consistently across environments ensures that deployment to production is predictable and low-risk.
    - Teams regularly validate environment parity through automated checks or smoke tests.
  - Clear and consistent documentation
    - Standardised CLI test commands and environment setups must be clearly documented (e.g. README.md) and version-controlled.
    - Onboarding documentation should guide new developers to execute the same tests consistently across their local and cloud environments.

- **Validate continuously through observability**

  Effective testing does not stop once software reaches production. By integrating observability into testing, teams gain real-time insights and continuously validate system behavior under real-world conditions. Observability-driven testing means using telemetry data, such as metrics, logs, tracing and user analytics, to shape test approach, validate assumptions, detect regressions early and drive continuous improvement.

  - Instrument systems for visibility
    - Implement consistent instrumentation (metrics, logs, tracing) across services to capture detailed runtime behavior.
    - Ensure telemetry data clearly maps back to business functionality, enabling both technical and business stakeholders to interpret the data.
  - Continuous monitoring in production
    - Use dashboards and automated alerts to monitor system health continuously, proactively detecting anomalies, performance degradation or unexpected behaviors.
    - Regularly verify production health checks and synthetic monitoring results as part of your ongoing testing activities.
  - Real-user monitoring (RUM)
    - Observe and analyze how real users interact with the system, capturing actual usage patterns, performance characteristics and edge-case scenarios.
    - Leverage this data to refine existing automated tests or identify new scenarios worth automating.
  - Distributed tracing to inform testing
    - Use distributed tracing data (such as OpenTelemetry, AWS X-Ray or Azure Monitor Application Insights) to understand how requests flow through services, identify latency hotspots and pinpoint complex dependency issues.
    - Translate tracing insights into targeted integration tests and service-level tests, improving test precision.
  - Alerting and proactive issue detection
    - Set clear, actionable alerts based on predefined thresholds that matter to users and the business.
    - Tie production alerts back into automated test scenarios, ensuring tests reflect actual production conditions and preventing similar issues from recurring.
  - Feedback loops into test planning
    - Regularly analyze observability data (logs, metrics, user sessions) during sprint planning or retrospectives to identify gaps in testing coverage.
    - Treat production incidents as opportunities for testing improvements, each incident should trigger analysis of whether similar risks are sufficiently covered by automated or exploratory tests.
  - Testing resilience and failure modes
    - Observability supports chaos engineering practices by providing detailed visibility into system behavior under fault conditions.
    - Proactively test recovery procedures, failovers and resilience strategies based on observed patterns of failure or degradation from production data.

  Applying this principle reduces mean-time-to-detection and recovery, improving reliability, enables teams to validate assumptions using real data rather than guesswork, enhances the quality of future releases by continuously learning from real-world usage patterns. Increases confidence when releasing frequently, knowing production issues can be quickly identified, understood and addressed.

- **Testing is assisted by automation**

  Test automation is critical for maintaining rapid, frequent deployments while consistently ensuring quality. It provides scalable confidence in software changes, reduces repetitive manual efforts, and frees up human activities for high-value exploratory testing. Automated testing should be seen as a core enabler of development workflow, particularly when combined with a robust approach to design for testability.

  - Appreciate that not everything can be automated, however automated testing, supported by intentional design for testability, increases delivery speed, confidence and adaptability.
  - Identify good candidates for automation - particular focus on high risk and repeatable areas.
  - Automated tests should be used to provide confidence to all stakeholders. This includes test analysts themselves who should be familiar with what the tests are doing to allow them to make decisions on what they want to test.
  - It defines clear, technology-neutral contracts and behaviors. This provides stable reference points when migrating or re-implementing systems in new languages or platforms. Automated contract tests (e.g. consumer-driven contract tests) enable safe technology swaps, helping confirm system compatibility across evolving stacks.
  - Automated test packs should be maintained regularly to ensure they have suitable coverage, are efficient and providing correct results.
  - Consider using testing tools to enhance other test techniques, e.g.
    - using record and play tools to aid exploratory UI testing,
    - using API testing tools to aid exploratory API testing.

- **Testing should be continually improved**
  - [Peer reviews](../patterns/everything-as-code.md#code-review) must consider tests as a first-class concern - this includes tests that are present / have been added (e.g. whether they are positioned appropriately in the [test pyramid](https://martinfowler.com/articles/practical-test-pyramid.html), whether they are triggered appropriately in CI builds, etc) and any tests that are missing, e.g. edge-cases not yet considered

- **Testing is continuous**
  - Testing is a continuous activity, not a phase of delivery
  - Testing can be performed in [all phases of a product's DevOps cycle](https://danashby.co.uk/2016/10/19/continuous-testing-in-devops/) and should be done as a collaborative exercise

## Test automation theory

- Test should be added at the most appropriate level of the [test pyramid](https://martinfowler.com/articles/practical-test-pyramid.html) &mdash; in general, the lower the better and avoid testing the same thing in multiple levels.
- Consider using the [agile testing quadrant](https://lisacrispin.com/2011/11/08/using-the-agile-testing-quadrants/) to help support a whole team approach around test planning and test automation.

## Guidelines for different types of testing

### Unit testing guidance

- Tests act as documentation of the system's behaviour and should be clear enough to do this effectively.
- Tests are written alongside or before whatever they are testing.
- Tests and test suites must be executable from the command line via a single command.
- Tests do not rely on other tests (i.e. each test can be executed in isolation, tests can be run concurrently and in any order).
- Tests only check a single condition (single concept).
- Tests are idempotent (i.e. give the same result when re-run against the same code).
- Test data is automatically generated when needed.
- Do not add tests of no value (e.g. tests of default getters/setters) just to increase the coverage level &mdash; 100% coverage is not a good use of time.
- Tests must pass before code can be merged.
- Use stubs to test the behaviour of components in isolation &mdash; focus tests of multiple services on validating the interactions between services e.g. using consumer-driven contract testing.

### API testing guidance

- When building an API start with an implementation of an automated contract test suite first. This can be supported by simple tools like Wiremock and Postman/Newman
- Use contract tests to support technical and business documentation
- Provide a web interface for exploratory testing. This usually comes out of the box with tooling that supports the OpenAPI specification. Although, this requires an environment to be set up or to be run on demand locally

### UI testing guidance

### Browser/OS testing guidance

- Website user interfaces should be tested against an appropriate set of browsers and versions &mdash; in particular, no effort should be spent testing against unsupported browsers or unsupported versions of browsers. See supported browsers for [Staff](https://aalto.digital.nhs.uk/#/document/viewer/8c039de1-eec0-49cd-8af3-a97fed6a8bff?library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0) and [Citizens](https://aalto.digital.nhs.uk/#/document/viewer/465e6d1b-f107-49eb-ad25-e72c0299d3a6?library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)

## Other tools to consider

- BDD tools to encode acceptance criteria in business terms as automated tests where appropriate.
- Chaos engineering / resilience testing e.g. using AWS Fault Injection Simulator (see [AWS FIS](../tools/aws-fis) for sample code)
- Performance tools to check load, volume, soak and stress limits (see [Performance Testing practices](performance-testing.md) for further details)

## Further reading and resources

- [Test Driven Development: By Example](https://learning.oreilly.com/library/view/test-driven-development/0321146530/)
- [xUnit Test Patterns: Refactoring Test Code](https://learning.oreilly.com/library/view/xunit-test-patterns/9780131495050/)
- [Setting a foundation for successful test automation](https://testautomationu.applitools.com/setting-a-foundation-for-successful-test-automation/), a short course by Angie Jones, who also has a talk on test automation strategy [based on game design](https://applitools.com/event/level-up-playing-the-automation-game/)
- [Test Automation University](https://testautomationu.applitools.com/)
- [Ministry of Testing](https://www.ministryoftesting.com/)
