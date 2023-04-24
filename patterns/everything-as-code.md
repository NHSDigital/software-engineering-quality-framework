# Everything as code

## Context

* These notes are part of a broader set of [principles](../principles.md)

## The pattern

Everything (including [infrastructure](../practices/cloud-services.md)) should be created by code wherever practical.

## Benefits

* Easy to see changes over time
* Easy to review and test changes
* Enables automation (see [automate everything](automate-everything.md))

## Details

* All code is treated the same (e.g. application code, infrastructure code, test code, etc).
  * All code is [peer-reviewed](#code-review) and tested.
  * All code is version controlled.
  * The mainline branch (e.g. `main`) is protected: no force-pushes are allowed and code reviews, tests and any other automated checks must pass before pull/merge requests can be merged. Administrators should be subject to the same rules.
  * In general, squash merges are preferred for cleaner history. This does rely on merges being small, as should be the practice in any case.
* Code changes should be automatically checked for code quality using tools like [SonarQube](../tools/sonarqube.md) (as well as via IDE plugins).
* Code should be automatically scanned for secrets or other sensitive data (see [security](../practices/security.md) for details)
* Prefer well structured and expressive code over extensive documentation to avoid documentation getting out of date.
* Design the interface prior to the implementation and choose vocabulary to make it coherent. This includes external interfaces (e.g. REST API) and internal interfaces of classes, method signatures etc.
* Adopt test-first approach to minimise waste and increase cohesion of the code (see [testing](../practices/testing.md)).

### Code review

A code review involves another member of the team looking through a proposed code change and providing constructive feedback.

Many teams consider code which has been written [as a pair](https://martinfowler.com/articles/on-pair-programming.html) to already have been reviewed, and do not require a separate review.

Robert Fink provides an excellent description of the [motivation and practice of code reviews](https://medium.com/palantir/code-review-best-practices-19e02780015f). Some key points from this and other sources ([Google](https://google.github.io/eng-practices/review/reviewer/), [SmartBear](https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/), [Atlassian](https://www.atlassian.com/agile/software-development/code-reviews)) are:

#### Egalitarian

* With the right (basic) training, anyone in the team can review anyone else's code with no hierarchy.
* Everyone's code must be reviewed, no matter how experienced they are.

#### Small

* Code reviews should be relatively small as it is hard to review very large changes effectively.
* This is one reason to break stories down as small as practical and to implement each incrementally, ensuring no single change is too large to be reviewed well.

#### Meets user needs

While effective testing is the best way to detect bugs or non-functional problems, code review plays an important role in spotting _potential_ issues:

* Does the code look like it will meet the acceptance criteria, or are there obvious errors or omissions?
* Does it handle edge cases?

#### Of high quality

* Is the code clear and simple?
* Is the code layout and structure consistent with agreed style and other code? (please see [enforce code formatting](enforce-code-formatting.md))
* Would it easily allow future modification to meet slightly different needs, e.g. ten times the required data size or throughput?
* Have the non-functional requirements been considered (performance, scalability, robustness, etc)?
* Are common security issues guarded against (e.g. [OWASP Top 10](https://owasp.org/www-project-top-ten/))? Including:
  * Is any new input data being treated as potentially hostile?
  * Is any data potentially leaking from the system by mistake, for example sensitive data recorded in log files?
  * Are there secrets in the code?
  * For further reading, please see the [OWASP Code Review Guide](https://owasp.org/www-pdf-archive/OWASP_Code_Review_Guide_v2.pdf)

Note: automated scans and tests can help to identity a lot of these quality issues (please see [Quality Checks](../quality-checks.md)) but no automated scan is perfect, so both code reviews and automated checks are essential.

## Examples

* Application code written in languages such as Python, Java or C#.
* Application configuration, held in files (e.g. YAML, Json) held in source control.
* Declarative infrastructure as "code" (actually often YAML or HCL).
* Database migrations: SQL scripts held in source control.

## Further reading

* [Clean Code: A Handbook of Agile Software Craftsmanship](https://www.oreilly.com/library/view/clean-code-a/9780136083238/)
