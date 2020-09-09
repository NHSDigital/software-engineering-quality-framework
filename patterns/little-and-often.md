# Deliver little and often

## Context

* These notes are part of a broader set of [principles](../principles.md)
* This pattern is closely related to the [architect for flow](architect-for-flow.md) pattern

## The pattern

Delivering "little and often" has broad benefits across the software delivery process:
* Incremental software changes: delivering many small software changes is preferable to infrequent delivery of larger changes
* Incremental team operations: working incrementally (for example re-planning frequently and iteratively refining the architecture and technology choices) is preferable to large up-front planning and design, or long-running delivery cycles

## Benefits

* Increased safety and predictability:
    * Changing less at a time means there is less (per change) to go wrong
    * Frequently-run processes are more predictable (simply because they are run more frequently)
    * The automation which supports frequent changes means less exposure to human error
    * The automation which supports frequent changes supports quick responses if there is a problem
    * Quality checks are applied more frequently
    * Frequent changes make it easier to keep everything up to date
* Product / service design benefits:
    * Early visibility of changes
    * Early benefit realisation
    * Smaller changes should require less user training, user communications, etc
    * Helps service designers rapidly test hypotheses
* Cost (in the long term):
    * The automation which supports frequent changes means long-term savings on manual effort
    * Short-lived changes simplifies the technical delivery overhead (merge conflicts, etc)
    * Changing less at a time means less potential for obscure problems (which are difficult and expensive to find and fix)
* Happier delivery team

## Details

This pattern is in essence very straightforward; the power comes in applying it rigorously to everything you do. Judgement is needed when deciding how much to do up front, versus deferring to be done incrementally. But in general the aim should be to do the minimum possible up front and to defer anything which will not alter actions or decisions now.

## Examples

* **Delivering Software.** The trivial and obvious example is that it is better to deliver software in small increments than to do it in one [big bang](https://hackernoon.com/why-your-big-bang-multi-year-project-will-fail-988e45c830af) for reasons which have been well covered elsewhere.
* **Planning.** Start by doing just enough planning to forecast the size and type of team(s) you need to get the job done roughly when you want it to be done by. Incrementally refine that plan through (typically) fortnightly backlog/roadmap refinement sessions.
* **Service- and interaction design.** This typically comes in two parts: an initial discovery stage, followed by an iterative delivery stage. In the discovery stage, do just enough research and design to sketch a solution and gain some confidence that it will address user needs. This stage is in itself iterative and relies on tight design-measure-learn loops working with users. In the delivery phase, the design is iteratively refined sprint by sprint with designers working just ahead of engineers. And the delivery of each story is a collaboration between designers, engineers and product owners with just enough design input available before implementation and a willingness to flex the design in response to learnings through implementation. See [Service Design Thinking](https://articles.uie.com/service-design-thinking/).
* **Technical design and architecture.** While some up front thinking is generally beneficial to help a delivery team set off in the right direction, the output design is best viewed as first draft which will be refined during delivery as more is discovered about technical and product constraints and opportunities. See [Evolutionary Architectures](https://evolutionaryarchitecture.com/precis.html).
* **Team processes.** Great team processes come about by starting with something simple and practising [continuous improvement](https://kanbanize.com/lean-management/improvement/what-is-continuous-improvement) to find aspects like ways of working and definitions of done well suited to the particular team and environment.
