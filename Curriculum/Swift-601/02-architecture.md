# Architecture and Explicit Dependencies

Swift 601 · Engineering and Delivery · 30–45 minutes plus practice

[Previous lesson](01-testing.md) · [Level overview](README.md) · [Next lesson](03-performance.md)

## Before you start

Complete Swift 501 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Architecture is the arrangement of responsibilities and dependency direction. Keep business rules independent of UI frameworks and transport details so they can be exercised in isolation. A feature can have a value model, a service boundary, and a presentation layer without adopting a large framework.

Dependency injection works best with narrow interfaces. Inject data sources, clocks, or identifiers where tests need control; do not inject every standard library operation. Represent loading, empty, success, and failure states explicitly in UI code. When requests overlap, define whether stale results should be ignored, cancelled, or merged.

## Worked example

[Complete source](../../Examples/601/02-architecture.swift)

```swift
protocol RecommendationSource {
    func candidates() -> [String]
}
struct FixtureRecommendations: RecommendationSource {
    func candidates() -> [String] { ["Actors", "Testing", "Actors"] }
}
struct RecommendationService<Source: RecommendationSource> {
    let source: Source
    func recommendations(completed: Set<String>) -> [String] {
        Set(source.candidates()).subtracting(completed).sorted()
    }
}
let service = RecommendationService(source: FixtureRecommendations())
print(service.recommendations(completed: ["Actors"]))
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 601/02-architecture
```

Expected output:

```text
["Testing"]
```

## Why it works

The service owns the rule: remove completed topics, deduplicate, and order results. The source supplies candidates without controlling presentation. The output is stable, making both a CLI and a UI easy to test against it.

## Common mistake

A global singleton hides lifetime and makes concurrent tests interfere. Conversely, dozens of one-method protocols can obscure a small feature. Introduce boundaries for actual variation and ownership needs.

## Practice

Add a recommendation limit. Define zero and negative limits and test deduplication before limiting.

<details>
<summary>Solution direction — try it yourself first</summary>

Return an empty array for a nonpositive limit, or reject it in a validated configuration. Apply prefix after sorting and deduplication so the result is predictable.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
