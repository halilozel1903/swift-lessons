# Capstone: Study Planner

[Home](../../README.md) · [Swift 601](../../Curriculum/Swift-601/README.md)

Build a reliable progress tracker by combining concepts from the course. The included implementation is a reusable domain library and a deterministic CLI demonstration. It does not yet offer interactive input or persistent storage.

## Run

```bash
swift run study-planner
swift test
```

Output:

```text
Study Planner
Completed: 1/3
Remaining: 75 minutes
Progress: 33%
```

## Read the implementation

1. [Lesson and StudyPlan](../../Sources/LearningCore/StudyPlan.swift): validated values, custom decoding, idempotent completion, and derived progress.
2. [PlanStore](../../Sources/LearningCore/StudyPlan.swift): an actor that owns mutation and returns value snapshots.
3. [CLI](../../Sources/StudyPlanner/StudyPlanner.swift): composition and output at the application boundary.
4. [Tests](../../Tests/LearningCoreTests/StudyPlanTests.swift): input boundaries, decoding, value semantics, and concurrent mutation.

## Domain contract

| Rule | Behavior |
| --- | --- |
| Title | Trim surrounding whitespace and reject an empty result |
| Duration | Accept 1 through 480 minutes |
| Identity | Reject duplicate lesson IDs in a plan |
| Completion | Repeated completion has no additional effect |
| Unknown lesson | Throw without changing completion state |
| Empty plan | Report zero progress and zero remaining minutes |
| Snapshots | Previously returned values do not mutate with later changes |
| Decoding | Enforce the same invariants as direct initialization |

The model stores completion IDs in a set to make completion idempotent. Progress and remaining duration are computed so they cannot drift from the source data. PlanStore does not suspend between checking and applying a completion. This keeps that operation atomic within the actor.

The duration limit is a teaching-domain policy, not a language restriction. Remaining-minute aggregation assumes ordinary course-sized data whose sum fits Int. A service accepting unbounded imported plans should also limit plan size and handle arithmetic bounds.

## Exercises with acceptance criteria

### 1. Persistent snapshots

Create a versioned Codable archive DTO containing lessons and completion IDs. Reject completion IDs absent from the lesson list. Preserve validation on decode and test a previous-version fixture. Write to a temporary directory in tests; handle corrupted data explicitly.

### 2. A real CLI

Add list, complete, and progress commands. Define a stable persistence location and useful exit codes. Keep argument parsing and printing out of LearningCore. Add tests for unknown IDs and invalid arguments.

### 3. A SwiftUI client

Create an iOS host and expose loading, success, empty, and failure states in a main-actor presentation model. Inject the store. Avoid generating new lesson IDs on every render. Confirm accessibility with large text and VoiceOver.

### 4. An HTTP adapter

Load lesson DTOs through an injected transport. Validate status codes and domain rules. Test invalid JSON, invalid durations, cancellation, and out-of-order responses. Do not make tests depend on a live server.

## Review rubric

- Correctness: invalid states cannot bypass the model’s rules.
- Ownership: mutable state has a clear owner and no unchecked concurrency escape hatch.
- Failure behavior: errors remain meaningful to the caller.
- Tests: a meaningful behavior change would make at least one test fail.
- Documentation: another learner can run and explain the feature.

Keep extensions small and reviewable. The project becomes useful by preserving its contracts, not by adding every framework at once.
