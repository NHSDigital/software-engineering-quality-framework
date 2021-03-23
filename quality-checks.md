# Engineering quality-checks

This is part of a broader [quality framework](README.md)

# Summary

Quality checks are at the heart of good engineering and are essential for rapid and safe delivery of software changes. This page provides an index of the various quality checks described within our principles, patterns and practices.

# Usage

We recommend all projects should apply all of the applicable quality checks

Not all checks are applicable in all contexts, for example accessibility testing is obviously not applicable to products without a user interface

## RAG scale

We rate our projects against these checks as follows:

* Green = check is applied frequently and consistently (typically via CI/CD), the output of the check is a quality gate (as opposed to just a warning / for information), and the tolerances for that quality gate (e.g. code coverage %) are agreed and understood
* Amber = check is applied, but not all conditions for green are met
* Red = check not in place
* N/A = check does not apply in the context

# Details

| Quality check | Classification | Applicability | What it means | We we care | Tolerances for green | Endorsed tools / configuration | Further details |
|:---|:---|:---|:---|:---|:---|:---|:---|
| Unit tests | Functionality | Universal| | | | |
| Integration tests | Functionality | Universal | | | | | |
| API / contract tests | Functionality | Contextual | | | | | |
| UI tests | Functionality | Contextual | | | | | |
| Secret scanning | Security | Universal | | | | | |
| Security code analysis | Security | Universal | | | | | |
| Security testing | Security | Contextual | | | | | |
| Dependency scanning | Security | Universal | | | | | |
| Performance tests | Resilience | Contextual | | | | | |
| Capacity tests | Resilience | Contextual | | | | | |
| Stress tests | Resilience | Contextual | | | | | |
| Soak tests | Resilience | Contextual | | | | | |
| Chaos tests | Resilience | Contextual | | | | | |
| Code coverage | Maintainability | Universal | | | | | |
| Duplicate code scan | Maintainability | Universal | | | | | |
| Code smells scan | Maintainability | Universal | | | | | |
| Dead code scan | Maintainability | Universal | | | | | |
| Code review | Other | Universal | | | | | [Code review guidance](/patterns/everything-as-code.md#code-review) |
| Accessibility tests | Other | Universal | | | | | |
| Tech radar check | Other | Universal | | | | | |
