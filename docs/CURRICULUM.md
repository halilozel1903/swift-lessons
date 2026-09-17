# Curriculum and Coverage Map

[Home](../README.md)

Follow the core levels in order. Swift 501 requires Apple SDKs; learners focused on Linux or server development can continue from 401 to 601 and return to the UI track later.

| Level | Prerequisites | Core topics | Deliverable |
| --- | --- | --- | --- |
| [101](../Curriculum/Swift-101/README.md) | None | Types, operators, control flow, optional binding, Unicode, arrays, sets, dictionaries, functions, closures | Session calculator |
| [201](../Curriculum/Swift-201/README.md) | 101 | Structs, enums, initialization, classes, computed properties, protocols, extensions, errors, Codable, generics | Course catalog |
| [301](../Curriculum/Swift-301/README.md) | 201 | ARC, capture lists, sequences, key paths, lazy evaluation, property wrappers, result builders, access control, some/any, casting, subscripts | Reusable study toolkit |
| [401](../Curriculum/Swift-401/README.md) | 301 | Async/await, async let, task groups, actors, Sendable, reentrancy, cancellation, AsyncSequence, URLSession, file storage | Concurrent course loader |
| [501](../Curriculum/Swift-501/README.md) | 401 + Xcode | SwiftUI, Observation, state ownership, navigation, identity, accessibility, SwiftData, UIKit bridges | Study companion app |
| [601](../Curriculum/Swift-601/README.md) | 401; 501 optional | Swift Testing, injection, architecture, complexity, profiling, SwiftPM, CI, input boundaries | Study Planner capstone |

## Depth matters

**Worked lessons** include complete source and an exercise. **Discussion coverage** explains a tradeoff within a lesson but may not implement every variant. **Specialization guides** provide a starting design, example, and practice task; they are not full framework courses.

| Area | Coverage |
| --- | --- |
| Language fundamentals and modeling | Worked lessons, Swift 101–201 |
| Generics, protocol abstraction, ownership, access control | Worked lessons, Swift 201–301 |
| Inheritance and initialization hierarchy | Discussion in 201; language reference for exhaustive rules |
| Associated types and opaque/existential differences | Discussion in 201 and worked use in 301 |
| Concurrency and network boundaries | Worked lessons, Swift 401 |
| File persistence | Worked lesson, Swift 401 |
| Apple UI and persistence | Four SDK samples, Swift 501; manual interaction checks required |
| Architecture, testing, and release checks | Worked lessons and implemented capstone, Swift 601 |
| Regular expressions, inout, defer, typed throws, operators | [Language supplement](LANGUAGE-SUPPLEMENT.md) |
| Server-side Swift and command-line tooling | [Specialization guide](SPECIALIZATIONS.md) |
| Macros, C/C++/Objective-C interop, advanced ownership | [Specialization guide](SPECIALIZATIONS.md) |
| Combine, Core Data, widgets, watchOS, tvOS, visionOS | [Specialization guide](SPECIALIZATIONS.md); further study |
| Cryptography, GPU programming, distributed actors, embedded Swift | Further study through official ecosystem documentation; not implemented here |

## Suggested study rhythm

Use one or two weeks per level, adjusting for experience. Read a lesson, run its example, attempt the exercise, and keep a short explanation of what changed. At the end of a level, complete its project before advancing. A small working implementation with clear error behavior is better evidence of understanding than memorized syntax.

## Core completion criteria

You can explain value versus reference semantics, model absence without force unwrapping, establish invariants during decoding, select a generic or existential boundary, reason about actor reentrancy, propagate cancellation, and write tests that expose meaningful regressions. For the Apple track, also demonstrate state ownership, stable navigation identity, and accessible interaction.

Use the [glossary](GLOSSARY.md) when terminology gets in the way and the [official references](RESOURCES.md) when you need exact semantics.
