# Outsource bottom up

## Context

* These notes are part of a broader set of [principles](../principles.md)
* This is related to:
  * [ARCHITECTURE-CLOUD](https://aalto.digital.nhs.uk/#/object/details?objectId=923e33f8-889d-42e5-a7d1-8b04b3e4220f&library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)
  * [ARCHITECTURE-REUSE](https://aalto.digital.nhs.uk/#/object/details?objectId=ce63238e-8a54-4bd8-8cd5-aa6e2f23f4ef&library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)

## The pattern

Use managed services where available and appropriate. The aim is to reduce operational burden by handing responsibility to the cloud provider. They have made a business from doing this better than most organisations can.

## Benefits

* Reduced effort in building the "infrastructure" makes more time to build business valuable functionality.
* Reduced operational maintenance overhead.
* Improved reliability.
* Improved security.

## Details

* Prefer software as a service (SaaS, e.g. Splunk, Jira), then serverless platform as a service (PaaS, e.g. Amazon DynamoDB, AWS Lambda), then infrastructure as a service (IaaS, e.g. cloud VMs).
* For compute, prefer functions as a service (e.g. AWS Lambda), then serverless containers (e.g. GKE, AWS Fargate), then VM based deployments (e.g. AWS EKS, AWS ECS on EC2).
  * TO DO: close discussion about whether containers are still preferable in some use-cases
* For data persistence prefer (where there are no other differentiating factors) pay per request options (e.g. Amazon DynamoDB, S3) to pay per time choices (e.g. Amazon Aurora or RDS).
* In general, prefer solutions which do not involve managing VMs if possible, and ideally where there is no explicit configuration of a network (e.g. subnets, internet gateways, NAT gateways) &mdash; compare AWS Lambda which needs no network with AWS Fargate which does.

## Cloud native vs cloud agnostic

A closely related, but subtly distinct consideration is whether to prefer cloud native (serverless) technologies or cloud agnostic / generic ones. Cloud native choices inevitably imply specialising our solution for that one technology, which could create a degree of vendor lock in.

* Understand and be able to justify vendor lock in.
  * If the benefits of vendor lock in outweigh the pain of being locked in, then being locked in is a good thing.
  * e.g. for a particular use case AWS Lambda may allow you to deliver and operate far more cheaply than Kubernetes, but would require work to re-engineer if moving to a different cloud provider.
  * The choice is between investing time early to build in mobility and deferring that effort (quite possibly forever) to focus on things which deliver more value to the organisation.

## Caveats

* By outsourcing responsibility you are also relinquishing some control.
* Performance tuning can be needed to achieve reliable “flat” response times both during very quiet and very busy periods.
* Special efforts may be needed to ensure services are "kept warm" at quiet times.
* At busy times, throttling or buffering throughput may be needed to avoid overwhelming any related systems which do not scale as elastically.

