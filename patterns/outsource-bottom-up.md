# Outsource bottom up

- [Outsource bottom up](#outsource-bottom-up)
  - [Context](#context)
  - [The pattern](#the-pattern)
    - [Benefits](#benefits)
    - [Tradeoffs](#tradeoffs)
  - [Details](#details)
    - [Containers vs cloud functions](#containers-vs-cloud-functions)
    - [Data persistence](#data-persistence)
    - [Certificates](#certificates)
  - [Caveats](#caveats)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- This is related to:
  - [ARCHITECTURE-CLOUD](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/public-cloud-first)
  - [ARCHITECTURE-REUSE](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/reuse-before-buy-build)

## The pattern

Use managed services where available and appropriate. The aim is to reduce operational burden by handing responsibility to the cloud provider. They have made a business from doing this better than most organisations can.

### Benefits

- Reduced effort in building the "infrastructure" makes more time to build valuable business functionality.
- Reduced operational maintenance overhead.
- Improved reliability.
- Improved security.

### Tradeoffs

- Vendor lock-in
- Reduced technical choice
- New platforms to learn
- Less familiar development process

Our bet is that the benefits outweigh the tradeoffs.  On a spectrum between self-managed and entirely vendor-managed, solutions with more vendor management will tend to lock you in more, and make any future platform change harder. In return, we hope for a smaller solution overall, and getting new platform features faster.  Similarly the reduced technical choice in language runtimes, data infrastructure, or observability is compensated for by the support levels that the vendor-supplied options enjoy.

Sometimes we have a technical or legislative need to be closer to the self-managed end of the spectrum, and sometimes the ways of working necessary to use cloud products do not align with other engineering requirements, but our first instinct should be to offload responsibility for as much as possible to the vendor.

Some cloud-native choices inevitably imply specialising our solution for that one technology, which could create a degree of vendor lock-in.  For instance, for a particular use case AWS Lambda may allow you to deliver and operate far more cheaply than Kubernetes, but would require work to re-engineer if moving to a different cloud provider.

You need to understand and be able to justify a choice that creates vendor lock-in.  If the benefits of vendor lock-in outweigh the pain of being locked in, then being locked in is a good thing.  Similarly, when looking at the other side of the coin bear in mind that *any* migration between providers, whether from vendor-specific technology or generic, will be expensive because - at the very least - of data locality, access management, and uptime considerations.

The choice is between investing time early to build in mobility and deferring that effort (quite possibly forever) to focus on things which deliver more value to the organisation, but following the principle that nothing untested can be assumed to work, engineering principles dictate that you should have a plan to continue to assure that mobility as the project evolves.  If mobility is a required feature, that feature must be tested.

## Details

Always prefer software as a service (SaaS, e.g. Splunk, Jira), then serverless platform as a service (PaaS, e.g. Amazon DynamoDB, AWS Lambda, Texas, AWS Fargate), then infrastructure as a service (IaaS, e.g. cloud VMs). Cloud VMs are the least flexible option available to us, so should only be used if no other option can be chosen.

Similarly you should prefer solutions which do not require you to manage a network configuration.

### Containers vs cloud functions

If you have a choice as to whether to use functions as a service or a container platform for a part of your implementation, you should consider:

- Are you migrating an existing service, or implementing something new?  It may be easier to design a new service on cloud functions and cloud services than on a container platform.  Migrating an existing service may be easier if first moved to containers, then having appropriate parts extracted to cloud functions at a later date.
- Is there a software framework particularly well suited to your problem that better fits containers, or to cloud functions?  For instance, you may prefer the Django admin interface to having to build your own: this would be better suited to a container platform than on AWS Lambda.
- Implementations based on cloud functions can be harder to test, because you might not be able to instantiate service dependencies locally.  Is that important for your use case?  Do you have a good developer testing story otherwise?
- Is your implementation primarily plumbing between other services already in the cloud, with little logic of its own?  Is it primarily asynchronous?  A "yes" to either of these would point in the direction of cloud functions.
- Do you have specific language or runtime version requirements?  While these can usually be accommodated on cloud function platforms, there is additional work if your needs do not align with the platform-supplied runtimes.  You may find that this erases any advantage to cloud functions over containers.

### Data persistence

For data persistence, where there are no other differentiating factors, prefer pay per request options (e.g. Amazon DynamoDB, S3) over pay per time choices (e.g. Amazon Aurora or RDS).

Bear in mind that for higher-throughput applications where the usage would never scale to zero, or where cold start delays would be problematic, the difference between an autoscaling pay-per-time choice and serverless pay-per-request model may tilt in the other direction. The correct choice will depend on the differentiating factors of your specific application.

A more fundamental principle is that you should never send a document store to do a relational job.  Don't pick a NoSQL implementation when you need an RDBMS just because of the payment model: any savings you might expect from the payment model will result in a more expensive, slower, and more painful development experience.

### Certificates

Where possible, outsource the management (including renewal) of certificates (e.g. via [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/))

Where that isn't possible, still prefer outsourcing the management of alerting for certificate expiry (see [observability](../practices/observability.md))

## Caveats

- By outsourcing responsibility you are also relinquishing some control.
- Performance tuning can be needed to achieve reliable “flat” response times both during very quiet and very busy periods.
- Special efforts may be needed to ensure services are "kept warm" at quiet times.
- At busy times, throttling or buffering throughput may be needed to avoid overwhelming any related systems which do not scale as elastically.
- Do not assume that services calling yours will throttle or buffer.  Build in load shedding and rate limiting to protect your own service where needed.  While we aim to be good neighbours of our upstream APIs, failing gracefully in response to excess traffic is your responsibility.
