# Casting, Subscripts, and Conditional Conformance

Swift 301 · Advanced Language · 30–45 minutes plus practice

[Previous lesson](04-api-design.md) · [Level overview](README.md)

## Before you start

Complete Swift 201 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Type casting inspects or converts a value at runtime. `as?` returns an optional when a downcast might fail; `is` checks compatibility. Prefer an explicit protocol or enum when you control the model, reserving heterogeneous Any values for integration boundaries.

Subscripts provide indexed access with a domain-specific policy. A custom safe accessor can return nil for invalid positions without changing how ordinary array subscripts behave. Conditional conformance states that a generic container gains a capability only when its element has that capability. This keeps the type relationship precise instead of promising operations that arbitrary elements cannot support.

## Worked example

[Complete source](../../Examples/301/05-advanced-language.swift)

```swift
struct Box<Value> { let value: Value }
extension Box: Equatable where Value: Equatable {}
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
let values: [Any] = ["Swift", 42]
for value in values {
    if let text = value as? String { print(text.uppercased()) }
}
print(Box(value: 7) == Box(value: 7))
print([10, 20][safe: 5] == nil)
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 301/05-advanced-language
```

Expected output:

```text
SWIFT
true
true
```

## Why it works

Only the string passes the conditional cast. Box can synthesize equality when Value supports equality. The labeled subscript advertises optional failure and checks indices before indexing.

## Common mistake

A nil-returning accessor can hide a logic error when an index was supposed to be valid. Use it when out-of-range access is expected input, not to silence every bounds mistake.

## Practice

Add conditional Hashable conformance to Box and place two equal boxes in a set.

<details>
<summary>Solution direction — try it yourself first</summary>

Write `extension Box: Hashable where Value: Hashable {}`. A Set containing Box(value: 7) twice has count 1.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
