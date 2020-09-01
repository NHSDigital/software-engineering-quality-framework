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
    * Supports service designers to rapid test hypotheses
* Cost (in the long term):
    * The automation which supports frequent changes means long-term savings on manual effort
    * Short-lived changes simplifies the technical delivery overhead (merge conflicts, etc)
    * Changing less at a time means less potential for obscure problems (which are difficult and expensive to find and fix)
* Happier delivery team

## Caveats

* This pattern must not compromise quality: automation (including of quality control) is essential for safe implementation of this pattern

## Details

TO DO

## Examples

TO DO
