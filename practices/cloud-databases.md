# Cloud databases

- [Cloud databases](#cloud-databases)
  - [Context](#context)
  - [Details](#details)
    - [Infrastructure](#infrastructure)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- Practices in this section contribute to [service reliability](service-reliability.md)
- See also [observability](observability.md) and [cloud services](cloud-services.md#build-in-governance)

## Details

### Infrastructure

Successfully operating relational databases in a cloud environment, especially a serverless one, requires attention to the specific qualities of the database products as implemented by the cloud platforms.

- Reuse long-lived database server instances where appropriate within the product and production/non-production boundaries described in [cloud services](cloud-services.md#build-in-governance). Reuse does not mean sharing a server between production and non-production workloads or across products. Within those boundaries, environment-specific databases on a shared server can reduce provisioning overhead, provided they meet the workloads' isolation and operational requirements. Database servers can be slow to instantiate, which can cause infrastructure deployment tools such as Terraform to time out. Separate the provisioning of long-lived server infrastructure from application deployments, so that application infrastructure code can create environment-specific databases on an existing server where sharing is appropriate.

  Before sharing a server, consider:

  - **Access and data isolation:** Check that database permissions and administrative access provide the required separation. Separate database names alone do not establish an access boundary.
  - **Capacity and performance:** Assess whether one workload's resource consumption could affect another. Use representative load tests and monitoring to validate capacity and performance requirements.
  - **Failure and maintenance impact:** Consider which workloads would be affected by a server outage, failover or maintenance operation, and whether that shared impact is acceptable.
  - **Backup and recovery:** Verify that the database service supports the required backup and restore scope, and test recovery against each workload's recovery time and recovery point objectives. Establish whether restoring one database would affect others.

  If sharing cannot meet these requirements, use separate server instances within the relevant account or subscription. Provisioning convenience and cost savings should not override isolation or recovery requirements.

- Do manage your database migrations.  If you are using a web framework like Django, or Rails, you will have tooling built in to do this.  Otherwise, use a tool like `alembic` if several people are likely to be working on features which change the database structure at the same time. If your needs are simpler, you may find a more straightforward approach - storing SQL scripts and sequentially running them, for instance - works just as well with fewer dependencies.  If building a serverless application, deploy your migrations into a cloud function to be called by your `terraform` deployment.
- Learn how to refactor database schemas safely.  Several coupled migrations and code changes may be needed to successfully change the schema with no downtime.
