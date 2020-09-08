# Testing

## Context

* These notes are part of a broader set of [principles](../principles.md)
* TO DO: Further reading / training courses about test automation
* Related community of practice: [Automation Working Group](../communities/pd-automation-working-group.md)
* See also:
    * [Continuous integration](continuous-integration.md)
    * [Governance as a side effect](../patterns/governance-side-effect.md)

## Details

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
* Website user interfaces should be tested against an appropriate set of browsers and versions (TO DO &mdash; won't be able to reference the policy, might need to copy and paste) &mdash; in particular, no effort should be spent testing against unsupported browsers or unsupported versions of browsers.
