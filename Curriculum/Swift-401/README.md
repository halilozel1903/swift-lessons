# Swift 401 — Concurrency and Data

[Repository home](../../README.md) · [Full curriculum](../../docs/CURRICULUM.md)

## Learning outcome

By the end of this level, build **Concurrent Course Loader** and explain the tradeoffs in each lesson. Budget approximately 10–15 hours including exercises; progress by demonstrated understanding, not by time spent.

## Lessons

1. [Async/Await and Structured Concurrency](01-async-await.md)
2. [Actors, Sendable, and Reentrancy](02-actors-sendable.md)
3. [Cancellation and Asynchronous Sequences](03-cancellation-streams.md)
4. [Networking and Testable HTTP Boundaries](04-networking.md)
5. [Files, Persistence, and Schema Evolution](05-files-persistence.md)

## Level project

Load independent fixture records with a task group, preserve input order, and store results behind an actor.

Create your own implementation in a separate practice directory. These are open-ended projects; the included capstone is a worked reference, not a claim that every possible solution is supplied.

## Exit criteria

Exercise cancellation, malformed JSON, and concurrent writes without making live network calls.

For each lesson, run the example, make one deliberate change, and explain the result. Revisit any topic for which you cannot predict the behavior. Continue through the [curriculum map](../../docs/CURRICULUM.md).
