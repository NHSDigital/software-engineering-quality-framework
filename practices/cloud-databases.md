# Cloud databases

- [Cloud databases](#cloud-databases)
  - [Context](#context)
  - [Details](#details)
    - [Infrastructure](#infrastructure)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- Practices in this section contribute to [service reliability](service-reliability.md)
- See also [observability](observability.md)

## Details

### Infrastructure

Successfully operating relational databases in a cloud environment, especially a serverless one, requires attention to the specific qualities of the database products as implemented by the cloud platforms.

- Do use a small number of long-lived server instances.  Do not create new servers per application environment.  Database servers can be very slow to instantiate, which means that tools like `terraform` can time out waiting for them to start.  Instead separate your infrastructure code between configuration for the application and configuration for the account, so that your servers are configured once per AWS account.  The `terraform` code that configures an application instance should provision its resources by calling into the already-provisioned server in the account to create environment-specific databases.
- Do manage your database migrations.  If you are using a web framework like Django, or Rails, you will have tooling built in to do this.  Otherwise, use a tool like `alembic` if several people are likely to be working on features which change the database structure at the same time. If your needs are simpler, you may find a more straightforward approach - storing SQL scripts and sequentially running them, for instance - works just as well with fewer dependencies.  If building a serverless application, deploy your migrations into a cloud function to be called by your `terraform` deployment.
- Learn how to refactor database schemas safely.  Several coupled migrations and code changes may be needed to successfully change the schema with no downtime.
