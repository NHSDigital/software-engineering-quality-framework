# Cloud services

## Context

* These notes are part of a broader set of [principles](../principles.md)
* Practices in this section contribute to [service reliability](service-reliability.md)
* This is related to:
  * [ARCHITECTURE-CLOUD](https://aalto.digital.nhs.uk/#/object/details?objectId=923e33f8-889d-42e5-a7d1-8b04b3e4220f&library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)
  * [ARCHITECTURE-SUSTAINABILITY](https://aalto.digital.nhs.uk/#/object/details?objectId=0a01622c-35fe-4670-9211-6a3f95497dd0&library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)
  * [SERVICE-TOOLS](https://service-manual.nhs.uk/service-standard/11-choose-the-right-tools-and-technology)

## Details

* Configure all infrastructure using declarative code such as Terraform and Cloudformation (see [everything as code](../patterns/everything-as-code.md)).
* Automate monitoring and alerting (see [automate everything](../patterns/automate-everything.md)).
* Make systems self-healing.
  * Prefer technologies which are resilient by default.
  * Favour global-scoped (e.g. [CloudFront](https://aws.amazon.com/cloudfront/) or [Front Door](https://azure.microsoft.com/en-gb/pricing/details/frontdoor/)) or region-scoped services (e.g. [S3](https://aws.amazon.com/s3/), [Lambda](https://aws.amazon.com/lambda/), [Azure Functions](https://azure.microsoft.com/en-gb/services/functions/)) to availability-zone (AZ) scoped (e.g. [VMs](https://azure.microsoft.com/en-gb/services/virtual-machines/), [RDS DBs](https://aws.amazon.com/rds/)) or single-instance services (e.g. [EC2 instance storage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html)).
  * For AZ-scope services, use redundancy to create required resilience (e.g. [AWS Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html) or [Azure Scale/Availability Sets](https://docs.microsoft.com/en-us/azure/virtual-machines/availability)).
  * Consider use of active-active configurations (e.g. [Aurora Multi-Master](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-multi-master.html)), but be aware of the added complexity conflict resolution for asynchronous replication can bring and potential performance impact where synchronous replication is chosen.
  * Understand failover (e.g. [RDS failover](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html#:~:text=Failover%20times%20are%20typically%2060%E2%80%93120%20seconds.)) and failed instance replacement times and engineer to accommodate these.
* Prefer serverless platform as a service (PaaS) over infrastructure as a service (IaaS) (see [outsource bottom up](../patterns/outsource-bottom-up.md)).
* Services should scale automatically up and down.
  * If possible, drive scaling based on metrics which matter to users (e.g. response time), but balance this with the benefits of choosing leading indicators (e.g. CPU usage) to avoid slow scaling from impacting user experience.
  * Understand how rapidly demand can spike and ensure scaling can meet these requirements. Balance scaling needs with the desire to avoid over provisioning and use [pre-warming](https://petrutandrei.wordpress.com/2016/03/18/pre-warming-the-load-balancer-in-aws/) of judiciously where required.
* Infrastructure should always be fully utilised (if it isn't, it's generating waste).
  * Though balance this with potential need to run with some overhead to accommodate failed instance replacement times without overloading remaining instances.
* Be aware of data sovereignty implications of using any systems hosted outside the UK.
  * Make sure your information governance lead is aware and included in decision making.
  * Consider SaaS tools the team uses as well as the systems we build.
* Understand and be able to justify vendor lock in (see [outsource from the bottom up](../patterns/outsource-bottom-up.md)).
* Build in [governance as a side effect](../patterns/governance-side-effect.md), e.g.
  * Segregate production and non-production workloads.
  * Infrastructure must be tagged to identity the service so that unnecessary resources don't go unnoticed.
  * Configure audit tools such as CloudTrail.
