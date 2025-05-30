# Deliver little and often

- [Deliver little and often](#deliver-little-and-often)
  - [Context](#context)
  - [The pattern](#the-pattern)
  - [Benefits](#benefits)
  - [Details](#details)
  - [Examples](#examples)
  - [Caveats](#caveats)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- This pattern is closely related to the [architect for flow](architect-for-flow.md) pattern

## The pattern

Delivering "little and often" has broad benefits across the software delivery process:

- Incremental software changes: delivering many small software changes is [preferable](https://cloud.google.com/architecture/devops/devops-process-working-in-small-batches) to infrequent delivery of larger changes
- Incremental team operations: working incrementally (for example re-planning frequently and iteratively refining the architecture and technology choices) is preferable to large up-front planning and design, or long-running delivery cycles

## Benefits

- Increased safety and predictability:
  - Changing less at a time means there is less (per change) to go wrong
  - Frequently-run processes are more predictable (simply because they are run more frequently)
  - The automation which supports frequent changes means less exposure to human error
  - The automation which supports frequent changes supports quick responses if there is a problem
  - Quality checks are applied more frequently
  - Frequent changes make it easier to keep everything up to date
- Product / service design benefits:
  - Early visibility of changes
  - Early benefit realisation
  - Smaller changes should require less user training, user communications, etc
  - Helps service designers rapidly test hypotheses
- Cost (in the long term):
  - The automation which supports frequent changes means long-term savings on manual effort
  - Short-lived changes simplifies the technical delivery overhead (merge conflicts, etc)
  - Changing less at a time means less potential for obscure problems (which are difficult and expensive to find and fix)
- Happier delivery team

## Details

This pattern is in essence very straightforward; the power comes in applying it rigorously to everything you do. Judgement is needed when deciding how much to do up front, versus deferring to be done incrementally. But in general the aim should be to do the minimum possible up front and to defer anything which will not alter your immediate actions.

## Examples

- **Delivering software.** The trivial and obvious example of this pattern is that it is better to deliver software in small increments than to do it in one [big bang](https://hackernoon.com/why-your-big-bang-multi-year-project-will-fail-988e45c830af).
- **Planning.** Start by doing just enough planning to forecast the size and type of team(s) you need to get the job done roughly when you want it to be done by. Incrementally refine that plan through (typically) fortnightly backlog/roadmap refinement sessions.
- **User-centred design.** User research and design activities ([SERVICE-USER](https://www.gov.uk/service-manual/user-research), [SERVICE-DESIGN](https://www.gov.uk/service-manual/design)) occur in all phases of an agile delivery: [discovery](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works), [alpha](https://www.gov.uk/service-manual/agile-delivery/how-the-alpha-phase-works), [beta](https://www.gov.uk/service-manual/agile-delivery/how-the-beta-phase-works) and [live](https://www.gov.uk/service-manual/agile-delivery/how-the-live-phase-works) ([SERVICE-PHASES](https://www.gov.uk/service-manual/agile-delivery)). Delivery in all phases is done using [build-measure-learn](http://theleanstartup.com/principles#:~:text=A%20core%20component%20of%20Lean,feedback%20loop) loops, with the whole multi-disciplinary team working closely together in all three activities. This approach means that rather than having a big up front design, the design is iteratively refined throughout all phases ([SERVICE-AGILE](https://www.gov.uk/service-manual/agile-delivery/agile-government-services-introduction#the-differences-between-traditional-and-agile-methods)).
- **Technical design and architecture.** While some up front thinking is generally beneficial to help a delivery team set off in the right direction, the output design is best viewed as first draft which will be refined during delivery as more is discovered about technical and product constraints and opportunities. See [Evolutionary Architectures](https://evolutionaryarchitecture.com/precis.html).
- **Team processes.** Great team processes come about by starting with something simple and practising [continuous improvement](https://kanbanize.com/lean-management/improvement/what-is-continuous-improvement) to find ways of working, definitions of done and so on which are well suited to the particular team and environment.

## Caveats

- This pattern must not compromise quality: automation (including of quality control) is essential for safe implementation of this pattern.
