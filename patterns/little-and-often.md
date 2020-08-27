# Deliver little and often

## Context

* These notes are part of a broader set of [principles](../principles.md)
* This pattern is closely related to the [architect for flow](architect-for-flow.md) pattern

## The pattern

Delivering many small changes has benefits over delivering a smaller number of larger changes.

## Benefits

* Increased safety and predictability:
    * Changing less at a time means there is less (per change) to go wrong
    * Frequently-run processes are more predictable (simply because they are run more frequently)
    * The automation required means less exposure to human error
    * The automation required supports quick responses if there is a problem
    * Quality checks are applied more frequently
    * Frequent changes make it easier to keep everything up to date
* Business benefits:
    * Early visibility of changes
    * Early benefit realisation
    * Smaller changes should require less user training, user communications, etc
    * Happier delivery team
* Cost (in the long term):
    * The automation required means long-term savings on manual effort
    * Short-lived changes simplifies the technical delivery overhead (merge conflicts, etc)
    * Changing less at a time means less potential for obscure problems (which are difficult and expensive to find and fix)

## Caveats

* This pattern must not compromise quality: automation is essential for safe implementation of this pattern

## Details

TO DO

## Examples

TO DO
