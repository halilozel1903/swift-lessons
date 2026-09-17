<div align="center">

# Swift Dersleri

### A practical Swift curriculum, from first principles to production habits.

**Swift 101 → 201 → 301 → 401 → 501 → 601**

[![CI](https://github.com/halilozel1903/swift-dersleri/actions/workflows/ci.yml/badge.svg)](https://github.com/halilozel1903/swift-dersleri/actions/workflows/ci.yml)
[![Swift](https://img.shields.io/badge/Swift-6-F05138?logo=swift&logoColor=white)](https://www.swift.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[Start learning](Curriculum/Swift-101/README.md) · [Browse the curriculum](docs/CURRICULUM.md) · [Run the capstone](Projects/StudyPlanner/README.md) · [Contribute](CONTRIBUTING.md)

</div>

---

**Swift Dersleri** means “Swift Lessons.” This repository is an English-language learning path for developers who want to understand Swift, write working programs, and build reliable applications.

The course moves from values and optionals to modeling, generics, ownership, concurrency, networking, Apple UI, testing, and delivery. Each lesson explains a concept, walks through a complete example, identifies a common mistake, and provides an exercise with a solution direction.

## What is inside

- **29 written lessons** across six progressive levels.
- **25 executable examples** with checked expected output; no external service or package dependency required.
- **4 Apple framework samples** covering SwiftUI, Observation, navigation, SwiftData, and UIKit interoperability.
- **6 level projects** with completion criteria, plus an implemented **Study Planner** capstone.
- **A tested Swift package**, a CLI, and GitHub Actions workflows for Linux and Apple SDK checks.
- **Specialization guides** for server development, interoperability, macros, lower-level ownership, and the wider Apple ecosystem.

This is a broad foundation with practical depth in the core language. The specialization guides identify additional paths; they do not claim to replace every framework’s documentation or provide a complete production app for every platform.

## Choose your starting point

| Level | Focus | You will learn to |
| --- | --- | --- |
| [Swift 101](Curriculum/Swift-101/README.md) | Foundations | Work with values, control flow, optionals, collections, functions, and closures |
| [Swift 201](Curriculum/Swift-201/README.md) | Modeling and reuse | Design structs, enums, classes, protocols, validated models, and generic containers |
| [Swift 301](Curriculum/Swift-301/README.md) | Advanced language | Reason about ARC, sequences, wrappers, builders, access control, and type abstraction |
| [Swift 401](Curriculum/Swift-401/README.md) | Concurrency and data | Use tasks, actors, cancellation, streams, HTTP boundaries, and file persistence |
| [Swift 501](Curriculum/Swift-501/README.md) | Apple applications | Build state-driven views, navigation, persistence, and UIKit bridges |
| [Swift 601](Curriculum/Swift-601/README.md) | Engineering and delivery | Test behavior, separate dependencies, assess performance, and automate checks |

New to programming? Begin at 101 and allow extra time for the exercises. Already building apps? Use each level’s exit criteria to find gaps rather than skipping the language foundations automatically.

## Quick start

Install a [Swift 6 toolchain](https://www.swift.org/install/) and Python 3.10 or later for the verification scripts. On macOS, full Xcode is required for Apple framework checks. The portable examples and package are intended for macOS and Linux; Windows is not part of the CI matrix.

```bash
git clone https://github.com/halilozel1903/swift-dersleri.git
cd swift-dersleri
swift --version
swift test
swift run study-planner
python3 scripts/verify.py --example 101/01-values-types
```

The capstone prints:

```text
Study Planner
Completed: 1/3
Remaining: 75 minutes
Progress: 33%
```

Run all portable examples and documentation checks:

```bash
python3 scripts/verify.py
```

On macOS with Xcode, also run:

```bash
bash scripts/check-apple.sh
```

The package declares Swift tools 6.0 and Swift 6 language mode. CI targets Swift 6.0.3 on Linux and the installed Swift 6 toolchain on the macOS runner. Apple samples target iOS 17+ or macOS 14+ where applicable. See [setup and troubleshooting](docs/SETUP.md) and [Apple sample instructions](AppleExamples/README.md).

## How to study

1. **Read** the concept and predict the example’s output.
2. **Run** the complete source and compare your prediction.
3. **Change** one input or implementation detail and explain the result.
4. **Practice** before opening the solution direction.
5. **Build** the level project and verify its exit criteria.

A reasonable self-paced schedule is one level every one or two weeks. Your ability to explain and adapt the code matters more than finishing on a date. A lesson typically takes 30–45 minutes to read and explore; exercises and projects take additional time.

## Repository map

```text
Curriculum/          Written lessons, examples, exercises, and level projects
Examples/            Portable Swift examples and expected output
AppleExamples/       SDK-specific UI and persistence samples
Sources/             LearningCore library and StudyPlanner executable
Tests/               Swift Testing behavior and concurrency tests
Projects/            Capstone walkthrough and extension requirements
docs/                Setup, curriculum map, glossary, and specialization guides
scripts/             Example runner, link checker, and Apple SDK checker
.github/             CI workflows and contribution templates
```

## Build something that lasts

The [Study Planner capstone](Projects/StudyPlanner/README.md) combines validated Codable models, value semantics, actor-isolated mutation, and deterministic tests. It is intentionally small enough to understand end to end. Extend it with persistence or a UI after you can explain the existing contracts.

The [topic coverage map](docs/CURRICULUM.md) distinguishes implemented lessons from further study. The [specialization guide](docs/SPECIALIZATIONS.md) explains where server-side Swift, macros, C/C++ interoperability, and platform-specific frameworks fit.

## Contributing and license

Corrections, clearer explanations, and focused examples are welcome. Read the [contribution guide](CONTRIBUTING.md), [code of conduct](CODE_OF_CONDUCT.md), and [security policy](SECURITY.md) before opening an issue or pull request.

Code and original lesson text are available under the [MIT license](LICENSE). External documentation remains under its respective owners’ terms. Swift and Apple framework names belong to their respective owners; this is an independent educational project.
