# Observability

## Context

* These notes are part of a broader set of [principles](../principles.md)
* Practices in this section contribute to [service reliability](service-reliability.md) and relate to [cloud services](cloud-services.md)

## Details

* Ensure you have observability of your own service:
  * Monitoring must cover both application and infrastructure, and should include active monitoring of the healthcheck endpoint for each service and passive monitoring, e.g. HTTP response codes reported from load balancers
  * Define what healthcheck endpoint should do before returning: is it just a 200 HTTP check, or does it check databases, dependant systems, etc. too?
  * Consider other active monitoring: e.g. running automated test packs over production
  * Monitor (and generate alerts for) the expiry dates of the SSL certificates within the service
  * Use Application Performance Management ([APM](https://en.wikipedia.org/wiki/Application_performance_management)) tools to assist the team to diagnose faults
  * Traceability of user requests through the all layers of the application must be implemented
  * Consider client-side observability tools as well, in particular for client-side observability of browser-based services (EUM)
  * Ensure the retention timescales for monitoring data are known and the implications understood, and:
    * Where using ephemeral infrastructure, observability of recently-destroyed infrastructure must be implemented
* Ensure you have visibility of the health of *all* dependencies to your service, including:
  * Subscribe to service alerts from your cloud vendors, e.g. the service-status RSS feeds for [AWS](https://status.aws.amazon.com) and [Azure](https://status.azure.com/status/)
  * Ensure you have reporting and alerting for the health of any services/components your service relies on (for example: shared network connections, shared authentication services, etc)
  * See 'meaningful availability' in [service reliability](service-reliability.md)
* Implement a dashboard for the [service level indicators and objectives](https://landing.google.com/sre/sre-book/chapters/service-level-objectives/) - see [service reliability](service-reliability.md)
* Secret / sensitive data
  * Be careful of secret (e.g. credentials) or sensitive (e.g. person-identifiable data) when collecting and presenting monitoring / alerting information. Only data relevant to the consumer should be presented.
* Alerting
  * Alerts must be generated for events that the team (including 1st, 2nd line) consider high importance
  * Alerts must not be generated for any other reason (minimise noise)
  * Alerts must be in an appropriate form depending on who is consuming them (Email, SMS, Teams, Slack, Physical Alarm-Bell, Alexa, etc)
  * Alerts are important, and the alerting service(s) must be resilient. For essential (i.e. service critical) alerts, use more than one alerting tool, at least one of which should be a SaaS solution run out of multiple geographic locations
    * Do not include secrets or other sensitive data in alert requests, i.e. store no sensitive data with alerting providers
