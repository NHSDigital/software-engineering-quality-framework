# Testing

## Context

* These notes are part of a broader set of [principles](../principles.md)
* Related community of practice: [Test Automation Working Group](../communities/pd-test-automation-working-group.md)
* See also:
  * [Continuous integration](continuous-integration.md)
  * [Governance as a side effect](../patterns/governance-side-effect.md)

## Testing Specific Principles
* Quality is the whole team's responsibility
  * Software testing is the responsibility of the whole team.
  * Education on testing and testing principles is important to drive the right cultural behaviours.
  * Quality approaches are driven by testers, but implemented by everyone.
* Combining business knowledge with testing knowledge yields better quality outcomes
  * Include business knowledge and critical thinking as part of assurance
  * Intrinsic knowledge and mindset of the tester is key to driving quality outcomes
  * Use BDD as an approach to align testing across the whole team and customer

## Details

* Software quality and testing is everyone's responsibility.
* Tests are automated by default (see [automate everything](../patterns/automate-everything.md)).
* Tests act as documentation of the system's behaviour and should be clear enough to do this effectively.
* Tests are written alongside or before whatever they are testing.
* Tests are code (see [everything as code](../patterns/everything-as-code.md)).
* Use Behaviour Driven Development (BDD) to encode acceptance criteria in business terms as automated tests where appropriate.
  * This can be an effective communication and collaboration tool where the product owner is involved in reviewing detailed acceptance criteria (expressed as BDD tests).
  * But if the PO is not involved in this way then well written unit and integration tests are often sufficient and avoid the extra layer of abstraction which BDD frameworks introduce.
* Tests and test suites must be executable from the command line via a single command.
* Tests do not rely on other tests (i.e. each test can be executed in isolation, tests can be run concurrently and in any order).
* Tests only check a single condition.
* Tests are idempotent (i.e. give the same result when re-run against the same code).
* Test data is automatically generated when needed.
* New functionality must be covered by passing automated tests (unless there is a legitimate reason not to).
* Consider where best to add tests within the [test pyramid](https://martinfowler.com/articles/practical-test-pyramid.html) &mdash; in general, the lower the better.
* Avoid testing the same thing at multiple levels of the test pyramid.
* Use stubs to test the behaviour of components in isolation &mdash; focus tests of multiple services on validating the interactions between services e.g. using consumer-driven contract testing.
* Do not add tests of no value (e.g. tests of default getters/setters) just to increase the coverage level &mdash; 100% coverage is not a good use of time.
* Tests must pass before code can be merged.
* Non-functional requirements should also be covered by automated tests (e.g. security, performance, accessibility).
* Website user interfaces should be tested against an appropriate set of browsers and versions &mdash; in particular, no effort should be spent testing against unsupported browsers or unsupported versions of browsers. See supported browsers for [Staff](https://aalto.digital.nhs.uk/#/document/viewer/8c039de1-eec0-49cd-8af3-a97fed6a8bff?library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0) and [Citizens](https://aalto.digital.nhs.uk/#/document/viewer/465e6d1b-f107-49eb-ad25-e72c0299d3a6?library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)

## Further reading

* [Test Driven Development: By Example](https://learning.oreilly.com/library/view/test-driven-development/0321146530/)
* [xUnit Test Patterns: Refactoring Test Code](https://learning.oreilly.com/library/view/xunit-test-patterns/9780131495050/)
