# Cloud asset tagging

## Context

* This snippet relates to the [cloud services](../practices/cloud-services.md) practices in this set of [principles](../principles.md)

## Details

### AWS

This configuration snippet generates an AWS CloudWatch rule for EC2 assets not tagged with the keys "CostCenter" and "Owner":

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

Further reading: [AWS CloudWatch](https://docs.aws.amazon.com/cloudwatch/index.html)

### Azure

* TO DO
