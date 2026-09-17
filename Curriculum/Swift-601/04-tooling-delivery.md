# Packages, CI, and Release Discipline

Swift 601 · Engineering and Delivery · 30–45 minutes plus practice

[Previous lesson](03-performance.md) · [Level overview](README.md) · [Next lesson](05-input-security.md)

## Before you start

Complete Swift 501 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

A Swift package manifest declares products, targets, and dependencies. A product is what consumers use; a target is a build unit. Keep platform-neutral rules in a library target, a small executable as an adapter, and tests in their own target. The tools-version directive selects manifest compatibility, while language mode determines language checking behavior.

Continuous integration should reproduce the documented developer workflow. This repository compiles and checks every portable example, compares expected output, runs tests, and checks local documentation links. Apple UI samples have a separate SDK check because Linux cannot validate them. A release also needs human review of behavior, compatibility, and documentation.

## Worked example

[Complete source](../../Examples/601/04-tooling-delivery.swift)

```swift
struct Version: Comparable {
    let major: Int
    let minor: Int
    let patch: Int
    static func < (lhs: Self, rhs: Self) -> Bool {
        (lhs.major, lhs.minor, lhs.patch) < (rhs.major, rhs.minor, rhs.patch)
    }
}
let current = Version(major: 1, minor: 2, patch: 0)
let next = Version(major: 1, minor: 3, patch: 0)
print(current < next)
print("Build -> Test -> Review -> Release")
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 601/04-tooling-delivery
```

Expected output:

```text
true
Build -> Test -> Review -> Release
```

## Why it works

The small value type models ordering only. Semantic Versioning also includes prerelease and build metadata, which this teaching example intentionally does not parse. In a library, a major version signals incompatible public API changes under a stated compatibility policy.

## Common mistake

Do not label a CI badge passing before a real workflow has run. A local green check verifies your current toolchain, not every supported operating system or SDK.

## Practice

Inspect Package.swift and identify the library product, executable product, three targets, and language mode. Explain where an HTTP adapter would belong.

<details>
<summary>Solution direction — try it yourself first</summary>

The reusable LearningCore library contains rules; StudyPlanner adapts them to a CLI; LearningCoreTests verifies behavior. Put a reusable transport in a dedicated adapter target if multiple clients need it.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
