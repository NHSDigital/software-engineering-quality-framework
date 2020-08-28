# Governance as a side effect

## Context

* These notes are part of a broader set of [principles](../principles.md)

## The pattern

Automate preventative measures and ongoing compliance checks to ensure systems meet governance requirements.

## Benefits

* More efficient and effective than manual controls.
* Continuous assurance.
* In many cases can prevent noncompliance at source.
* Allows changes to be made faster and with more confidence.

## Caveats

* Automated governance and compliance processes should enable, rather than hinder rapid delivery of change. Pragmatism and a risk-based approach are essential to avoid hamstringing delivery teams through overly burdensome or poorly implemented governances processes.

## Details

### Prevention

* Permissions systems like AWS IAM can prevent users from performing undesirable actions, e.g. restricting which resource types can be created and in which regions and to enforce minimum security requirements such as mandatory use of multi-factor authentication. Over time, new tools have emerged to make management of some of these concerns easier, as outlined below.
* Tools like AWS Config can enforce more fine grained policies such as [ensuring resource tags are present](https://docs.aws.amazon.com/config/latest/developerguide/required-tags.html), [WAF is used](https://docs.aws.amazon.com/config/latest/developerguide/alb-waf-enabled.html) or that [CloudTrail is enabled](https://docs.aws.amazon.com/config/latest/developerguide/cloudtrail-enabled.html).
* AWS [Control Tower](https://aws.amazon.com/about-aws/whats-new/2019/06/aws-control-tower-is-now-generally-available) allows clearly defined rules to be created for security, operations, and compliance that prevent deployment of resources that don't conform to policies and continuously monitor deployed resources for nonconformance.
* Permissions models and workflows in other tools (e.g. issue tracking, source control, continuous integration) ensure the agreed quality process is followed consistently.

### Audit and alert

Properly configured tooling supports good practice and provides an audit trail through the whole software delivery lifecycle:
* Use of an issue tracking system such as Jira ensures changing requirements are visible over time.
* Use of issue references in source control commit messages (which can be enforced with commit hooks) ensures code changes can be traced back to a business requirement.
* Source control systems provide visibility of who changed what when, and enforce and record peer review approvals.
* Continuous integration systems record the result of build and test stages as well as deployments to each environment, including who did what when.
* Integration of CI/CD systems with change management systems ensures a consistent view of changes are visible.
* Cloud platforms provide logs of changes to resources, e.g. AWS CloudTrail.

Where prevention is impracticable or impossible (because we are not in control of external sources of change), monitoring and alerting is an alternative approach:
* As well as preventative measures, AWS [Control Tower](https://aws.amazon.com/about-aws/whats-new/2019/06/aws-control-tower-is-now-generally-available) continuously monitor deployed resources for nonconformance and can alert when detected.
* Alerts may be configured for specific events reported in CloudTrail.

## Examples

* Interactions with change management process / tools, e.g. automatic creation of a change record via API as part of the CI/CD process.
* Interactions with architecture repository process / tools, e.g. automatic association in an architecture repository of a service with the technologies it uses via API as part of the CI/CD process.
* Shift-left with [compliance-as-code](https://aws.amazon.com/products/management-tools/).
  * e.g. using AWS Control Tower, AWS Organisations, AWS Service Catalog, AWS Config, AWS CloudTrail.
