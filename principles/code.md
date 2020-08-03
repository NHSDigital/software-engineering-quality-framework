# Code

## Context

* These notes are part of a broader set of [principles](../principles.md)

## Principles

* Everything (including [infrastructure](cloud-services.md)) should be created by code.
* All code is treated the same (e.g. application code, infrastructure code, test code, etc).
  * All code is peer-reviewed and tested.
  * All code is version controlled.
* Code changes should be automatically checked for code quality using tools like [SonarQube](https://www.sonarqube.org) (as well as via IDE plugins).
* Code should be automatically scanned for secrets or other sensitive data using standalone tools like [GitGuardian](https://www.gitguardian.com/) or built in tools in [GitLab](https://docs.gitlab.com/ee/user/application_security/secret_detection/) or [GitHub](https://docs.github.com/en/github/administering-a-repository/about-secret-scanning).
