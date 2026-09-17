# Property Wrappers and Result Builders

Swift 301 · Advanced Language · 30–45 minutes plus practice

[Previous lesson](02-sequences-keypaths.md) · [Level overview](README.md) · [Next lesson](04-api-design.md)

## Before you start

Complete Swift 201 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

A property wrapper extracts repeated storage behavior into a type exposing wrappedValue. It is useful for small, clear transformations, but hidden side effects make a wrapper harder to understand. A projected value, accessed with a dollar-prefixed property name, can expose an additional interface when needed.

A result builder transforms a supported block syntax into calls such as buildBlock. Builders are a foundation for declarative APIs, but they do not automatically support every language construct. Branches, loops, and optional expressions need corresponding builder methods. Start with a narrow API whose generated behavior can be explained.

## Worked example

[Complete source](../../Examples/301/03-wrappers-builders.swift)

```swift
@propertyWrapper
struct NonNegative {
    private var value: Int
    init(wrappedValue: Int) { value = max(0, wrappedValue) }
    var wrappedValue: Int {
        get { value }
        set { value = max(0, newValue) }
    }
}
@resultBuilder
struct OutlineBuilder {
    static func buildBlock(_ lines: String...) -> [String] { lines }
}
func outline(@OutlineBuilder content: () -> [String]) -> String {
    content().joined(separator: " -> ")
}
struct Goal { @NonNegative var minutes = 20 }
var goal = Goal()
goal.minutes = -5
print(goal.minutes)
print(outline { "Read"; "Code"; "Review" })
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 301/03-wrappers-builders
```

Expected output:

```text
0
Read -> Code -> Review
```

## Why it works

The wrapper clamps both initialization and later assignments. The builder receives three string expressions and combines them into an array. This deliberately minimal builder supports straight-line string blocks only.

## Common mistake

Clamping can conceal invalid data. A validated throwing initializer is often better at a persistence or network boundary. Do not use wrappers to silently rewrite user input without a product decision.

## Practice

Add buildOptional to the builder and investigate why buildBlock also needs to accept arrays if branches return arrays.

<details>
<summary>Solution direction — try it yourself first</summary>

Normalize expressions to `[String]` with buildExpression, flatten `[[String]]` in buildBlock, and return `component ?? []` in buildOptional.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
