# Cloud services

## Context

* These notes are part of a broader set of [principles](../principles.md)
* TO DO: Reference to the Tech Radar?

## Principles

* Use managed services where available and appropriate
* In general, prefer software as a service (SaaS, e.g. Splunk), then platform as a service (PaaS, e.g. Amazon DynamoDB), then infrastructure as a service (IaaS, e.g. cloud VMs)
* Inform your information governance lead about use of managed services running outside of the UK
* Understand and be able to justify vendor lock in: if the benefits of vendor lock in outweigh the pain of being locked in, being locked in is a good thing. e.g. for a particular use case AWS Lambda may allow you to deliver and operate far more cheaply than Kubernetes, but would require work to re-engineer if moving to a different cloud provider. The choice is between investing time early to build in mobility and deferring that effort (quite possibly forever).
