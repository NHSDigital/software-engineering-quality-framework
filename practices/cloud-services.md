# Cloud services

## Context

* These notes are part of a broader set of [principles](../principles.md)
* TO DO: Reference to the Tech Radar?

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