# Testing

## Context

* These notes are part of a broader set of [principles](../principles.md)
* Related community of practice: [Test Automation Working Group](../communities/pd-test-automation-working-group.md)
* See also:
  * [Continuous integration](continuous-integration.md)
  * [Governance as a side effect](../patterns/governance-side-effect.md)
  * [Quality Metrics](../quality-checks.md)
  * [Performance Testing](performance-testing.md)

## General Testing Principles

* **Quality is the whole team's responsibility**
  * Education on testing and testing principles should be important to the whole team.
  * Quality approaches should be driven as a team and implemented by everyone.

* **Combining business knowledge with testing knowledge yields better quality outcomes**
  * Include business knowledge and critical thinking as part of assurance
  * Intrinsic knowledge and mindset of the team is key to driving quality outcomes

* **Testing is prioritised based on risk**
  * A testing risk profile is defined and understood by the whole team, including the customer
  * Risk appetite should be worked across the whole team, including customers and/or users
  * Solution Assurance risks and Clinical Safety hazards must also be considered when prioritising risks

* **Testing is context driven**
  * Context should be considered when deciding on test techniques and tools to use.

* **Testing is assisted by automation**
  * Appreciate that not everything can be automated
  * Identify good candidates for automation - particular focus on high risk and repeatable areas
  * Automated tests should be used to provide confidence to all stakeholders.  This includes test analysts themselves who should be familiar with what the tests are doing to allow them to make decisions on what they want to test.
  * Automated test packs should be maintained regularly to ensure they have suitable coverage, are efficient and providing correct results.
  * Consider using testing tools to enhance other test techniques.
    * Eg. using record and play tools to aid exploratory UI testing
    * Eg. using API testing tools to aid exploratory API testing

* **Testing should be continually improved**

* **Testing is continuous**
  * Testing is a continuous activity, not a phase of delivery
  * Testing can be performed in [all phases of a product's DevOps cycle](https://danashby.co.uk/2016/10/19/continuous-testing-in-devops/) and should be done as a collaborative exercise

## Test Automation Theory

* Test should be added at the most appropriate level of the [test pyramid](https://martinfowler.com/articles/practical-test-pyramid.html) &mdash; in general, the lower the better and avoid testing the same thing in multiple levels.
* Consider using the [agile testing quadrant](https://lisacrispin.com/2011/11/08/using-the-agile-testing-quadrants/) to help support a whole team approach around test planning and test automation.

## Guidelines for different types of testing

### Unit Testing Guidance

* Tests act as documentation of the system's behaviour and should be clear enough to do this effectively.
* Tests are written alongside or before whatever they are testing.
* Tests and test suites must be executable from the command line via a single command.
* Tests do not rely on other tests (i.e. each test can be executed in isolation, tests can be run concurrently and in any order).
* Tests only check a single condition (single concept).
* Tests are idempotent (i.e. give the same result when re-run against the same code).
* Test data is automatically generated when needed.
* Do not add tests of no value (e.g. tests of default getters/setters) just to increase the coverage level &mdash; 100% coverage is not a good use of time.
* Tests must pass before code can be merged.
* Use stubs to test the behaviour of components in isolation &mdash; focus tests of multiple services on validating the interactions between services e.g. using consumer-driven contract testing.

### API Testing Guidance

* When building an API start with an implementation of an automated contract test suite first. This can be supported by simple tools like Wiremock and Postman/Newman
* Use contract tests to support technical and business documentation
* Provide a web interface for exploratory testing. This usually comes out of the box with tooling that supports the OpenAPI specification. Although, this requires an environment to be set up or to be run on demand locally

### UI Testing Guidance

### Browser/OS Testing Guidance

* Website user interfaces should be tested against an appropriate set of browsers and versions &mdash; in particular, no effort should be spent testing against unsupported browsers or unsupported versions of browsers. See supported browsers for [Staff](https://aalto.digital.nhs.uk/#/document/viewer/8c039de1-eec0-49cd-8af3-a97fed6a8bff?library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0) and [Citizens](https://aalto.digital.nhs.uk/#/document/viewer/465e6d1b-f107-49eb-ad25-e72c0299d3a6?library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)

## Other Tools To Consider

* BDD tools to encode acceptance criteria in business terms as automated tests where appropriate.
* Chaos engineering / resilience testing e.g. using AWS Fault Injection Simulator (see [AWS FIS](../tools/aws-fis) for sample code)
* Performance tools to check load, volume, soak and stress limits (see [Performance Testing practices](performance-testing.md) for further details)

## Further reading and resources

* [Test Driven Development: By Example](https://learning.oreilly.com/library/view/test-driven-development/0321146530/)
* [xUnit Test Patterns: Refactoring Test Code](https://learning.oreilly.com/library/view/xunit-test-patterns/9780131495050/)
* [Setting a foundation for successful test automation](https://testautomationu.applitools.com/setting-a-foundation-for-successful-test-automation/), a short course by Angie Jones, who also has a talk on test automation strategy [based on game design](https://applitools.com/event/level-up-playing-the-automation-game/)
* [Test Automation University](https://testautomationu.applitools.com/)
* [Ministry of Testing](https://www.ministryoftesting.com/)
