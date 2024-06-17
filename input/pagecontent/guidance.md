# This page is for guidance

## Implementation

## Use cases

## Terminology

## Controls

## Prerequisites
@startuml
"Laboratory Report Creator" as creator
"Laboratory Report Repository" as repos
"Laboratory Report Consumer" as consumer
"Generate a report" as (create)
"Store a report" as (store)
"Use a report" as (use)

"Send/Provide a report" as (send)
"Receive/Query a report" as (receive)

creator --> (create)
creator --> (send)
consumer --> (use)
consumer --> (receive)
repos --> (store)
repos --> (send)
repos --> (receive)
@enduml