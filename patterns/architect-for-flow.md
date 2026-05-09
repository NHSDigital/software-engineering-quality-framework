# Architect for flow

- [Architect for flow](#architect-for-flow)
  - [Context](#context)
  - [The pattern](#the-pattern)
  - [The mindset](#the-mindset)
  - [Core concepts and how they fit together](#core-concepts-and-how-they-fit-together)
    - [Independent value streams (Lean Thinking)](#independent-value-streams-lean-thinking)
    - [Stream-aligned teams (Team Topologies)](#stream-aligned-teams-team-topologies)
    - [Services, products, and ownership (Socio-technical alignment)](#services-products-and-ownership-socio-technical-alignment)
    - [Bounded contexts and domain alignment (Domain-Driven Design)](#bounded-contexts-and-domain-alignment-domain-driven-design)
    - [Fast flow through small batches (Continuous Delivery / Accelerate)](#fast-flow-through-small-batches-continuous-delivery--accelerate)
  - [Co-creation, co-design, and co-evolution](#co-creation-co-design-and-co-evolution)
  - [Benefits](#benefits)
  - [Out of scope](#out-of-scope)
  - [Practical guidance](#practical-guidance)
    - [Principles](#principles)
    - [Practices](#practices)
    - [How to measure flow](#how-to-measure-flow)
    - [Common anti-patterns](#common-anti-patterns)
  - [Examples](#examples)

## Context

- This pattern is part of a broader set of [engineering principles](../principles.md).
- It strongly complements the [deliver little and often](./little-and-often.md) pattern.
- It aligns with modern thinking on architecture modernisation, [evolutionary design / domain-driven design (DDD)](https://martinfowler.com/tags/evolutionary%20design.html), [Team Topologies](https://teamtopologies.com/key-concepts), and [Better Value Sooner Safer Happier (BVSSH)](https://www.soonersaferhappier.com/post/what-is-bvssh).
- It should be read alongside [structured code](../practices/structured-code.md).

At its core, _architecting for flow_ is about designing systems and teams so that valuable change can move quickly, safely, and sustainably from idea to production.

## The pattern

Design architecture to enable fast, safe flow of change across independent value streams.

Architecting for flow means intentionally shaping systems around:

- Independent value streams
- Stream-aligned teams
- Clear bounded contexts
- Loosely coupled services and products

The primary goal is not technical elegance, reuse, or theoretical purity. The goal is fast flow, the ability for teams to deliver small, incremental changes frequently, with confidence.

This requires aligning business domains, team ownership, services and products, and architectural boundaries so that:

- Teams can work independently
- Changes are small and low risk
- Co-ordination and hand-offs are minimised
- Learning happens early and often

This is a deliberate application of [Conway's Law](https://martinfowler.com/bliki/ConwaysLaw.html), which states that software architecture tends to mirror the communication and co-ordination structures of the organisation. By shaping team boundaries, ownership, and interfaces together, we ensure organisational design reinforces fast, independent flow rather than constraining it.

## The mindset

Modern architecture recognises that software systems do not exist in isolation. Their behaviour, quality, speed of change, and reliability are shaped as much by people, team structures, incentives, and ways of working as by code, infrastructure, or technology.

When architecture is not aligned with flow, it can lead to:

- Change coupling across teams
- Slow delivery and high co-ordination costs
- Fragile systems and risky releases
- Reduced satisfaction among engineers and users

Well-shaped architectures enable:

- Independent delivery
- Faster learning
- Better quality
- Safer change
- Happier teams and users

Architecting for flow is therefore a business optimisation strategy, not just an engineering one.

## Core concepts and how they fit together

### Independent value streams (Lean Thinking)

In Lean Thinking, a **value stream** is the end-to-end flow of activities required to deliver value to a specific user or customer outcome. In this pattern, an independent value stream is one where a team can make most day-to-day changes without needing co-ordinated work from many other teams. An independent value stream is the fundamental building block. Each value stream:

- Is aligned to a business subdomain
- Is owned by a single stream-aligned team
- Delivers business outcomes, not just features
- Can be developed and deployed independently

Architecture should help turn independence from aspiration into day-to-day reality.

### Stream-aligned teams (Team Topologies)

Each independent value stream is owned by a **stream-aligned team**. That team:

- Owns the product or service end to end
- Makes day-to-day product and technical decisions
- Builds, deploys, operates, and improves what they own
- Optimises for outcomes and flow, not hand-offs

Architecture should reduce the need for teams to co-ordinate in order to deliver change. In practice, this means "reversing" [Conway's Law](https://www.agileanalytics.cloud/blog/team-topologies-the-reverse-conway-manoeuvre), intentionally designing teams, communication paths, and ownership boundaries so that the resulting architecture naturally supports fast, independent delivery.

### Services, products, and ownership (Socio-technical alignment)

Architecting for flow means aligning:

- Products and services
- Codebases and repositories
- Runtime boundaries
- Team ownership

Teams should anchor this alignment on business outcomes rather than lists of features. For example, in a cancer screening domain:

- Outcome: "Increase uptake of bowel cancer screening invitations by 2% in the next year"
- Feature: "Add a reminder SMS template for screening invitations"

The outcome describes the change in behaviour or value you want to see, the feature is one possible intervention. Architecturally, ownership, data, and interfaces should be shaped so that stream-aligned teams can experiment with multiple features in pursuit of the same outcome.

A common sign of misalignment is when:

- Multiple teams must change their services together
- Features require cross-team co-ordination by default
- Teams share databases or internal implementation details

Instead:

- Each service or product should map clearly to a value stream
- Ownership boundaries should be obvious
- Dependencies should be explicit and intentional

Some domains are naturally cross-cutting, such as shared notification services, analytics, or identity. In a cancer screening context, a notification capability (for example, NHS Notify) might send reminders across Bowel, Breast, and Cervical screening services. These cross-cutting capabilities are usually best owned by platform or enabling teams (at organisational scale, not just within a single digital area), exposed through clear APIs and contracts, and governed with explicit service level objectives (SLOs). Typical shared capabilities include messaging infrastructure, observability stacks, and identity/SSO services. Platform and enabling teams should optimise for the flow of the stream-aligned teams they support, not for their own internal roadmaps, ensuring shared services make it easier (and faster) for value streams to deliver change.

### Bounded contexts and domain alignment (Domain-Driven Design)

In Domain-Driven Design, a **bounded context** is a clear boundary within which a specific domain model, language, and set of rules apply consistently. Different bounded contexts can use different models and terms for the same real-world concept, as long as the seams and integration points between them are explicit and well-defined. Clear bounded contexts are essential to flow. Key principles include:

- Avoid shared databases across bounded contexts
- Encapsulate data, logic, and behaviour within each context
- Accept duplication where it reduces coupling and co-ordination

Bounded contexts reduce change coupling, allowing teams to move independently. Collaborative techniques such as [EventStorming](https://www.eventstorming.com/) are strongly encouraged to identify meaningful domain boundaries.

### Fast flow through small batches (Continuous Delivery / Accelerate)

Continuous Delivery and the Accelerate research both show that teams achieve better outcomes when they work in **small, independently releasable batches** rather than large, infrequent changes. Small batches reduce risk, shorten feedback loops, and make it easier to understand, test, and recover from problems. Flow improves when teams:

- Deliver small slices of value
- Deploy frequently
- Learn quickly from real usage
- Reduce the blast radius of change

Architecture should actively support:

- [Independent deployments](./deployment.md)
- [Progressive delivery](./little-and-often.md)
- [Feature toggling](../practices/feature-toggling.md)
- [Observability](../practices/observability.md)
- [Fast feedback](./fast-feedback.md)

Large, co-ordinated releases often indicate that flow may be constrained by architectural or organisational choices.

## Co-creation, co-design, and co-evolution

Architecting for flow is not a one-off design activity. It requires a **co-creation approach**, where:

- Engineers, product managers, domain experts, and users collaborate
- Architecture evolves incrementally
- Decisions are revisited as learning increases

Architecture should be **co-designed and co-evolved** with the system:

- Changes are made in small, safe steps
- Learning feeds back into design
- Teams continuously improve both the product and the architecture

This shifts emphasis from big up-front design towards more incremental, learning-driven design.

## Benefits

Systems architected for flow tend to deliver strong outcomes. Typical benefits include:

- Shorter lead times from idea to production and higher deployment frequency
- Reduced co-ordination overhead between teams, with fewer hand-offs to deliver change
- Improved reliability and faster incident recovery due to clearer ownership and boundaries
- Better morale and engagement, as teams have autonomy and a clear sense of purpose

Important caveats and trade-offs:

- Flow must not compromise quality, strong automation is essential (testing, security, deployment)
- More components ≠ better as over-fragmentation increases cognitive load and operational cost, and small or simple systems may benefit from a well-structured modular monolith
- Distributed systems introduce complexity, network failures must be factored in, versioning challenges become the norm, and observability becomes mandatory
- Reuse is a valuable outcome but not the primary goal here, components should first support clear ownership and flow, with reuse as a secondary benefit

There is usually a sweet spot between monoliths and over-distributed systems.

## Out of scope

This pattern is intentionally narrow in what it tries to solve. It does not optimise for maximum reuse across the organisation, nor does it address all cross-cutting concerns (for example, security or regulatory compliance) on its own. Those concerns are covered by complementary principles and practices. Architecting for flow should be combined with them, not treated as a replacement.

## Practical guidance

### Principles

- Split systems vertically by bounded context or domain, not purely by technical layers
- Avoid shared databases between components or bounded contexts
- Ensure components interact only via public, well-defined APIs
- Align repositories, pipelines, and runtime ownership with team boundaries

### Practices

- Design services so that a single team can change and deploy them independently
- Apply this pattern to existing systems as well as greenfield work, techniques such as the [Strangler Fig](https://martinfowler.com/bliki/StranglerFigApplication.html) pattern can help evolve legacy systems safely

### How to measure flow

Flow is only useful if teams can see whether it is improving. Guidance on how to measure this is covered in the [engineering metrics](../insights/metrics.md) section of the framework. These measures should be used as feedback loops to guide architectural and organisational changes, not as targets to game. The goal is to make it easier for teams to deliver small, safe, independent changes more often.

### Common anti-patterns

When architecting for flow, some recurring anti-patterns make independent delivery much harder:

- Shared "integration" databases owned or written to by multiple teams
- Platform teams that sit on the critical path for most changes
- Services sliced primarily by technical layers (UI, API, DB) rather than by domain or value stream
- "API gateways" that accumulate significant domain logic and create tight coupling between services

These patterns often suggest that organisational and architectural structures may be reinforcing centralised ownership and tight coupling. Use them as prompts to realign teams, domains, and boundaries so value streams can move independently.

## Examples

We have examples of live systems where this pattern has been applied in practice and continues to evolve. If you would like to explore concrete examples, including what worked well, what was learned, and where trade-offs were made, please get in touch. These systems can be discussed collaboratively and used as shared learning opportunities to help teams apply the pattern effectively in their own contexts.
