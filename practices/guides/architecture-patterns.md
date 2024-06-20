# Architecture patterns

This is an attempt to formalise decision process of how our services are built, specifically what Cloud Hosting Provider technologies are considered appropriate for different scenarios. The basis for this comes from the pattern of [Outsource bottom up]((patterns/outsource-bottom-up.md)).

Wherever possible we transfer the responsibility for management of infrastructure services from Customer (NHS England) to Cloud Hosting provider. This allows us to focus on solving the specific problems we need to solve rather than managing underlying infrastructure.

## Compute Selection

### Rule 1 Your Service MUST be built using __Function as a Service__ technologies
This is the default technology for building services using Cloud Hosting Services. The rationale for this is that it:

* Reduces the overhead of infrastructure management to an absolute minimum.
* Prevents the development of Monolithic applications.
* Has the ability to automatically scale to Zero, with fast start-up / scale-up times.
* Encourages a reduction in the size of deployable components.

Nothing comes for free, and the use of functions as a service requires acceptance of:

* More complicated infrastructure and observability
* Higher per-request cost
* A more limited choice of runtimes (or a more complicated build)
* The need for more contract and integration testing
* Vendor lock-in
* Less mature development options
* A lower performance ceiling for some execution patterns

Organisationally we believe that this trade-off is worth enforcing as a default.

Functions SHOULD be delivered as individual capabilities, rather than one function routing traffic internally to different capabilities (see for example this AWS anti-pattern).

Our preferred managed services are:

* [Azure Function Apps](https://learn.microsoft.com/en-us/azure/architecture/serverless-quest/reference-architectures)
* [AWS Lambdas](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/sample-architecture-patterns.html)


The following criteria permit __Rule 1__ to be broken

* The execution time of calls to your Service are likely to exceed that possible for a Function service
    * NB: This could suggest that your service could be refactored to reduce batch processing sizes?
* The data payload size required for operating your Service is beyond the limits of FaaS offerings
    * NB: This could suggest that your service could be refactored to reduce batch processing sizes?
* Your Service relies on other third party software being installed on the same OS that your code runs on

### Rule 2 Where Rule 1 can NOT be met, your Service MUST be built using __Managed Service Container__ technologies

Where it is not possible to build your service using FaaS, you MUST build it using one or more Containers. The rationale for this is that it:

* Reduces the overhead of infrastructure management.
* Has the ability to automatically scale up and down, with relatively fast start-up / scale-up times.
* Is portable, so can (to some extent) be run on different hosts.
* Encourages a reduction in the size of deployable components.

Our preferred managed services are:

* [AWS ECS](https://aws.amazon.com/ecs/)
    * Only where ECS can NOT be used, [EKS](https://aws.amazon.com/eks/) should be considered, this is because of the shift of management responsibility from Customer to Cloud Hosting provider that ECS offers over EKS.
* [Azure Container Apps](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/build-intelligent-apps-and-microservices-with-azure-container/ba-p/3982588) 
    * Only where Azure Container Apps can NOT be used, [Azure AKS](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-microservices/aks-microservices) should be considered, this is because of the shift of management responsibility from Customer to Cloud Hosting provider that Azure Container Apps offers over Azure AKS.

The following criteria permit __Rule 2__ to be broken

Your Service relies on other third party software being installed on the same OS that your code runs on

### Rule 3 - Where Rules 1 and 2 can NOT be met, your Service MUST be built on Cloud hosted Virtual Machines

Where your Service needs to be built on Virtual Machine Instances, then the following apply:

* Your Virtual Machines MUST be based on commodity images.

Only where Rules 1, 2 and 3 can NOT be met, your Service may be built using physical hardware.