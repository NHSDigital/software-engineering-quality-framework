# Security

## Context

* These notes are part of a broader set of [principles](../principles.md)
* TO DO: Further reading / training courses about security
* TO DO: Reference to the Security Working Group (link to terms of reference?)

## Principles

* Everything (including infrastructure) should be up to date
* Application dependencies should be automatically scanned for vulnerabilities & license issues
    * TO DO: guidance around setting team tolerances for warnings etc
* Source code should be automatically scanned for secrets or other senstive data (for example via tools like [AWS Macie](https://aws.amazon.com/macie/))
* Nobody should need access to production hosts, including:
    * Logging & monitoring should negate the need to manually inspect a production host
    * Deployments are immutable, and all deployments are issued via delivery pipelines, negating the need to manually change a production host
* Any access to production must be audited
