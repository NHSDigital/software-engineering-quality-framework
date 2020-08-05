# Architect for flow

## Context

* These notes are part of a broader set of [principles](../principles.md)

## The pattern

Technical design choices should primarily optimise for rapid, reliable delivery and operations.

## Benefits

* Cost efficient: teams don't waste their time fighting the tools.
* Improves business agility: technologies and architectures which allow changes to be made rapidly and safely allow teams to respond more quickly to changes.
* Improved reliability: it is easier to make systems which are easy to understand reliable, with fewer failures and shorter recovery times.
* Improved recruitment and retention: engineers are happy when the tools they work with let them get on with what they do best.

## Details

Split services vertically (via domain driven design) rather than horizontally: for example, do not implement dedicated processes to update databases or configuration.

TO DO: more detail, including team structures

## Examples

TO DO