# Engineering metrics

This is part of a broader [quality framework](README.md)

## Purpose & usage

These hard figures help us to measure the effect of improvement work over time, and should be tracked on a monthly basis.

Also, these metrics are intended to be considered as part of [engineering reviews](review.md). We recommend tracking these metrics on an Engineering Quality dashboard for teams to track their progress with improvements in line with the engineering reviews, for example:

![Example Dashboard](images/quality-dashboard.png)

These metrics are obviously limited to engineering concerns, and are only one part of the picture. For example, we don't want to build the wrong thing, even if we build it in a great way! We recommend that these metrics form part of a broader set of health indicators, including data relating to user satisfaction.

## Essential metrics:

These metrics provide a fundamental level of insight, and so must be tracked:

| Measure | Definition (each calculated over the last 28 days) |
|:---|:---|
| Deployment frequency | Number of deployments.
| Quality checks | Presence or absence of frequent, consistent, enforced (with agreed tolerances) of the [engineering quality checks](quality-checks.md) - follow that link for further details.

## Recommended metrics:

These metrics provide useful additional insight, and are recommended to be tracked:

| Measure | Definition (each calculated over the last 28 days) |
|:---|:---|
| Lead time | Median time between an item being started to when it is done.
| Change failure rate | Percentage of deployments which result in an incident.
| Overall incident rate: P1 | Total number of priority 1 incidents which occurred.
| Mean time to restore service: P1 | Mean time from priority 1 incident starting to when it is resolved.
| Overall incident rate: P1 | Total number of priority 2 incidents which occurred.
| Mean time to restore service: P2 | Mean time from priority 2 incident starting to when it is resolved.
| Overall incident rate: P3 | Total number of priority 3 incidents which occurred.
| Mean time to restore service: P3 | Mean time from priority 3 incident starting to when it is resolved.
