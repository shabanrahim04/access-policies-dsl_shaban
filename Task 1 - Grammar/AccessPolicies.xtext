#This grammar ensures the hierarchy is preserved. Note the use of [Actor] for the cross-reference.

grammar gse.xtext.assignment.AccessPolicies with org.eclipse.xtext.common.Terminals

generate accessPolicies "http://www.xtext.org/assignment/AccessPolicies"

Model:
    elements+=Element*;

Element:
    Actor | Asset | Operation | Policy;

Actor:
    'actor' name=ID ('inherits' parent=[Actor])?;

Asset:
    'asset' name=ID;

Operation:
    'operation' name=ID;

Policy:
    'policy' name=ID '{'
        scopes+=Scope*
    '}';

Scope:
    'scope' actor=[Actor] '{'
        rules+=Rule*
    '}';

Rule:
    AllowRule | DenyRule;

AllowRule:
    'allow' operation=[Operation] 'on' asset=[Asset];

DenyRule:
    'deny' operation=[Operation] 'on' asset=[Asset];
