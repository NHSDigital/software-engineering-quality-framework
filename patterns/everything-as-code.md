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
  * All code is peer-reviewed and tested.
  * All code is version controlled.
* Code changes should be automatically checked for code quality using tools like [SonarQube](https://www.sonarqube.org) (as well as via IDE plugins).
* Code should be automatically scanned for secrets or other sensitive data using standalone tools like [GitGuardian](https://www.gitguardian.com/) or built in tools in [GitLab](https://docs.gitlab.com/ee/user/application_security/secret_detection/) or [GitHub](https://docs.github.com/en/github/administering-a-repository/about-secret-scanning).
* Prefer well structured and expressive code over extensive documentation to avoid documentation getting out of date.
* Design the interface prior to the implementation and choose vocabulary to make it coherent. This includes external interfaces (e.g. REST API) and internal interfaces of classes, method signatures etc.
* Adopt test-first approach to minimise waste and increase cohesion of the code (see [testing](../practices/testing.md)).

## Examples

* Application code written in languages such as Python, Java or C#.
* Application configuration, held in files (e.g. YAML, Json) held in source control.
* Declarative infrastructure as "code" (actually often YAML or HCL).
* Database migrations: SQL scripts held in source control.
