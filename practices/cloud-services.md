# Cloud services

- [Cloud services](#cloud-services)
  - [Context](#context)
  - [Details](#details)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- Practices in this section contribute to [service reliability](service-reliability.md)
- See also [observability](observability.md)
- This is related to:
  - [ARCHITECTURE-CLOUD](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/public-cloud-first)
  - [ARCHITECTURE-SUSTAINABILITY](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/deliver-sustainable-services)
  - [SERVICE-TOOLS](https://service-manual.nhs.uk/service-standard/11-choose-the-right-tools-and-technology)

## Details

- Configure all infrastructure using declarative code such as Terraform and CloudFormation (see [everything as code](../patterns/everything-as-code.md)).
- Automate monitoring and alerting (see [automate everything](../patterns/automate-everything.md) and [observability](observability.md).
- Prefer serverless platform as a service (PaaS) over infrastructure as a service (IaaS) (see [outsource bottom up](../patterns/outsource-bottom-up.md)).
- Where not serverless use ephemeral and immutable infrastructure.
- Engage your cloud supplier early on in the development process. They have various tools and processes to help you (e.g. [AWS Well-Architected Review](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc)).
- Understand cloud supplier SLAs.
- Make systems self-healing.
  - Prefer technologies which are resilient by default.
  - Favour global-scoped (e.g. [CloudFront](https://aws.amazon.com/cloudfront/) or [Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-overview)) or region-scoped services (e.g. [S3](https://aws.amazon.com/s3/), [Lambda](https://aws.amazon.com/lambda/), [Azure Functions](https://azure.microsoft.com/en-gb/services/functions/)) to availability-zone (AZ) scoped (e.g. [VMs](https://azure.microsoft.com/en-gb/services/virtual-machines/), [RDS DBs](https://aws.amazon.com/rds/)) or single-instance services (e.g. [EC2 instance storage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html)).
  - For AZ-scoped services, use redundancy to create required resilience (e.g. [AWS Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html) or [Azure Scale/Availability Sets](https://docs.microsoft.com/en-us/azure/virtual-machines/availability)), and:
    - For stateless components use active-active configurations across AZs (e.g. running stateless containers across multiple AZs using [AWS Elastic Kubernetes Service](https://aws.amazon.com/eks/))
    - For stateful components, e.g. databases, consider use of active-active configurations across AZs (e.g. [Aurora Multi-Master](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-multi-master.html)), but be aware of the added complexity conflict resolution for asynchronous replication can bring and potential performance impact where synchronous replication is chosen.
  - Consider use of multiple regions (e.g. for AWS eu-west-1 [Dublin] as well as eu-west-2 [London]) as a way to improve availability, though ensure data sovereignty implications are understood and accepted (see below).
  - Understand failover (e.g. [RDS failover](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html#:~:text=Failover%20times%20are%20typically%2060%E2%80%93120%20seconds.)) and failed instance replacement times and engineer to accommodate these.
- Be aware of data sovereignty implications of using any systems hosted outside the UK.
  - Make sure your information governance lead is aware and included in decision making.
  - Consider SaaS tools the team uses as well as the systems we build.
- Services should scale automatically up and down.
  - If possible, drive scaling based on metrics which matter to users (e.g. response time), but balance this with the benefits of choosing leading indicators (e.g. CPU usage) to avoid slow scaling from impacting user experience.
  - Understand how rapidly demand can spike and ensure scaling can meet these requirements. Balance scaling needs with the desire to avoid over provisioning and use [pre-warming](https://petrutandrei.wordpress.com/2016/03/18/pre-warming-the-load-balancer-in-aws/) of judiciously where required. Discuss this with the cloud provider well before go live they can assist with pre-warming processes ([AWS](https://aws.amazon.com/premiumsupport/programs/iem/)).
- Infrastructure should always be fully utilised (if it isn't, it's generating waste).
  - Though balance this with potential need to run with some overhead to accommodate failed instance replacement times without overloading remaining instances.
- Keep up to date.
  - Services/components need prompt updates to dependencies where security vulnerabilities are found &mdash; even if they are not under active development.
  - Services which use deprecated or unsupported technologies should be migrated onto alternatives as a priority.
- Understand and be able to justify vendor lock in (see [outsource from the bottom up](../patterns/outsource-bottom-up.md)).
- Build in [governance as a side effect](../patterns/governance-side-effect.md), e.g.
  - Segregate production and non-production workloads.
  - <details><summary>Infrastructure must be tagged to identity the service so that unnecessary resources don't go unnoticed (click to expand)</summary>

    AWS Config rule to identify EC2 assets not tagged with "CostCenter" and "Owner":

    ```yaml
    {
      "ConfigRuleName": "RequiredTagsForEC2Instances",
      "Description": "Checks whether the CostCenter and Owner tags are applied to EC2 instances.",
      "Scope": {
        "ComplianceResourceTypes": [
          "AWS::EC2::Instance"
        ]
      },
      "Source": {
        "Owner": "AWS",
        "SourceIdentifier": "REQUIRED_TAGS"
      },
      "InputParameters": "{\"tag1Key\":\"CostCenter\",\"tag2Key\":\"Owner\"}"
    }
    ```

    Further reading: [AWS Config](https://aws.amazon.com/config/)

    TO DO: Azure equivalent
  </details>

  - Configure audit tools such as CloudTrail.
