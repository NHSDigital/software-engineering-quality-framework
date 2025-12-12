# Architect for flow

- [Architect for flow](#architect-for-flow)
  - [Context](#context)
  - [The pattern](#the-pattern)
  - [The mindset](#the-mindset)
  - [Core concepts and how they fit together](#core-concepts-and-how-they-fit-together)
    - [Independent value streams (Lean Thinking)](#independent-value-streams-lean-thinking)
    - [Stream-aligned teams (Team Topologies)](#stream-aligned-teams-team-topologies)
    - [Services, products, and ownership](#services-products-and-ownership)
    - [Bounded contexts and domain alignment](#bounded-contexts-and-domain-alignment)
    - [Fast flow through small batches](#fast-flow-through-small-batches)
  - [Co-creation, codesign, and coevolution](#co-creation-codesign-and-coevolution)
  - [Benefits](#benefits)
  - [Practical guidance](#practical-guidance)
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

The primary goal is not technology elegance, reuse, or theoretical purity. The goal is fast flow, which is the ability for teams to deliver small, incremental changes frequently, with confidence.

This requires aligning business domains, team ownership, services/products, and architecture boundaries so that:

- teams can work independently
- changes are small and low-risk
- coordination and hand-offs are minimised
- learning happens early and often

## The mindset

Modern architecture recognises that software systems do not exist in isolation. Their behaviour, quality, speed of change, and reliability are shaped just as much by people, team structures, incentives, and ways of working as by code, infrastructure, or technologies.

Poorly shaped architectures create:

- Change coupling across teams
- Slow delivery and high coordination costs
- Fragile systems and risky releases
- Unhappy, frustrated engineers and users

Well-shaped architectures enable:

- Independent delivery
- Faster learning
- Better quality
- Safer change
- Happier teams and users

Architecting for flow is therefore a business optimisation strategy, not just an engineering one.

## Core concepts and how they fit together

### Independent value streams (Lean Thinking)

An **independent value stream** is the fundamental building block. Each value stream:

- Is aligned to a business subdomain
- Is owned by a single stream-aligned team
- Delivers business outcomes, not just features
- Can be developed and deployed independently

Architecture should make independence real, not just aspirational.

### Stream-aligned teams (Team Topologies)

Each independent value stream is owned by a **stream-aligned team**. That team:

- Owns the product or service end-to-end
- Makes day-to-day product and technical decisions
- Builds, deploys, operates, and improves what they own
- Optimises for outcomes and flow, not hand-offs

Architecture should reduce the need for teams to coordinate in order to deliver change.

### Services, products, and ownership

Architecting for flow means aligning:

- Products and services
- Codebases and repositories
- Runtime boundaries
- Team ownership

A common smell is when:

- Multiple teams must change their services together
- Features require cross-team coordination by default
- Teams share databases or internal implementation details

Instead:

- Each service or product should map clearly to a value stream
- Ownership boundaries should be obvious
- Dependencies should be explicit and intentional

### Bounded contexts and domain alignment

Clean **bounded contexts** are essential to flow. Key principles:

- Split systems vertically by domain, not horizontally by technical layers
- Avoid shared databases across bounded contexts
- Encapsulate data, logic, and behaviour within each context
- Accept duplication where it reduces coupling and coordination

Bounded contexts reduce change coupling, allowing teams to move independently. Collaborative techniques such as [EventStorming](https://www.eventstorming.com/) are strongly encouraged to identify meaningful domain boundaries.

### Fast flow through small batches

Flow improves when teams:

- Deliver small slices of value
- Deploy frequently
- Learn quickly from real usage
- Reduce the blast radius of change

Architecture should actively support:

- Independent deployments
- Progressive delivery
- Feature toggling
- Observability and fast feedback

Large, coordinated releases are a sign that flow is being constrained by architecture.

## Co-creation, codesign, and coevolution

Architecting for flow is not a one-off design activity. It requires a **co-creation approach**, where:

- Engineers, product managers, domain experts, and users collaborate
- Architecture evolves incrementally
- Decisions are revisited as learning increases

Architecture should be **codesigned and coevolved** with the system:

- Changes are made in small, safe steps
- Learning feeds back into design
- Teams continuously improve both the product and the architecture

This is a deliberate move away from big up-front designs.

## Benefits

Systems architected for flow tend to deliver strong outcomes. However

- Flow must not compromise quality, strong automation is essential (testing, security, deployment)
- More components ≠ better as over-fragmentation increases cognitive load and operational cost, small or simple systems may benefit from a well-structured modular monolith
- Distributed systems introduce complexity, network failures has to be factored in, versioning challenges become a norm, observability becomes mandatory
- Reuse is not the primary goal, build components for clear ownership and flow, reuse is a secondary benefit, not a justification

There is usually a sweet spot between monoliths and over-distributed systems.

## Practical guidance

- Split systems by bounded context, not by technical layers
- Avoid shared databases between components
- Ensure components interact only via public APIs (external to the internal service API)
- Design services so a single team can change and deploy them independently
- Align repositories, pipelines, and runtime ownership with team boundaries
- Apply this pattern to existing systems as well as greenfield work, techniques like the [Strangler Fig](https://martinfowler.com/bliki/StranglerFigApplication.html) pattern can help evolve legacy systems safely

## Examples

We have examples of live systems where this pattern has been applied in practice and continues to evolve. If you would like to explore concrete examples, including what worked well, what was learned, and where trade-offs were made, please get in touch. These systems can be discussed collaboratively and used as shared learning opportunities to help teams apply the pattern effectively in their own contexts.
