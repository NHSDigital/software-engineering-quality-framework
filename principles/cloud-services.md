# Cloud services

## Context

* These notes are part of a broader set of [principles](../principles.md)
* TO DO: Reference to the Tech Radar?

## Principles

### Keep it simple
* Use managed services where available and appropriate.
* In general, prefer software as a service (SaaS, e.g. Splunk, Jira), then serverless platform as a service (PaaS, e.g. Amazon DynamoDB, AWS Lambda), then infrastructure as a service (IaaS, e.g. cloud VMs).
* The aim is to reduce operational maintenance work and improve security and reliability by handing responsibility to the cloud provider. They have made a business from doing this better than most organisations can.
* For compute, prefer functions as a service (e.g. AWS Lambda), then serverless containers (e.g. GKE, AWS Fargate), then VM based deployments (e.g. AWS EKS, AWS ECS on EC2).
* For data persistence, prefer pay per request options (e.g. Amazon DynamoDB, S3) to pay per time choices (e.g. Amazon Aurora or RDS).
* In general, prefer solutions which do not involve managing VMs if possible, and ideally where there is no explicit configuration of a network (e.g. subnets, internet gateways, NAT gateways) &mdash; compare AWS Lambda which needs no network with AWS Fargate which does.

### Automate
* Configure all infrastructure using declarative tools such as Terraform and Cloudformation.
  * As with any other code, this configuration must be version controlled and peer-reviewed.
* Automate monitoring and alerting.
* Make systems self-healing.
* Services should scale automatically up and down.
* Infrastructure should always be fully utilised (if it isn't, it's generating waste).

### Reliable by design
* Be aware of data sovereignty implications of using any systems hosted outside the UK.
  * Make sure your information governance lead is aware and included in decision making.
  * Consider SaaS tools the team uses as well as the systems we build.
* Understand and be able to justify vendor lock in.
  * If the benefits of vendor lock in outweigh the pain of being locked in, being locked in is a good thing.
  * e.g. for a particular use case AWS Lambda may allow you to deliver and operate far more cheaply than Kubernetes, but would require work to re-engineer if moving to a different cloud provider.
  * The choice is between investing time early to build in mobility and deferring that effort (quite possibly forever) to focus on things which deliver more value to the organisation.
* Segregate production and non-production workloads.

### Track
* Infrastructure must be tagged to identity the service so that unnecessary resources don't go unnoticed.
* Configure audit tools such as CloudTrail.