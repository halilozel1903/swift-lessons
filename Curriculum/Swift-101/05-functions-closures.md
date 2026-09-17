# Functions and Closures

Swift 101 · Foundations · 30–45 minutes plus practice

[Previous lesson](04-collections-strings.md) · [Level overview](README.md)

## Before you start

No previous Swift experience required. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Functions name reusable behavior and make inputs and outputs explicit. External argument labels describe a call; internal parameter names describe the implementation. A default argument supplies a normal case without requiring several overloads. A tuple can return a small group of related values; a named struct is often better once that group becomes part of a public API.

Closures are values containing behavior. Collection operations accept closures so callers can select, transform, and aggregate data. `map` preserves element count, `filter` can reduce it, and `reduce` combines elements into one result. Keep complex transformations in named functions rather than compressing an entire feature into one chain.

## Worked example

[Complete source](../../Examples/101/05-functions-closures.swift)

```swift
func studyMessage(for name: String, minutes: Int = 25) -> String {
    "\(name), study for \(minutes) minutes."
}
let sessions = [10, 25, 40]
let focusedSessions = sessions.filter { $0 >= 25 }
let doubled = focusedSessions.map { $0 * 2 }
let total = doubled.reduce(0, +)
print(studyMessage(for: "Alex"))
print(doubled)
print("Total: \(total)")
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 101/05-functions-closures
```

Expected output:

```text
Alex, study for 25 minutes.
[50, 80]
Total: 130
```

## Why it works

The call reads naturally because of the `for` label. The default supplies 25. `$0` denotes a closure argument inferred from context; replace it with a descriptive name if the expression becomes difficult to follow.

## Common mistake

A closure that escapes a function can outlive the local work that created it. Capturing a class instance strongly in a stored closure can form a reference cycle; study ownership in Swift 301.

## Practice

Write `summarize(_:)` returning a tuple with session count and total minutes. Check the empty array.

<details>
<summary>Solution direction — try it yourself first</summary>

Return `(count: sessions.count, minutes: sessions.reduce(0, +))`. An empty array returns count 0 and minutes 0.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
