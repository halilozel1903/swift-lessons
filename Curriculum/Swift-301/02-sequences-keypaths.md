# Sequences, Lazy Evaluation, and Key Paths

Swift 301 · Advanced Language · 30–45 minutes plus practice

[Previous lesson](01-memory-ownership.md) · [Level overview](README.md) · [Next lesson](03-wrappers-builders.md)

## Before you start

Complete Swift 201 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Sequence describes values that can be traversed; Collection adds reusable indexed access. A sequence is not necessarily repeatable or finite. Algorithms should require only the capabilities they actually need. Laziness can postpone transformations and avoid constructing intermediate arrays, but it is not an automatic performance guarantee.

Key paths represent access to a property as a typed value. They work well for mapping and reusable sorting helpers. Value collections use copy-on-write techniques in many standard library implementations; logically independent values may share storage until mutation. That optimization does not change the value semantics your code observes.

## Worked example

[Complete source](../../Examples/301/02-sequences-keypaths.swift)

```swift
struct Topic {
    let title: String
    let minutes: Int
}
let topics = [Topic(title: "ARC", minutes: 20), Topic(title: "Actors", minutes: 40)]
print(topics.map(\.title))
let total = topics.lazy.filter { $0.minutes >= 30 }.map(\.minutes).reduce(0, +)
print(total)
let firstThreeSquares = (1...).lazy.map { $0 * $0 }.prefix(3)
print(Array(firstThreeSquares))
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 301/02-sequences-keypaths
```

Expected output:

```text
["ARC", "Actors"]
40
[1, 4, 9]
```

## Why it works

The key path `\.title` stands in for a property-reading transform. The lazy chain computes only the values consumed downstream. Taking a finite prefix lets us safely consume a conceptually unbounded range.

## Common mistake

Converting an unbounded sequence to an array without a bound does not terminate normally. Benchmark release builds before concluding that a lazy chain is faster.

## Practice

Produce the titles of topics lasting at least 30 minutes and stop after the first result.

<details>
<summary>Solution direction — try it yourself first</summary>

Use `Array(topics.lazy.filter { $0.minutes >= 30 }.map(\.title).prefix(1))`; the result contains Actors.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
