# Test Automation

## Context

* These notes are part of a broader set of [principles](../principles.md)
* Further reading / training courses about test automation: (TO DO)

## Principles

* Tests are automated by default
* Tests are written alongside or before whatever they are testing
* Tests are code, and all code is treated the same, including:
    * All code is peer-reviewed
    * All code is version controlled
* Tests and test suites must be executable from the command-line as one-liners
* Tests use BDD where appropriate
* Tests do not rely on other tests (i.e. each test can be executed in isolation)
* Tests only check a single condition
* Tests are idempotent (i.e. give the same result when re-run against the same code)
* New functionality must be covered by passing automated tests (unless there is a legitimate reason not to)
* Consider where best to add tests within the test pyramid - in general, the lower the better
* Do not add tests of no value (e.g. tests of default getters/setters) just to increase the coverage level - 100% coverage is not a good use of time
