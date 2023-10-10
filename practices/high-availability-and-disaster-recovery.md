# High Availability and Disaster Recovery

Cloud providers use specialised terminology to describe the logical and physical organisation of their data centers. The most important terms include:

**Data center (DC):** A physical data center. Cloud providers rarely reference individual DCs. Cloud provider DCs are typically built to a minimum of a Tier 3 standard (i.e., redundant fault-tolerant components in all aspects of the build, with expected uptime of 99.98% or more).

**Region:** A logical and physical grouping of DCs located within a broad metropolitan area. A region consists of one or more physical DCs. Each region has a distinct name. Cloud service control planes are typically regional. Consequently, API endpoints for cloud services are usually regional.

**Availability zone (AZ):** A type of logical DC within a region. A provider with an AZ architecture has multiple AZs in a region — usually at least three. These AZs are normally within synchronous replication distance of each other. AZs are engineered to be operationally autonomous of other AZs. In some providers, AZs may coexist within the same physical DC. In most providers, however, a region's AZs are located in physically distinct facilities — with independent power, networking, cooling and physical security — and are connected via a low-latency network (such as a fiber ring).

**Fault domain:** Most cloud services are designed with a partitioned structure. A partition (fault domain) is a logical and physical construct representing a pool of hardware governed by a software controller. Each hardware pool typically has independent power and network paths. Distributed computing or clustering techniques are used to spread a service's load across the fault domains. The partitioning aims to contain the "blast radius" of a fault. When a service is updated, the change is usually rolled out gradually, one partition at a time. Note that fault domains can be layered — meaning that a fault domain may be divided into lower-level fault domains.

**Compute instance:** A compute instance is usually a virtual machine (VM), but some providers also support bare-metal servers. When customers provision a compute instance, they choose a specific region and AZ. Compute instances always remain within that specified location. Most cloud providers use live migration to reduce the likelihood that maintenance activities will impact a VM, and most have the ability to automatically restart a failed VM on a healthy host. Most cloud providers offer a 99.9% single-instance service-level agreement (SLA) for availability. Cloud architects can assume that an individual VM will be as reliable as (or more reliable than) an on-premises VM.

**Spread instances:** Some cloud providers have constructs that allow customers to specify that particular compute instances need to exist in different fault domains. Distributing clustered or load-balanced compute instances across different fault domains reduces the likelihood that an issue with an individual compute instance will result in a user-visible impact.

**Capacity guarantee:** Some cloud providers allow customers to purchase capacity reservations in particular regions or AZs, which guarantee (within the bounds of an SLA) that this capacity will be available to them on-demand. This may address concerns that capacity will not be available in the event of a widespread failure that impacts multiple customers, all of whom will want to recover in another location. Capacity guarantees are normally only for VMs, not for other services.

## 1. High availability is not disaster recovery

Reliability consists of two principles: resiliency and availability. The goal of resiliency is to return your application to a fully functioning state after a failure occurs. The goal of availability is to provide consistent access to your application or workload be users as they need to.

Both availability and disaster recovery rely on some of the same best practices, such as monitoring for failures, deploying to multiple locations, and automatic failover. However, Availability focuses on components of the workload, whereas disaster recovery focuses on discrete copies of the entire workload. Disaster recovery has different objectives from Availability, measuring time to recovery after the larger scale events that qualify as disasters. You should first ensure your workload meets your availability objectives, as a highly available architecture will enable you to meet customers' needs in the event of availability impacting events. Your disaster recovery strategy requires different approaches than those for availability, focusing on deploying discrete systems to multiple locations, so that you can fail over the entire workload if necessary.

You must consider the availability of your workload in disaster recovery planning, as it will influence the approach you take. A workload that runs on a single instance in one Availability Zone does not have high availability. If a local flooding issue affects that Availability Zone, this scenario requires failover to another AZ to meet DR objectives. Compare this scenario to a highly available workload deployed multi-site active/active, where the workload is deployed across multiple active Regions and all Regions are serving production traffic. In this case, even in the unlikely event a massive disaster makes a Region unusable, the DR strategy is accomplished by routing all traffic to the remaining Regions.

How you approach data is also different between availability and disaster recovery. Consider a storage solution that continuously replicates to another site to achieve high availability (such as a multi-site, active/active workload). If a file or files are deleted or corrupted on the primary storage device, those destructive changes can be replicated to the secondary storage device. In this scenario, despite high availability, the ability to fail over in case of data deletion or corruption will be compromised. Instead, a point-in-time backup is also required as part of a DR strategy.

## 2. High Availability

All providers align with service levels that provide availability from 99.9% to 99.999%. Depending on the degree of high availability (HA) that you want, you must take increasingly sophisticated measures along the full lifecycle of the application. Follow these guidelines to achieve a robust degree of high availability:

- Design the system to have no single point of failure. Use automated monitoring, failure detection, and failover mechanisms for both stateless and stateful components
  - Single points of failure (SPOF) are commonly eliminated with an N+1 or 2N redundancy configuration, where N+1 is achieved via load balancing among _active–active_ nodes, and 2N is achieved by a pair of nodes in _active–standby_ configuration.
  - There are several methods for achieving HA through both approaches, such as through a scalable, load balanced cluster or assuming an _active–standby_ pair.
- Correctly instrument and test system availability.
- Prepare operating procedures for manual mechanisms to respond to, mitigate, and recover from the failure.

For planning purposes, the failure types in order from most probable to least probable are:

- **Individual compute instance failure:** Individual compute instances can fail, usually due to problems with the underlying hardware. Your cloud provider's capabilities may mask hardware issues from your applications, but your applications should ideally be architected so that they are resilient to this kind of failure. Some compute instance types may offer the option of ephemeral local storage, the contents of which may not be preserved in certain hardware failure modes. Ensure you use persistent storage for any data that you want to be certain survives server failure.

- **Service failure:** A cloud service failure usually begins with an "elevated error rate" (as cloud providers typically phrase it in status dashboards) for one or more APIs associated with that service. The error rate may increase until the majority of service invocations fail or performance is severely degraded. A sufficiently high error rate may be indistinguishable from a complete outage. Service failures are usually triggered by a software bug. The longest outages are typically the result of a complex cascading series of uncaught bugs and misconfigurations that create a "perfect storm" where seemingly minor problems create a major failure. When a service fails or degrades, the scope of impact is typically restricted to a fault domain, AZ or region. However, some providers can potentially have multi-region or global outages in some services due to their architecture.
- **Fault domain DC failure:** A portion of a physical DC may fail, usually due to failure of "upstream" equipment — usually power equipment. This results in the failure of all compute instances within that fault domain or reduction in a service's capacity.
- **Full DC failure:** An entire physical DC can fail — usually due to major power problems, most frequently due to a weather-related incident. Such a failure eliminates some or all of the capacity in an AZ (and even a region if that is the only DC for the region). Most planning scenarios will assume the failure of all compute instances located in that DC. However, it is also possible for an entire DC to be cut off from the network; in this scenario, compute instances continue to run but cannot communicate with users.
- **AZ failure:** In some providers, all DCs in an AZ are clustered closely on a single campus (or the AZs are not physically distinct and are located within the same building). Therefore, there can potentially be a physical event that results in failure of the entire AZ. Most planning scenarios will assume the failure of all compute instances located in that AZ as well as any services that are not multi-AZ.
- **Regional failure:**  The most likely cause of the effective failure of an entire region would be an issue that disrupts network connectivity across a region, such as a distributed denial of service (DDoS) attack or a routing misconfiguration. In such a case, compute instances would likely continue to run but would not be able to communicate with users.
- **Geo failure:** Because multiple regions within a geography may share common logical or physical network dependencies, there can be network incidents that impact two or more regions simultaneously.
- **Regional disaster:** In theory, there could be a physical event that impacts an entire metropolitan area and all of its data centers — for instance, a nuclear missile attack. Some organizations consider the possibility of a nation-state or terrorist attack that destroys multiple data centers in a region in a coordinated fashion. Most other failures are transient and should be expected to last for less than 24 hours. However, when planning for a regional disaster, assume the region will be unavailable for at least a week, necessitating the activation of your DR plan.
- **Total provider loss:** While it is theoretically possible for a cloud provider to fail catastrophically, abrupt loss of a provider's services would more likely be due to regulatory changes, economic sanctions or other geopolitical circumstances.

There are three special cases of failure that have a variable blast radius:

- **Provisioning failure:** A provisioning failure occurs when the provider runs out of capacity. Control plane problems can also result in the temporary inability to provision compute instances or provision a new instance or configuration of a service (such as creating a new message queue), or the inability to alter the configuration of the service. Provisioning failures do not impact running compute instances. However, depending on the underlying cause, provisioning failures can potentially span an AZ or a region. Provisioning failures are most impactful for organizations that are performing continuous deployment or frequently have autoscaling events.
- **Network failure:** A network failure may occur due to a configuration issue, a routing problem or a physical issue (such as a fiber cut). The blast radius of a network failure varies widely. A failure might affect part of a data center, an entire data center, multiple data centers on a campus, an entire availability zone, most or all of a region, or multiple regions in a geography. In rare cases, a network failure might result in global traffic issues. Network failures may affect only internet traffic, only traffic within the cloud provider's network, or both. However, keep in mind that for application users, if they cannot reach the application over the network, a network failure is functionally equivalent to complete failure and should be treated as such.
- **Core dependency failure:** Cloud provider services almost always have dependencies on internal core services such as identity, security certificates, Network Time Protocol (NTP) time or Domain Name System (DNS) resolvers. Failure of such a service may result in control plane failure (and sometimes full or partial service failure) across most (and possibly all) of the provider's services. The span of such failures depends on the provider's architecture. Some services might have a regional architecture, so such failures should only impact a single region. Others may have a global architecture, so such failures can potentially impact all services worldwide. However, in such failures, compute instances generally continue to run and communicate with the network, which may limit the impact on applications.

The five availability patterns are summarised as:

- **No HA:** The application runs without any redundancy.
- **Local HA:** The application runs in a single AZ, but achieves HA through redundant infrastructure.
- **Multi-AZ:** The application uses an active/active architecture distributed across at least two AZs. Many cloud provider services can be configured to span at least two AZs. Because AZs are typically within synchronous replication distance, it is relatively easy to keep data synchronized across the AZs.
- **Multi-region:** The application uses an active/active architecture distributed across at least two regions. Some cloud provider services support multi-region configurations, although these configurations often have caveats and limitations that do not apply to multi-AZ configurations. Notably, regions are almost always separated by enough distance that only asynchronous replication is possible, creating data architecture challenges.
- **Multi-cloud:** The application uses an active/active architecture distributed across at least two regions, and each of those regions is located in a different cloud provider. This is a rare, complex and expensive approach.

We recommend the following when implementing these patterns:

- **Fully automate provisioning.** When you fully automate provisioning for the primary site, you can usually easily reconfigure this automation to perform fully automated provisioning into the failover target. If you use a CI/CD pipeline, it should be able to target either environment — and, ideally, you should use IaC in an immutable infrastructure pattern. Fully automated cloud provisioning can potentially be extended to fully automated recovery, especially in conjunction with multi-AZ or cross-region cloud services.
- **Incorporate provisioning into your CI testing.** Fully automated provisioning into both the primary and failover locations should be tested as part of the CI pipeline. The IaC for the cloud resources should be treated as part of the code for the application, including being managed through the same artefact repository.
- **Periodically test failovers.** If you have fully automated recovery, you should be able to test failover and failback with minimal disruption to the application. (You can use a global load balancer to make this transparent to users, ensuring they are directed only to the live application.) If you are concerned that these failover mechanisms are so fragile that you cannot risk testing them, that should indicate to you that they are inadequately robust. Testing also helps ensure that no unidentified changes have broken the failover process. In environments with a high change velocity, failover-provisioning tests should be conducted at least once a month.

You should also consider promoting the following practices:

- **Adopt site reliability engineering principles.** SRE principles promote using problem management practices to drive continuous improvement in resilience so that applications reliably meet their agreed-upon service-level objectives. This requires close collaboration between application teams and operations teams. It includes the use of blameless post-mortems, coupled with a deep understanding of why systems fail, followed by addressing the root causes of outages and ensuring that any resulting resilience improvements are applied systemically across the organization's application portfolio.
- **Adopt staged rollouts.** CI/CD tools and application release orchestration tools may support staged rollouts — an application release model in which a new version of an application (or a component, microservice or service configuration) is released while the old version is still running. The most common forms of this are blue-green and canary deployments. Canary deployments are particularly useful when an application runs across multiple clusters, AZs and regions; the rollout should be gradual across these natural partitions. Staged rollouts lowers the risk of a change to software versions or configurations. When such automation exists for an application, all deployments should go through this process, even changes that are assumed to be low risk.
- **Use chaos engineering tools and techniques**  to test an application's resilience to cloud service failures. Chaos engineering in its "pure" form involves fault injection into production environments in order to observe system response and verify resilience. However, this is risky — especially if your system isn't already very resilient. Instead, organizations increasingly use chaos engineering tools to simulate faults in testing environments. Tools such as Gremlin and ChaosBlade can be integrated with CI/CD pipelines to automate chaos testing. Cloud providers also offer chaos engineering tooling as a service, such as the AWS Fault Injection Simulator and Azure Chaos Studio.

More details can be found at the following:

AWS - [https://docs.aws.amazon.com/whitepapers/latest/real-time-communication-on-aws/high-availability-and-scalability-on-aws.html](https://docs.aws.amazon.com/whitepapers/latest/real-time-communication-on-aws/high-availability-and-scalability-on-aws.html)

Azure - [https://learn.microsoft.com/en-us/azure/architecture/high-availability/building-solutions-for-high-availability](https://learn.microsoft.com/en-us/azure/architecture/high-availability/building-solutions-for-high-availability)

## 3. Disaster Recovery

Disaster recovery is the process of preparing for and recovering from a disaster. An event that prevents a workload or system from fulfilling its business objectives in its primary deployed location is considered a disaster. Understanding best practices for planning and testing disaster recovery for any workload, and different approaches to mitigate risks and meet the Recovery Time Objective (RTO) and Recovery Point Objective (RPO) for that workload.

The required level of reliability for any solution depends on several considerations. Availability and latency SLA and other business requirements drive the architectural choices and resiliency level and should be considered first. Availability requirements range from how much downtime is acceptable – and how much it costs your business – to the amount of money and time that you can realistically invest in making an application highly available.

**Regional availability of the cloud provider:** region-to-region failover within a single cloud provider is the primary and most common use case. Thus, a secondary region must be located where users and applications can communicate with DR workloads without performance degradation or excessive networking costs. While the secondary region does not need to be from the same cloud provider, cross-vendor DR is not widely deployed due the complexities and incompatibilities between provider offerings. The distance between cloud regions is important because data replication latency and potential data loss will determine whether RPOs can be met.

**Specific services or functionality offered:** Both IaaS and PaaS are deployed with no direct access to underlying hypervisors or physical storage. Therefore, common data center mechanisms for storage- or hypervisor-based replication are not available. PaaS solutions may offer optional data replication and backup services that are specific to those services.

**Network access to cloud provider:** Sufficient network bandwidth required for data transfer, and acceptable latency between the primary and DR regions must be available for users or other applications that need to interact with the DR systems. Latency, performance, security, availability and costs are drivers to determining the best approach.

**Availability of skilled cloud resources:** Automating DR failover orchestration to meet aggressive RTOs requires a solid understanding of the cloud services, tools and APIs to provision and manage them. When leveraging cloud-native data replication functionality, there is no coordination of workload failover or testing, so application start-up and dependencies need to be facilitated programmatically. If third-party tools are selected, installing and configuring them with an understanding of cloud subtleties and cost implications are required skill sets.

**Costs and licensing options:**  Standby DR infrastructure can be potentially minimized, with operational resources required only for DR testing or an actual DR event. The required RPOs, and particularly RTOs, of the organisation will heavily influence the DR infrastructure required (and thus the recurring costs of the DR environment). A more lenient RTO allows for minimal DR infrastructure to be running in a "waiting" state, thus enabling cost savings in the DR environment.

**Need for cloud provider exit strategy:** Different workloads may simultaneously be hosted in multiple clouds and on-premises. Determining whether different DR tools are best for each situation or whether a common toolset may also enable workload migration can be a key factor in selecting data replication and DR orchestration solutions.

## 3.1. Compute Services

### Amazon Web Services

Amazon Elastic Compute Cloud (Amazon EC2) provides the compute resources for running your workloads through specific CPU, memory and storage configurations. The availability SLAfor EC2 has two components: the uptime availability of an AWS region and of a single EC2 instance. For each single EC2 instance, the SLA is calculated based on an "hourly uptime percentage." For an AWS region, a "monthly uptime percentage" is used, based on minutes of downtime, which is considered a loss of external connectivity.

### Microsoft Azure

Azure Virtual Machines provide compute resources from a selection of CPU, memory and storage configurations. In regions where Availability Zones are provided, Microsoft recommends the use of two or more AZs when deploying VMs, and the SLA is written with this implementation in mind. For regions in which AZs are not yet available, Microsoft recommends that two or more VMs be grouped into an availability set. Availability set configurations ensure that, during either a planned or unplanned maintenance event, at least one VM is available to meet the SLA. VMs within an availability set are distributed across multiple fault domains and are deployed onto different hosts, compute racks, storage units and network switches, each with different maintenance windows.

## 3.2. Storage Services

### Amazon Web Services

AWS storage services include block, object and file storage options. Amazon Elastic Block Store (EBS) provides persistent storage for EC2 virtual instances. EBS volumes are replicated within the AZ in which they reside, but there is no native data replication capability for EBS storage across regions. However, snapshots of an EBS volume can be created and are stored on the Amazon Simple Storage Service (S3). The Amazon Data Lifecycle Manager feature enables automation of the creation, retention, and deletion of snapshots of Amazon EBS volumes, as well as automating the copying of these snapshots between regions. This allows customers to fully automate the life cycle of EBS snapshots so they can be created at desired intervals and retained for required periods of time.
 S3 is the AWS object storage service that is automatically replicated between AZs and optionally can be configured for cross-region replication. S3 is offered in several different storage classes:

- **Standard:**  Designed for high durability, low latency and high throughput.
- **Intelligent Tiering:**  For use with objects with unknown or changing access patterns. AWS will automatically move objects between different storage classes (with different pricing models) to optimize costs.
- **Infrequent Access:**  Designed for objects that are accessed less frequently. Retrieval charges are higher than for Standard. There is also a "one zone" variant of this service that reduces object durability but further decreases costs.
- **Glacier:**  For use with objects that need to be stored, but are unlikely to be accessed with any regularity (i.e., audit/compliance records, etc.). There is also a "deep archive" variant of this service that has longer retrieval times but lower costs.

For network-file-based access, AWS also provides an Elastic File System (EFS) offering. EFS is a Network File System (NFS)-based service (based on the NFS version 4 protocol) that allows file system mounts for multiple instances to share data. EFS is supported only on Linux instances, and its data is distributed across multiple AZs to improve resiliency.

### Microsoft Azure

Azure provides several storage services for block, object and file access. Azure also provides several redundancy offerings for its storage:

- **Locally-redundant storage (LRS):** Data is copied synchronously three times within a single data center.
- **Zone-redundant storage (ZRS):** Data is copied synchronously across three Availability Zones (in regions in which AZs are supported).
- **Georedundant storage (GRS):** Data is copied synchronously three times within a single data center in the primary region (as with LRS). It is additionally copied asynchronously to a single data center in a secondary region (by default this is the other member of the paired region, as discussed previously)
- **Geo-zone-redundant storage (GZRS) [in preview as of the date of this research]:** Data is copied synchronously across three Availability Zones in the primary region (as with ZRS). It is then additionally copied asynchronously to a single data center in the secondary region

Azure also offers variants of GRS and GZRS (called RA-GRS and RA-GZRS) that enable read access to the data in the secondary region. As the data is asynchronously copied to the secondary region, the storage in this region should be considered eventually consistent, and applications should treat it as such.
 Azure's original storage offering was unmanaged disks, which required the customer to manage and maintain the associated storage account. The default (and recommended) disk type is now the managed disk offering, which eliminates the limits associated with storage accounts and allows for provisioned IOPS (PIOPS) for the ultra disk offering within the managed disk product. Managed disks provide predictable performance and snapshot capability, and they simplify disk management by handling the storage account. However, they have fewer options and are limited to LRS redundancy. Azure managed disks work in conjunction with the previously mentioned Availability Sets by ensuring that the disks of VMs in an Availability Set are sufficiently isolated from each other to avoid single points of failure. It does this by automatically placing the disks in different storage clusters. Microsoft also offers the StorSimple Snapshot Manager, which is a Microsoft Management Console (MMC) "snap-in" that enables the customer to develop snapshot creation, retention and deletion policies.
 Azure provides an object storage offering called Azure Blob Storage. As with other object storage offerings, Azure Blob Storage can be used for storing large quantities of unstructured data, with sizes ranging up to greater than 4TB per object. Azure Blob Storage can be configured to store objects in any of Azure's standard replication models (LRS, ZRS and GRS). Additionally, Azure Blob Storage is offered in different service tiers (with different price points) depending on the frequency in which the data is accessed, including Premium, Hot, Cool and Archive.

## 3.3. Network Services

### Amazon Web Services

AWS enables customers to define private IP spaces via their virtual private cloud (VPC) offering. Internet gateways can be added to route communication between VPCs and the internet. Other network services include DNS (Amazon Route 53 DNS) and load balancing (AWS Elastic Load Balancing). Leveraging these services for workload availability is discussed in sections to follow.

### Microsoft Azure

Azure also enables a private IP space with its Azure Virtual Network offering. Additionally, Azure provides a load balancer service that distributes incoming requests to back-end VM instances. Azure DNS is a hosted DNS service, and along with Azure Traffic Manager is able to direct client communication based on different routing methods both locally and globally. Traffic Manager plays a key role in Azure SQL Database Active Geo-Replication, to be described in a section to follow.

## 3.4. Data Redundancy/Replication

### Amazon Web Services

As previously discussed, the Amazon EBS service replicates data within regions and snapshots that can be optionally replicated across regions. These snapshots can be attached to the original VM or an alternate VM, but only make the application data available. Reconfiguring and restarting applications after the failover are separate processes, and are discussed in sections to follow.

### Microsoft Azure

Azure provides three redundancy options for local, zone and region-based copies. Georedundant storage replicates data to the secondary region within the paired region. Updates are synchronously committed in the primary region and then asynchronously replicated to the secondary region. It is important to note that read/write access to a replica copy of data is not available unless Microsoft (or the customer) initiates a failover to the secondary region. If RA-GRS is in use, then data can be read from the primary storage account and optionally copied to an alternate storage account.

## 3.5. VM Auto Restarts

### Amazon Web Services

Amazon's CloudWatch service can be used to monitor Amazon EC2 instances and automatically recover a faulted instance. CloudWatch can detect the failed system and provide the option to notify the users or, optionally, restart the instance. Although CloudWatch should be a component of any DR plan affecting AWS resources, third-party monitoring tools and/or services should be utilized as well. This is to address the possibility of CloudWatch being affected by the same event driving the need to execute the DR plan. It is important to note that many third-party services operate in AWS as well, and as such, regardless of which tools are used, a separation of the "watcher" and the "watched" must be implemented in any monitoring solution.
 Amazon Machine Image (AMI) templates can be utilized to decrease launch time of VMs. However, the use of AMIs often involves additional OS patches, software packages and configuration details to be "bundled" into the image. Although this configuration does decrease boot time, it is not a recommended best practice in most scenarios because it becomes the organization's responsibility to keep these images up to date with the latest versions, patches and so on. For static, unchanging environments, bundled AMIs may be appropriate, but for the vast majority of use cases, a more flexible configuration management approach (some of which are described below) is required. An AMI created in one region is not automatically available in other regions, but it can be copied to a DR region using the AMI Copy feature. As such, if using AMIs for DR purposes, the organization is required to keep the source AMI up to date as well as to copy the updated AMI to the DR region.
 AWS CloudFormation provides a mechanism for infrastructure as code (IaC) in that the desired infrastructure of an application can be captured in a JSON or YAML text file. This file (known as a CloudFormation Template [CFT]) can be submitted to the CloudFormation service, which will provision the resources specified in the template. However, the configuration of the applications residing on those resources still needs to be accomplished via a separate process or tool.

### Microsoft Azure

Azure Monitor can be used to check the health of Azure resources and restart them based on predefined actions or Azure Automation Runbooks. These VMs can be restarted from a basic OS image and then configured using any number of configuration management and DR orchestration methods (some to be discussed below), or they can be launched from "managed images." Similar to the "bundled AMI" in AWS, the same caveats apply when using managed images. These include the need to keep images up to date with packages and application versions and the need to copy these images from the primary region to the DR region. Azure's GRS replication option enables data on block volumes to be available in the DR region, so no extra automation needs to be established as with other offerings in which snapshots need to be copied from region to region.
 Azure Resource Manager (ARM) Templates can be leveraged to quickly provision DR resources and their dependencies. The Azure Resource Manager groups Azure resources that can be deployed, updated or deleted in a single, coordinated operation. As with other templating services, configuration management may be required (if non-managed instances are used) on the resources deployed with the Resource Manager service.

## 3.6. Network and Load-Balancing Services

### Amazon Web Services

Amazon Route 53 provides a hosted DNS service that can be leveraged to improve availability. This DNS service provides high availability and contains traffic flow policies for directing IP requests to the available VMs or to VMs that may have geographic proximity to the requestor. The service is able to detect faulted VMs and update DNS entries to reroute traffic as needed.8
 AWS Elastic Load Balancing automatically distributes incoming application traffic across multiple targets, such as Amazon EC2 instances within an AZ or in multiple AZs. Load balancing can be combined with DNS-based weighted load balancing to support cross-region or on-premises resources using multiple load balancers, with one load balancer for each AWS region and a separate load balancer for on-premises resources. Although this load balancing can be achieved across regions, this is typically only an appropriate implementation for stateless applications or those in which eventual consistency of the data store is acceptable.

### Microsoft Azure

Azure DNS is Microsoft's hosting service for DNS domains. When used in combination with the Traffic Manager service, DNS requests can be routed to the most appropriate endpoint. This can be done based on the traffic routing method specified by the customer, as well as by the health of the endpoints, which is monitored by the Traffic Manager service.
 Azure Load Balancer can route external and internal traffic or forward external traffic to a specific VM. It can also provide service monitoring and automatically reconfigure its traffic routing when unhealthy instances are detected or VMs are added or removed via scale sets.

## 3.7. Database Options

### Amazon Web Services

Amazon RDS includes a choice of the most common and popular database engines, currently including MySQL, PostgreSQL, MariaDB, Oracle, Microsoft SQL Server, and Amazon Aurora (developed by AWS to better utilize its underlying infrastructure). Each variant provides a multizone, high-availability deployment option.
 Figure 5 illustrates the multi-AZ RDS model. It is important to note that both the primary database server and the replica database server, although in different AZs, are in the same region. This architecture promotes HA and enables BC, but for DR purposes, a separate region is required, which is enabled by cross-region replication.

Because cross-region replication is accomplished asynchronously, monitoring the "Replication Lag" metric in Amazon CloudWatch (or a similar monitoring tool) to ensure replication times do not exceed RPO requirement thresholds is recommended.
 With Amazon Aurora, data is stored in six copies across three availability zones in the region, and continuously backed up to Amazon S3. Each database can have up to 15 asynchronous read replicas, which all share the same storage and are used for read scaling and failover (failover typically takes less than 30 seconds). Placing read replicas in different availability zones for increased resiliency is recommended. An Aurora database can also be extended to up to five additional regions (Aurora Global Database) with a typical RPO of one second and an RTO of less than one minute and with no performance impact on the primary region.

### Microsoft Azure

Many applications that run on the Microsoft stack of services and technologies leverage Microsoft SQL Server. Azure offers a managed version of SQL Server called Azure SQL Database, which can be configured in several different replication configurations. The premium version of this service supports multiple redundant replicas for each database that are automatically provisioned in the same data center within a region. For Azure regions in which availability zones are offered, the premium version replicates data to multiple AZs within the region. These configurations support HA and BC and are recommended best practice implementations. For DR planning purposes, Azure SQL Database "active geo-replication" should be utilized. This feature allows you to create readable secondary databases of the primary SQL Database server in different Azure regions. Up to four secondary servers can be created, with each of these being in the same or different regions.

Replication to different regions is accomplished asynchronously, so replication lag should be monitored. Azure Monitor, in combination with Azure SQL Analytics, can be used for advanced Azure SQL Database monitoring, including replication lag and other associated metrics.

## 3.8. DR Orchestration

These solutions bundle DR orchestration capability with continuous replication to provide fast recovery and minimal data loss. These tools have become the foundation for many DRaaS offerings. These primarily support on-premises to public/private cloud-based DR capability but are increasingly offering cloud-to-cloud DR solutions. These tools focus on virtual server protection and use a host-based agent or virtual appliance to enable replication. They offer asynchronous replication that is not tied to the underlying platform or hypervisor with the ability to convert system images among cloud-compatible formats (such as AMI). These third-party solutions allow automated failover for low recovery times without the need to integrate separate solutions for both failover and replication.

## 3.9. Database Replication

Most databases have built-in data replication capabilities that support log shipping, where data is copied and applied continuously to a backup database. RDBMS software can be configured to operate across multiple active ("hot") or standby ("warm") instances of the database. Database replication enables a level of active/active application processing by leveraging read-only copies of the secondary data. Read-only access to the data can be used for data protection (backup), test, development or analytics use without affecting the primary production database servers.

## 3.10. Cloud Storage Snapshot Managers

Cloud providers offer storage snapshot services with the ability to replicate those snapshots among regions. With the ability to create snapshot creation, retention and deletion policies that are automatically executed by the cloud provider.
 For volume shadow services (VSS)-based applications, snapshot managers can provide application-consistent snapshots.

## 3.11. Virtual-Storage-Based Replication

These on-premise appliances are backed by cloud storage and enable replication among appliances in different regions.

## 3.12. Fault Monitoring

### Amazon Web Services

Amazon CloudWatch collects and tracks metrics, monitors log files, and creates alarms and responses for cloud resources and applications. Visibility into performance, utilization and operational health is also provided. CloudWatch alarm actions can be used to automatically stop or reboot EC2 instances when performance issues are detected. The same IP address will be used for the rebooted instance because the restart occurs within the same availability zone.

### Microsoft Azure

Azure Monitor provides the status of Azure services and infrastructure and includes alerting, log monitoring/searching and service dependency mapping. Similar to AWS, alerts can be used to trigger actions, including PowerShell scripts or Azure Automation Runbooks, which can be integrated with Azure Functions to perform additional remediation actions.

## 3.13. Containerized Applications

Other modern deployment options further abstract the infrastructure and provide application portability. Containers, often based on Docker, virtualize the operating system to isolate each application and enable simplified deployment across a range of platforms. By encapsulating the necessary OS and application images, containers can be launched or restarted far more rapidly than traditional VMs. User-managed or CSP-managed container orchestrators create resilient and scalable environments for running containerized applications.
 The use of containers increases the portability and decreases the start-up time of cloud-based applications as compared to those same applications running on traditional VMs. For DR purposes, containers can simplify potential regional incompatibilities and decrease RTOs.

## 3.14. Serverless/Event-Driven Compute

Some applications can be designed to no longer require provisioning or managing VMs. Function as a service (FaaS) offerings such as AWS Lambda and Azure Functions allow applications to execute only when needed without worrying about the underlying infrastructure. Based on defined events or triggers, these services will automatically launch the application code on highly available compute resources that are managed by the provider and are distributed across availability zones. FaaS offerings also enable timer-based and event triggers to launch code on demand without the need for provisioning VMs or storage. Templates are available for a variety of trigger types and allow for integration with other providers and/or third-party services.
 The use of FaaS offerings increases the resiliency of an application in that the services are distributed by default among multi-AZ resources on the provider's platform. The operational burden of maintaining VMs and storage is removed from an organization, which allows those resources to be reassigned to other tasks. Although FaaS components can assist with the HA and BC of an application, these services are contained within a region, so the same functionality implemented by FaaS offerings needs to be replicated in the DR region. These same services are typically available in all regions of the cloud provider, but the setup and configuration of these resources needs to be managed and maintained.

## 3.15. Ensure Solution Will Meet Business RPO/RTO Requirements

The solution that is ultimately chosen may not meet every business and IT requirement, but achieving the necessary RPOs/RTOs is critical. These were derived from the updated BIA and agreed to by all key stakeholders. The RPO is typically more straightforward because the choice will be among periodic, synchronous or asynchronous continuous replication capability.
 Key considerations include:

- Recovery requirements
- Support for active/active configurations
- Network bandwidth availability and latency
- Alignment with cloud migration strategy
- Strategic vendor relationships
- Manageability
- Costs

Recovery times are more complicated due to variable application restart times, service dependencies and the DR orchestration method that is chosen. Pilot or proof of concept (PoC) deployments should be leveraged to understand failover times and overall solution viability.

## 3.16. Understand SLAs

Service-level agreements are generally written to benefit the provider. Cloud provider SLAs should be reviewed thoroughly, and any caveats and corner cases should be identified so that risks can be mitigated. Discussions with the CSP on the SLA may provide clarity, but organizations should not expect any modifications to existing SLAs based on their input. Many of the providers' SLAs with respect to VM availability require the deployment of redundant resources in multiple zones, thus incurring additional, recurring costs. Service SLAs are granular and specific to that service, so the overall application availability has no aggregate SLA. As such, the SLA for an application consuming multiple services should be viewed as the lowest level of the associated individual service SLAs.
For CSPs, if SLA breaches are proven, the penalties are delivered via service credits. In many cases, these credits will not make up for downtime or costs to restore or recreate lost data.

## 3.17. Perform DR Exercises

As with any DR plan, finding gaps during a testing exercise is always preferable to finding them during recovery from an actual outage. Augment existing DR test plans and schedules to include any new cloud-based workload failover/failback testing. An ineffective DR exercise program will leave an organization inadequately prepared for a real disaster and can have significant consequences. Lessons learned need to be addressed by prioritizing follow-ups with sufficient resources to close those gaps.

## 3.18. Don't Assume That Data Is Protected

A misconception that some organizations have is that the resiliency of cloud infrastructure protects their cloud data as they migrate their workloads to the public cloud. CSPs are not responsible for user data or corporate content. Cloud providers are focused on the availability of their services, but clients are ultimately responsible for data availability. Service resiliency is not enough to protect against data loss or data corruption due to accidental deletion or misconfigured software or services. Unforeseen outages, malicious intent, or faulty software design can impact any highly available service. Although CSPs make every effort to preserve the data, these providers do not generally offer enterprise-grade backup with centralized policy-based schedules and retention or granular data restore options.
The customer service agreements for the large hyperscale providers clearly indicate that customers are responsible for their own data.

## 3.19. Network Latency to Failover Region

For region-to-region failover within the same cloud provider, the major CSPs provide solid network connectivity among regions to support data transfer and user access. These providers offer high-bandwidth, global network infrastructure to support regional networking with high availability and high network capacity.
Regardless of the robustness of these provider networks, bandwidth and distance between locations are critical factors in the viability of cloud-to-cloud DR. With periodic or asynchronous replication methods, performance impacts to the primary systems are minimized. However, bandwidth constraints or latency delays can lead to additional data loss in the event of disaster. RPOs need to be calculated with observed network latency factored into the equation because this lag may be a substantial consideration in the time to commit data to an alternate region.

## 3.20. Egress Costs

Implementing DR plans are similar in many ways to insurance — individuals need to decide how much they are willing to pay for something that they hope never occurs. As such, a complete and robust DR implementation will incur operational and procedural costs, with some of these costs being more substantial than others. In the calculation of DR costs, network costs are often forgotten. In particular, data transfers out of cloud provider regions or between one provider's regions are billable for AWS and Azure. For these providers, traffic between VMs within an AZ is at no cost, but there is a charge for data transfer between availability zones, as well as a higher cost for transfer to a different region.

AWS - [https://docs.aws.amazon.com/whitepapers/latest/disaster-recovery-workloads-on-aws/disaster-recovery-workloads-on-aws.html](https://docs.aws.amazon.com/whitepapers/latest/disaster-recovery-workloads-on-aws/disaster-recovery-workloads-on-aws.html)

Azure - [https://learn.microsoft.com/en-us/azure/reliability/overview](https://learn.microsoft.com/en-us/azure/reliability/overview)
