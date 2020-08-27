# Governance as a side effect

## Context

* These notes are part of a broader set of [principles](../principles.md)

## The pattern

Automate preventative measures to ensure systems meet governance requirements.

## Benefits

* More efficient and effective than manual controls.
* Continuous assurance.
* In many cases can prevent noncompliance at source.
* Allows changes to be made faster and with more confidence.

## Details

### Prevention

* Permissions systems like AWS IAM can prevent users from performing undesirable actions, e.g. restricting which resource types can be created and in which regions and to enforce minimum security requirements such as mandatory use of multi-factor authentication. Over time, new tools have emerged to make management of some of these concerns easier, as outlined below.
* Tools like AWS Config can enforce more fine grained policies such as [ensuring resource tags are present](https://docs.aws.amazon.com/config/latest/developerguide/required-tags.html), [WAF is used](https://docs.aws.amazon.com/config/latest/developerguide/alb-waf-enabled.html) or that [CloudTrail is enabled](https://docs.aws.amazon.com/config/latest/developerguide/cloudtrail-enabled.html).
* AWS [Control Tower](https://aws.amazon.com/about-aws/whats-new/2019/06/aws-control-tower-is-now-generally-available) allows clearly defined rules to be created for security, operations, and compliance that prevent deployment of resources that don't conform to policies and continuously monitor deployed resources for nonconformance.

### Audit and alert

* Change management systems like service now
* cloud infra
* source control
* issue tracking
* ci/cd

## Examples

TO DO

* Interactions with change management process / tools
* Interactions with architecture repository process / tools
* Shift-left with [compliance-as-code](https://aws.amazon.com/products/management-tools/).
  * e.g. using AWS Control Tower, AWS Organisations, AWS Service Catalog, AWS Config, AWS CloudTrail.
