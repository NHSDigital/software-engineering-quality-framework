# Observability

## Context

* These notes are part of a broader set of [principles](../principles.md).
* Practices in this section contribute to [service reliability](service-reliability.md) and relate to [cloud services](cloud-services.md).

## In summary

* Observability supports operating **reliable services** by providing important insight into how a system is behaving. The three main aspects of observability are metrics, tracing and application logs.
  * Observability is not just something for when there is a problem: use observability tools throughout development, for example use monitoring tools to understand the performance and behaviour of changes _as they're developed_.
* Monitoring should be **clear and visible**.
  * Build dashboards for your [service level indicator](https://landing.google.com/sre/sre-book/chapters/service-level-objectives/) metrics which help you quickly and easily see if everything is OK &mdash; see [service reliability](service-reliability.md).
    * Keep dashboards clear and simple. Consider having a high level dashboard which helps you spot if something is wrong backed by more detailed dashboards to help diagnose the cause of the issue.
  * If you're not sure what to monitor, a good starting point are the [four 'golden signals'](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/): latency, traffic volume, error rate and saturation (e.g. of RAM or storage space).
  * Use a combination of active monitoring of the healthcheck endpoint for each service and passive monitoring, e.g. response times or HTTP response codes reported from load balancers or via metrics exposed from each component e.g. using a Prometheus-friendly `/metrics` endpoint.
    * Define what healthcheck endpoint should do before returning: should it just a simple "I'm alive", or should it check the database connection or dependant systems too?
    * Consider other active monitoring, e.g. running automated test packs over production using tools such as [Pingdom Transaction Monitoring](https://www.pingdom.com/product/transaction-monitoring/).
* Automated **alerts** should accurately alert you when things are wrong.
  * Aim for high precision (meaning few false alarms) and high recall (meaning few missed problems).
  * Treat every alert as important &mdash; either because something needs to be fixed, or because the alerting needs to be improved to improve precision.
  * Alerts must be in an appropriate form depending on who is consuming them (Email, SMS, Teams, Slack, Physical Alarm-Bell, Alexa, etc).
  * Alerting service(s) must be resilient. For essential service critical alerts use more than one alerting tool, at least one of which should run independently of your service's infrastructure.
* Choose your **tooling**.
  * Consider using an Application Performance Management ([APM](https://en.wikipedia.org/wiki/Application_performance_management)) tool such as [Instana](https://www.instana.com/), [DataDog](https://www.datadoghq.com/), [AppDynamics](https://www.appdynamics.com/), [New Relic](https://newrelic.com/) or others.
    * These tools include many powerful features and can be a quick route to gaining rich insight.
    * However, be aware that this is a crowded market and it is difficult to make an informed choice between the many available tools.
    * And make sure you understand the pricing model to ensure it will not lead to problematic practices in the name of cost saving, like only monitoring the production environment or only monitoring some parts of the system.
  * In cloud environments it is also worth considering whether the built in monitoring tools such as [Amazon CloudWatch](https://aws.amazon.com/cloudwatch/) provide adequate visibility as these are typically much cheaper.
  * It may also be worth considering free and open source alternatives such as [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/).
  * Ensure the retention timescales for monitoring data are known and the implications understood.
  * Where using ephemeral infrastructure, observability of recently-destroyed infrastructure must be available.
  * Consider client-side observability tools as well, in particular for client-side observability of browser-based services to provide [end user (or "real user") monitoring](https://en.wikipedia.org/wiki/Real_user_monitoring).
* Monitoring should be supported by **application logs** and possibly distributed **tracing**. These will help diagnose the cause if something goes wrong.
  * Logs should be easily accessible and searchable in a log aggregation system.
  * Agree log levels (e.g. DEBUG, INFO, ERROR) and use them consistently.
  * Consider using structured (i.e. Json formatted) log messages, as log aggregation systems can often perform more effective searches of these.
  * Tracing can be implemented using cloud platform-native tools like [AWS X-Ray](https://aws.amazon.com/xray/) or open source equivalents such as [OpenTracing](https://opentracing.io/docs/overview/what-is-tracing/). APM tools mentioned elsewhere also typically include tracing functionality.
* More **things to monitor**.
  * Monitor (and generate alerts for) the expiry dates of the SSL certificates within the service. See [acm-cert-monitor](../tools/acm-cert-monitor/) for an example lambda and Terraform stack to monitor your AWS ACM certificates.
  * Subscribe to service alerts from your cloud vendors, e.g. the service-status RSS feeds for [AWS](https://status.aws.amazon.com) and [Azure](https://status.azure.com/status/).
  * Ensure you have reporting and alerting for the health of any services/components your service relies on, e.g. shared network connections or shared authentication services.
* **Secret / sensitive data**.
  * Be careful of secret (e.g. credentials) or sensitive (e.g. person-identifiable) data when collecting and presenting observability information. Only data relevant to operating a reliable service should be stored and presented. In some cases this can include such data, but this is the exception, and in these cases it must be subject to the same governance and scrutiny as the source system.

# Background

## What is observability?

A system is said to be observable if its internal state is easily visible through external tools. The three main components of observability are:
* **Metrics**, which let you see in statistical terms how each component of the system is behaving.
* **Tracing**, which provide visibility of the path of individual requests through components of the system as well as derived aggregate statistics.
* **Application logs**, which contain important details of individual requests.

Metrics, and alerts triggered from them, are useful to understand _whether_ a service is healthy and are important for incident **detection**. Tracing and logs are most useful to understand _why_ a service is unhealthy and are important for incident **diagnosis and resolution**.

The [Site Reliability Engineering](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/) (SRE) book defines these terms:

> **Monitoring**<br/>
> Collecting, processing, aggregating, and displaying real-time quantitative data about a system, such as query counts and types, error counts and types, processing times, and server lifetimes.
>
> **Alert**<br/>
> A notification intended to be read by a human and that is pushed to a system such as a bug or ticket queue, an email alias, or a pager.

As DigitalOcean [says](https://www.digitalocean.com/community/tutorials/an-introduction-to-metrics-monitoring-and-alerting),

> Metrics represent the raw measurements of resource usage or behaviour that can be observed and collected throughout your systems ... monitoring is the process of collecting, aggregating, and analysing those values to improve awareness of your components’ characteristics and behaviour.

## What is monitoring for?

Monitoring serves three purposes:

1. Helps people such as support engineers and product managers understand how services are operating at a point in time and how metric values have changed over time.
1. Drives automated routines which maintain system health such as auto-scaling or failover.
1. Drives automated alerts which notify people when service reliability is impaired or at risk.

## What should you monitor?

For user-facing systems, the simple answer is "whatever matters most to your users", and more generally, "whatever most impacts your service's reliability".

### Four Golden Signals

Specifically, the most important metrics to monitor for user-facing systems according to the [SRE book](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/) are the four 'golden signals'.

> **Latency**<br/>
> The time it takes to service a request.
e.g. ms response time for an HTTP API.
>
> **Traffic**<br/>
> A measure of how much demand is being placed on your system, measured in a high-level system-specific metric.
e.g. Requests per second for an HTTP API.
>
> **Errors**<br/>
> The rate of requests that fail, either explicitly (e.g. HTTP 500s), implicitly (for example, an HTTP 200 success response, but coupled with the wrong content), or by policy (for example, "If you committed to one-second response times, any request over one second is an error").
e.g. 5xx errors per second for an HTTP API.
>
> **Saturation**<br/>
> How "full" your service is. A measure of your system fraction, emphasizing the resources that are most constrained (e.g. in a memory-constrained system, show memory; in an I/O-constrained system, show I/O). Note that many systems degrade in performance before they achieve 100% utilization, so having a utilization target is essential.

### Availability

The four Golden Signals represent things which can affect the service's _availability_.

Google's [meaningful availability paper](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/) has this to say about availability:

> A good availability metric should be _meaningful_, _proportional_, and _actionable_. By "meaningful" we mean that it should capture what users experience. By "proportional" we mean that a change in the metric should be proportional to the change in user-perceived availability. By "actionable" we mean that the metric should give system owners insight into why availability for a period was low.

Rather than blunt "uptime" measures, the paper proposes an interpretation of availability based on whether the service responds correctly within a defined latency threshold for each individual request. That is, it emphasises the importance of properly measuring partial failure and using metrics which measure real user experience.

## Dashboards

Monitoring dashboards are a primary way for people like support engineers and product managers to visualise and understand service health and behaviour.

![Grafana Dashboard](grafana-dashboard.jpg)

Dashboards should be easy to understand at a glance. Some tips to achieve this are:
* Limit the dashboard to a small set of individual graphs or charts, no more than 10.
* Restrict the number of individual metrics being shown on each chart, typically no more than 5.
* Make it obvious when things go wrong. Use fixed axes, rather than allowing them to rescale dynamically. Don't be afraid of choosing scales which make your dashboard looking boring when everything is fine &mdash; "boring" graphs just mean it's immediately obvious when things go wrong. Additionally, consider plotting fixed lines to indicate limits set out in service level agreements. For example, adding a horizontal red line to an average response times graph to indicate the agreed maximum response time makes it easy to spot when this limit is breached.
* Graphs have a big advantage in that they show changes over time. A CPU gauge might look cool but only displays one instance of a measurement at a time, so large spikes in CPU utilisation are easy to miss. The fact that graphs display changes over time means unusual spikes are easier to notice.
* Show related metrics together, and carefully consider placement of graphs on a dashboard. Graphs stacked on top of each other with the same x-axis unit make it easier to notice correlations between different things.
* Adopt conventions around use of colour and units (e.g. standardise on milliseconds for times and rates per second).
* Display metrics over an appropriate rolling time period (e.g. the last hour). It's important to get the right balance between providing enough context to understand trends in the data and providing a high enough resolution to accurately show metrics.
* Configure an appropriate refresh rate to ensure changes in metric values are seen promptly.
* Make a concious trade-off between indicating "long tail" performance vs representing the majority experience. For example, the 95th centile latency is usually a more useful indicator than either the mean or maximum latency, which under- and over-emphasise the worst case, respectively.

It is often a good idea to draw a clear distinction between:
* High level dashboards used to determine **whether** the service is healthy. These typically focus on business-meaningful metrics and _symptoms_ of service health.
* More detailed / lower level dashboards which show underlying _causes_. These help diagnose **why** a service is unhealthy once that has been determined.

Designing good dashboards is hard. Take the time to do it well. When faced with a production failure, well-designed dashboards can help resolve the incident much faster.

## Alerts

Alerts are triggered when rules applied to monitoring metrics evaulate to true. For example, if our business requirement is _"99% (averaged over 1 minute) of Get HTTP requests should complete in less than 100 ms (measured across all the backend servers)"_ then the corresponding alerting rule in [Prometheus format](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) could be `api_http_request_latencies_second{quantile="0.99"} > 0.1`.

We recommend using [Service Level Objectives](https://landing.google.com/sre/sre-book/chapters/service-level-objectives/) and [Error Budgets](https://landing.google.com/sre/sre-book/chapters/embracing-risk/) as the basis for alert rules.

> An SLI is a service level **indicator**: a carefully-defined quantitative measure of some aspect of the level of service that is provided.
>
> An SLO is a service level **objective**: a target value or range of values for a service level that is measured by an SLI.
>
> The error budget provides a clear, objective metric that determines how unreliable the service is allowed to be within a \[time period\]

The [Site Reliability Workbook](https://landing.google.com/sre/workbook/chapters/alerting-on-slos/) lists these attributes to consider when evaluating an alerting strategy:

> **Precision**<br/>
> The proportion of events detected that were significant. Precision is 100% if every alert corresponds to a significant event.
>
> **Recall**<br/>
> The proportion of significant events detected. Recall is 100% if every significant event results in an alert.
>
> **Detection time**<br/>
> How long it takes to send notifications in various conditions. Long detection times can negatively impact the error budget.
>
> **Reset time**<br/>
> How long alerts fire for after an issue is resolved. Long reset times can lead to confusion or to issues being ignored.

## Collecting metrics

The [SRE book](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/) discusses two types of monitoring:

**Clear-box monitoring**<br/>
> Monitoring based on metrics exposed by the internals of the system, including logs, interfaces like the Java Virtual Machine Profiling Interface, or an HTTP handler that emits internal statistics.

Examples include:
* Using [Prometheus](https://prometheus.io/) to scrape metrics from a component which uses a compatible metrics library to collect metrics and expose them on an HTTP endpoint.
* Amazon [CloudWatch Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html) exposes default metrics from AWS-provided services.
* Publishing internal metrics from a component as CloudWatch [custom metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html), either by pushing them to CloudWatch using the SDK or by using [metric filters](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/MonitoringLogData.html#search-filter-concepts) to extract metrics from application logs in [CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html).
* Using [Java Management Extensions](https://en.wikipedia.org/wiki/Java_Management_Extensions) (JMX) to collect internal metrics from an instrumented Java component.

**Opaque-box monitoring**<br/>
> Testing externally-visible behaviour as a user would see it.

Examples include:
* _Passive_ monitoring by a load balancer of the instances it is directing traffic to, in order to determine whether they are healthy. Here the load balancer observes the responses from real user requests as they happen and records factors such as response times and HTTP status codes.
* _Active_ monitoring of a service, where the monitoring system generates regular 'synthetic' requests to the service and observes the response to determine health.

## Commercial model

The pricing model for monitoring tools can have an undesirable influence on how the tool is used, especially if there is a cost per monitored instance. This can lead to some services not being monitored or some non-production environments not being monitored. It is far better to choose tools where this is not the case, so all services which should be monitored can be, and monitoring can be present in all non-production environments to encourage monitoring to be a first class consideration for the delivery team.

## Further reading

**Google Site Reliability Engineering book**: <https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/>

**Google Site Reliability Workbook**: <https://landing.google.com/sre/workbook/toc/>

**Digital Ocean An Introduction to Metrics, Monitoring, and Alerting**: <https://www.digitalocean.com/community/tutorials/an-introduction-to-metrics-monitoring-and-alerting>

**Datadog Monitoring 101**: <https://www.datadoghq.com/blog/monitoring-101-collecting-data/>
