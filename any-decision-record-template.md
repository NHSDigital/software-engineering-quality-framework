# ADR-nnn: Any Decision Record Template

>|              | |
>| ------------ | --- |
>| Date         | `dd/mm/YYYY` _when the decision was last updated_ |
>| Status       | `RFC by dd/mm/YYYY, Proposed, In Discussion, Pending Approval, Withdrawn, Rejected, Accepted, Deprecated, ..., Superseded by ADR-XXX or Supersedes ADR-XXX` |
>| Deciders     | `Tech Radar, Engineering, Architecture, Solution Assurance, Clinical Assurance, Technical Review and Governance, Information Governance, Cyber Security, Live Services Board,` ... |
>| Significance | `Structure, Nonfunctional characteristics, Dependencies, Interfaces, Construction techniques,` ... |
>| Owners       | |

---

- [ADR-nnn: Any Decision Record Template](#adr-nnn-any-decision-record-template)
  - [Context](#context)
  - [Decision](#decision)
    - [Assumptions](#assumptions)
    - [Drivers](#drivers)
    - [Options](#options)
    - [Outcome](#outcome)
    - [Rationale](#rationale)
  - [Consequences](#consequences)
  - [Compliance](#compliance)
  - [Notes](#notes)
  - [Actions](#actions)
  - [Tags](#tags)

## Context

Describe the context and the problem statement. Is there a relationship to other decisions previously made? Are there any dependencies and/or constraints within which the decision will be made? Do these need to be reviewed or validated? Please, note that environmental limitations or restrictions such as accepted technology standards, commonly recognised and used patterns, engineering and architecture principles, organisation policies, governance and so on, may as an effect narrow down the choices. This should also be explicitly documented, as this is a point-in-time decision with the intention of being able to articulate it clearly and justify it later.

## Decision

### Assumptions

Summarise the underlying assumptions in the environment in which you make the decision. This could be related to technology changes, forecast of the monetary and non-monetary costs, further delivery commitments, impactful external drivers etc., and any known unknowns that translate to risks.

### Drivers

List the decision drivers that motivate this change or course of action. This may include any identified risks and residual risks after applying the decision.

### Options

Consider a comprehensive set of alternative options; provide weighting if applicable.

### Outcome

State the decision outcome as a result of taking into account all of the above. Is it a reversible or irreversible decision?

### Rationale

Provide a rationale for the decision that is based on weighing the options to ensure that the same questions are not going to be asked again and again unless the decision needs to be superseded.

For non-trivial decisions a comparison table can be useful for the reviewer. Decision criteria down one side, options across the top. You'll likely find decision criteria come from the Drivers section above. Effort can be an important driving factor.  You may have an intuitive feel for this, but reviewers will not. T-shirt sizing the effort for each option may help communicate.

## Consequences

Describe the resulting context, after applying the decision. All the identified consequences should be listed here, not just the positive ones. Any decision comes with many implications. For example, it may introduce a need to make other decisions as an effect of cross-cutting concerns; it may impact structural or operational characteristics of the software, and influence non-functional requirements; as a result, some things may become easier or more difficult to do because of this change. What are the trade-offs?

What are the conditions under which this decision no longer applies or becomes irrelevant?

## Compliance

Establish how the success is going to be measured. Once implemented, the effect might lend itself to be measured, therefore if appropriate a set of criteria for success could be established. Compliance checks of the decision can be manual or automated using a fitness function. If it is the latter this section can then specify how that fitness function would be implemented and whether there are any other changes to the codebase needed to measure this decision for compliance.

## Notes

Include any links to existing epics, decisions, dependencies, risks, and policies related to this decision record. This section could also include any further links to configuration items within the project or the codebase, signposting to the areas of change.

It is important that if the decision is sub-optimal or the choice is tactical or misaligned with the strategic directions the risk related to it is identified and clearly articulated. As a result of that, the expectation is that a [Tech Debt](./tech-debt.md) record is going to be created on the backlog.

## Actions

- [x] name, date by, action
- [ ] name, date by, action

## Tags

`#availability|#scalability|#elasticity|#performance|#reliability|#resilience|#maintainability|#testability|#deployability|#modularity|#simplicity|#security|#data|#cost|#usability|#accessibility|…` these tags are intended to be operational, structural or cross-cutting architecture characteristics to link to related decisions.
