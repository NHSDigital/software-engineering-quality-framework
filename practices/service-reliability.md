# Service Reliability

## Context

* These notes are part of a broader set of [principles](../principles.md)
* This is related to [SERVICE-RELIABILITY](https://service-manual.nhs.uk/service-standard/14-operate-a-reliable-service)

## Details

* Understand reliability requirements.
    * Determine [service level indicators and objectives](https://landing.google.com/sre/sre-book/chapters/service-level-objectives/)(SLIs and SLOs) to represent these requirements.
    * Use SLIs and SLOs to drive monitoring and alerting requirements.
    * Agree an [incident severity classification](https://www.atlassian.com/incident-management/kpis/severity-levels) and the response which each level requires in terms of communication and resolution. Be pragmatic and don't overstate the requirements: targeting unnecessary levels of resilience is wasteful.
* Plan for failure.
    * Rehearse incident classification and resolution using regular [Game Days](https://aws.amazon.com/gameday/#:~:text=What%20is%20AWS%20GameDay%3F,gamified%2C%20risk%2Dfree%20environment.) and similar exercises.
    * Remember that service _reliability_ encompasses security, data integrity, performance, capacity and other factors as well as availability.
* Design for failure: assume everything will fail at some point, so:
    * Implement loose coupling where possible to minimise the impact of component failure.
    * Infrastructure should all be appropriately resilient (see [cloud services](cloud-services.md)).
* Services should scale automatically up and down (see [cloud services](cloud-services.md)).
* Releases should, where possible, not incur any service downtime.
* Monitoring must cover both application and infrastructure, and should include active monitoring of the healthcheck endpoint for each service and passive monitoring, e.g. of the HTTP response code reported from the load balancer.
* Application and infrastructure are encapsulated to guarantee consistency across environments.
* Prefer serverless infrastructure where possible, and any hosts should be ephemeral and immutable (e.g. nothing gets patched or reconfigured: instead a replacement is created).
* The only route to production is via automated deployment pipelines (see [continuous integration](continuous-integration.md)).
* Choose technologies and architectures which foster reliable operations (see [architect for flow](../patterns/architect-for-flow.md)).
* Make use of external good practice guides and reviews such as the [AWS](https://aws.amazon.com/architecture/well-architected/) or [Azure](https://azure.microsoft.com/en-gb/blog/introducing-the-microsoft-azure-wellarchitected-framework/) Well-Architected Frameworks.