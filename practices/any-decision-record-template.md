# Decision Title - ADR-XXX: ADR (Any Decision Record) Template

- [Decision Title - ADR-XXX: ADR (Any Decision Record) Template](#decision-title---adr-xxx-adr-any-decision-record-template)
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
  - [Tags](#tags)

- `Date`: `dd/mm/YYYY` when the decision was last updated
- `Status`: `RFC by dd/mm/YYYY | Proposed | Rejected | Accepted | Deprecated | ... | Superseded by ADR-XXX | Supersedes ADR-XXX`
- `Deciders`: List all the key decision makers and state whether it is an internal decision or it requires additional endorsement or approval of an external group or governing body like `Tech Radar | Engineering | Architecture | Solution Assurance | Clinical Assurance | Technical Review and Governance | Information Governance | Cyber Security | Live Services Board` or any other
- `Significance`:  `Structure | Nonfunctional characteristics | Dependencies | Interfaces | Construction techniques | ...`

## Context

Describe the context and the problem statement. Is there a relationship to other decisions previously made? Are there any dependencies and/or constraints within which the decision will be made? Do these need to be reviewed or validated? Please, note that environmental limitations or restrictions such as accepted technology standards, commonly recognised and used patterns, engineering and architecture principles, organisation policies, governance and so on, may as an effect narrow down the choices. This should also be explicitly documented, as this is a point-in-time decision with the intention of being able to articulate it clearly and justify it later.

## Decision

### Assumptions

Summarise the underlying assumptions in the environment in which you make the decision. This could be related to technology changes, forecast of the monetary and non-monetary costs, further delivery commitments, impactful external drivers etc., and any known unknowns that translate to risks.

### Drivers

List the decision drivers that motivate this change or course of action. This may include any identified risks and residual risks after applying the decision.

### Options

Consider a comprehensive set of alternative options.

### Outcome

State the decision outcome as a result of taking into account all of the above.

### Rationale

Provide a rationale for the decision that is based on weighing the options to ensure that the same questions are not going to be asked again and again unless the decision needs to be superseded.

## Consequences

Describe the resulting context, after applying the decision. All the identified consequences should be listed here, not just the positive ones. Any decision comes with many implications. For example, it may introduce a need to make other decisions as an effect of cross-cutting concerns; it may impact structural or operational characteristics of the software, and influence non-functional requirements; as a result, some things may become easier or more difficult to do because of this change. What are the trade offs?

## Compliance

Establish how the success is going to be measured. Once implemented, the effect might lend itself to be measured, therefore if appropriate a set of criteria for success could be established. Compliance check of the decision can be manual or automated using a fitness function. If it is the later this section can then specify how that fitness function would be implemented and whether there are any other changes to the codebase needed to measure this decision for compliance.

## Notes

Include any links to existing epics, decisions, dependencies, risks, and policies related to this decision record. This section could also include any further links to configuration items within the project or the codebase, signposting to the areas of change.

## Tags

`#availability|#security|#resilience|#scalability|#maintainability|#accessibility|…` these tags are intended to be operational, structural or cross-cutting architecture characteristics to link to related decisions.
