# Service Reliability

## Context

* These notes are part of a broader set of [principles](../principles.md)
* This is related to [SERVICE-RELIABILITY](https://service-manual.nhs.uk/service-standard/14-operate-a-reliable-service)

## Details

* Understand reliability requirements.
    * Understand the implications of the designated service level for your service. NHS Digital service are classified as bronze, silver, gold or platinum and each has specific availability and recoverability requirements.
      * Part of this will be an incident severity classification, including the response which each level requires in terms of communication and resolution (example: [HSCN Consumer Handbook](https://digital.nhs.uk/services/health-and-social-care-network/hscn-consumer-handbook/service-levels-and-incident-severity-classification)).
    * As a multi-disciplinary team, determine [service level indicators and objectives](https://landing.google.com/sre/sre-book/chapters/service-level-objectives/) (SLIs and SLOs) to represent how these requirements apply specifically to your service. Also consider what else is important to users, and add SLIs and SLOs for these other aspects of service quality, such as response times and error rates.
    * Use SLIs and SLOs to drive monitoring and alerting requirements.
    * SLI metrics can also play a useful role in system autoscaling rules, alongside lower level metrics such as CPU load or I/O wait times. SLIs represent what matters most to users, but lower level metrics often provide leading indicators of situations which will impact SLIs if no action is taken.
    * Consider what constitutes [meaningful availability](https://www.usenix.org/system/files/nsdi20spring_hauer_prepub.pdf) for your service, and the ways in which the service could fall back to degraded states to avoid total loss of availability, e.g. switching to read only mode, serving some proportion of demand only using [load shedding](https://aws.amazon.com/builders-library/using-load-shedding-to-avoid-overload/), serving some classes of demand but not others, disabling some features.
    * Be pragmatic and don't overengineer against requirements. Targeting unnecessary levels of resilience is wasteful and reduces the team's ability to deliver functionality.
* Plan for failure.
    * Rehearse incident classification and resolution using regular [Game Days](https://aws.amazon.com/gameday/#:~:text=What%20is%20AWS%20GameDay%3F,gamified%2C%20risk%2Dfree%20environment.) and similar exercises.
    * Remember that service _reliability_ encompasses security, data integrity, performance, capacity and other factors as well as availability.
    * Perform regular (preferably automated) testing to ensure reliability, e.g. load testing, security testing (see [testing](testing.md)).
* Design for failure: assume everything will fail at some point, so:
    * Implement loose coupling where possible to minimise the impact of component failure.
    * Infrastructure should all be appropriately resilient (see [cloud services](cloud-services.md)).
* Services should scale automatically up and down (see [cloud services](cloud-services.md)).
* Releases should, where possible, not incur any service downtime.
* Breaking interface changes should be found before deploying to live through appropriate [testing](testing.md).
* Monitoring must cover both application and infrastructure, and should include active monitoring of the healthcheck endpoint for each service and passive monitoring, e.g. of the HTTP response code reported from the load balancer.
* Ensure alerting is in place for any upstream dependencies, for example services provided by cloud vendors (see [cloud services](cloud-services.md)).
* Application and infrastructure are encapsulated to guarantee consistency across environments.
* Prefer serverless infrastructure where possible, and any hosts should be ephemeral and immutable (e.g. nothing gets patched or reconfigured: instead a replacement is created).
* The only route to production is via automated deployment pipelines (see [continuous integration](continuous-integration.md)).
* Choose technologies and architectures which foster reliable operations (see [architect for flow](../patterns/architect-for-flow.md)).
* Make use of external good practice guides and reviews such as the [AWS](https://aws.amazon.com/architecture/well-architected/) or [Azure](https://azure.microsoft.com/en-gb/blog/introducing-the-microsoft-azure-wellarchitected-framework/) Well-Architected Frameworks.
