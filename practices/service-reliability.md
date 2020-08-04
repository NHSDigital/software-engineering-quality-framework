# Service Reliability

## Context

* These notes are part of a broader set of [principles](../principles.md)

## Principles

* Design for failure: assume everything will fail at some point, so:
    * Implement loose coupling where possible to minimise the impact of component failure.
    * Infrastructure should all be appropriately resilient, for example via tools such as [AWS auto-scaling groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html).
* Services should scale automatically up and down.
* Releases should, where possible, not incur any service downtime.
* Monitoring must cover both application and infrastructure, and should include active monitoring of the healthcheck endpoint for each service and passive monitoring, e.g. of the HTTP response code reported from the load balancer.
* Application and infrastructure are encapsulated to guarantee consistency across environments.
* Prefer serverless infrastructure where possible, and any hosts should be ephemeral and immutable (e.g. nothing gets patched or reconfigured: instead a replacement is created).
* The only route to production is via automated deployment pipelines.
* The same artefact flows across all environments (no special builds for production).
* Split services vertically (via domain driven design) rather than horizontally: for example, do not implement dedicated processes to update databases or configuration.
* Quality gates should be applied and evidenced by the build pipeline (not via manual processes).
