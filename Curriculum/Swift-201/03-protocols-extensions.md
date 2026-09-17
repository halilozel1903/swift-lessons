# Protocols, Extensions, and Dependency Injection

Swift 201 · Modeling and Reuse · 30–45 minutes plus practice

[Previous lesson](02-classes-properties.md) · [Level overview](README.md) · [Next lesson](04-errors-codable.md)

## Before you start

Complete Swift 101 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

A protocol describes capabilities that conforming types provide. It separates what a caller needs from how a dependency implements it. An extension adds methods or computed properties, and a constrained extension can offer behavior only to suitable types. Extensions cannot add stored instance properties.

Dependency injection means passing collaborators into the code that uses them. A small protocol lets tests supply deterministic values instead of depending on a database or a remote service. Avoid creating a protocol for every type automatically: introduce one at a boundary where alternate behavior or isolation is useful.

## Worked example

[Complete source](../../Examples/201/03-protocols-extensions.swift)

```swift
protocol TopicSource {
    func topics() -> [String]
}
struct LocalTopics: TopicSource {
    func topics() -> [String] { ["Protocols", "Testing"] }
}
extension TopicSource {
    func summary() -> String { topics().joined(separator: ", ") }
}
struct CourseScreen {
    let source: any TopicSource
    func render() -> String { source.summary() }
}
let screen = CourseScreen(source: LocalTopics())
print(screen.render())
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 201/03-protocols-extensions
```

Expected output:

```text
Protocols, Testing
```

## Why it works

The screen depends only on TopicSource, not LocalTopics. `any TopicSource` stores a value behind an existential boundary. The extension implements reusable behavior using the required method.

## Common mistake

An extension-only method is not a protocol requirement. If conformers must customize behavior through a protocol-typed value, declare that method in the protocol and optionally supply a default implementation.

## Practice

Add an EmptyTopics implementation and render the screen with it. Decide whether the empty message belongs in the source or presentation code.

<details>
<summary>Solution direction — try it yourself first</summary>

Return an empty array from the new source. Let presentation code render a friendly empty state; the source should not invent UI strings.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
