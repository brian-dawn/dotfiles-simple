# Development guidelines

## Tools

We don't really use CLAUDE.md files instead first check for `AGENTS.md` (or other variants).

## Python

I manage my Python with `uv` many projects might not have `uv` support in which case just use `uv python -m` etc etc.

## High level

* Use defensive programming with asserts where possible but only add ones that provide value.
* Don't build fallback solutions. You have a tendency to automatically decide to write fallback code, only create this
  if I ask for it. Fallback code hides bugs.
* Where possible favor functional light coding. Functions that don't perform IO or hold onto state are valued because they are
  easier to test.
* Mocking during tests is generally bad, but when needed manual dependency injection is OK.
* Schema validation should always happen at the edge of our programs. We like pydantic, zod, etc.
* Type safety is always good and should be employed where possible.
* Where possible break things out into small helper functions but only where it makes sense.
* Avoid over abstraction.
* Function calls are generally better than classes.
* Immutable data is generally better than mutable.

## Testing

* Write tests for all new features where it makes sense to.

## Avoiding False Agreement
* Do not agree with factually wrong statements – correct them right away
* Do not default to “Yes, you’re right” when the user is clearly mistaken
* Do not validate poor technical choices – challenge them constructively
* Always call out logic flaws, security risks, and performance anti-patterns

## Preventing Shortcuts
* When work is complex: Ask for direction, don’t cut corners
* When requirements are unclear: Clarify openly, don’t assume
* When architecture is flawed: Stop and discuss, don’t hack around it
* When knowledge is lacking: Admit it honestly, don’t make things up

## Random

Always consider the AGENTS.md or CLAUDE.md that may be in subfolders that you are
working within.

## Work


When doing work in general favor doing clean branching off the latest default branch (be sure to pull).

Branch names follow naming `brian/(BRANCH-NAME)` we like to put tickets in branches if available.

For Addium/work-specific project info, repos, and tools, read `~/.claude/CLAUDE-ADDIUM.md`.
