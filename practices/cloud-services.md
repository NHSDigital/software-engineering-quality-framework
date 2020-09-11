# Cloud services

## Context

* These notes are part of a broader set of [principles](../principles.md)
* This is related to:
  * [ARCHITECTURE-CLOUD](https://aalto.digital.nhs.uk/#/object/details?objectId=923e33f8-889d-42e5-a7d1-8b04b3e4220f&library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)
  * [ARCHITECTURE-SUSTAINABILITY](https://aalto.digital.nhs.uk/#/object/details?objectId=0a01622c-35fe-4670-9211-6a3f95497dd0&library=5464c07f-daf1-4eee-b9b6-22e6c4dfbbd0)
  * [SERVICE-TOOLS](https://service-manual.nhs.uk/service-standard/11-choose-the-right-tools-and-technology)

## Details

* Configure all infrastructure using declarative code such as Terraform and Cloudformation (see [everything as code](../patterns/everything-as-code.md)).
* Automate monitoring and alerting (see [automate everything](../patterns/automate-everything.md)).
* Make systems self-healing.
* Services should scale automatically up and down.
* Infrastructure should always be fully utilised (if it isn't, it's generating waste).
* Be aware of data sovereignty implications of using any systems hosted outside the UK.
  * Make sure your information governance lead is aware and included in decision making.
  * Consider SaaS tools the team uses as well as the systems we build.
* Understand and be able to justify vendor lock in (see [outsource from the bottom up](../patterns/outsource-bottom-up.md)).
* Build in [governance as a side effect](../patterns/governance-side-effect.md), e.g.
  * Segregate production and non-production workloads.
  * Infrastructure must be tagged to identity the service so that unnecessary resources don't go unnoticed.
  * Configure audit tools such as CloudTrail.
