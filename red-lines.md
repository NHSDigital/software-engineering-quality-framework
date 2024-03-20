# Engineering red lines

The engineering principles, practices and patterns in this framework provide guidance around best-practice engineering.

There is a lot of this guidance - it's all important, but we consider some of these principles, and some specific practices related to them, to be especially significant and therefore mandatory requirements for the services we build: these are our engineering "red lines".

We have chosen to put in place a formal governance process for any exceptions to these red lines (including how frequently any exceptions need to be re-assessed), and any changes to this central list of red lines.

You will find references to the red lines throughout this framework (the references look like this: [**RED-LINE**](red-lines.md)) - and for convenience this list is the complete set of red lines.

## Cloud / Infrastructure

1. All new services must be developed on public cloud
    * Red line for the principle [overproduction &mdash; building when you could instead reuse or buy](principles.md#1-eliminate-waste) and the pattern [outsource from the bottom up](patterns/outsource-bottom-up.md)
    * Relates to the architecture principles [ARCHITECTURE-CLOUD](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/public-cloud-first) and [ARCHITECTURE-REUSE](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/reuse-before-buy-build)
    * For further details please see [cloud services](practices/cloud-services.md)
2. Development and test environments must not be run 24 by 7 and either need to be serverless so incur minimal charges when not being run or on demand and shutdown daily or run for less than 8 hours a day
    * Red line for the principle [inventory &mdash; unnecessary resources](principles.md#1-eliminate-waste)
    * Relates to the architecture principle [ARCHITECTURE-SUSTAINABILITY](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/deliver-sustainable-services)
    * For further details please see [cloud services](practices/cloud-services.md) ("services should scale automatically up and down", "infrastructure should always be fully utilised", etc)
