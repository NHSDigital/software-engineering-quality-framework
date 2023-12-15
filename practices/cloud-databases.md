# Cloud databases

- [Cloud databases](#cloud-databases)
  - [Context](#context)
  - [Details](#details)
    - [Choosing the type of database you need](#choosing-the-type-of-database-you-need)
    - [Infrastructure](#infrastructure)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- Practices in this section contribute to [service reliability](service-reliability.md)
- See also [observability](observability.md)

## Details

### Choosing the type of database you need

Do not reflexively reach for a specific database product without considering whether it matches your use case.  In general you should prefer relational stores because of their feature set and design choices which make them broadly applicable.  Choose a non-relational store only if the trade-off makes sense for your application. An example would be needing extremely high write rates (in the range of millions of operations per minute) where eventual consistency is tolerable: in that case DynamoDB or equivalent may be appropriate.

Prefer to learn how to use the right tool for the job over picking the tool a team happens to be familiar with.

### Infrastructure

Successfully operating relational databases in a cloud environment, especially a serverless one, requires attention to the specific qualities of the database products as implemented by the cloud platforms.

- Do use a small number of long-lived server instances.  Do not create new servers per application environment.  Database servers can be very slow to instantiate, which means that tools like `terraform` can time out waiting for them to start.  Instead separate your infrastructure code so that your servers are configured once per AWS account.  The `terraform` code that configures an application instance should provision its resources by calling into the already-provisioned server in the account to create environment-specific databases.
- Do manage your database migrations.  Use a tool like `alembic`, or an alternative.  If building a serverless application, deploy your migrations into a cloud function that will be called by your `terraform` deployment.
- Learn how to refactor database schemas safely.  Several coupled migrations and code changes may be needed to successfully change the schema with no downtime.
