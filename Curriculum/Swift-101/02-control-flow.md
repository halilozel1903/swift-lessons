# Control Flow and Pattern Matching

Swift 101 · Foundations · 30–45 minutes plus practice

[Previous lesson](01-values-types.md) · [Level overview](README.md) · [Next lesson](03-optionals.md)

## Before you start

No previous Swift experience required. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Branching expresses decisions and loops express repetition. An `if` condition must be a `Bool`; Swift does not treat arbitrary integers as true or false. A `switch` must cover every possible case, which makes it useful for turning categories into behavior. Cases do not fall through automatically.

Ranges describe intervals: `1...3` includes the last value, while `0..<3` excludes it. Use a half-open range when the upper bound is a count. A `where` clause filters loop elements without adding a nested branch. `guard` is best for requirements that must hold for the rest of a scope; its failure branch must leave that scope.

## Worked example

[Complete source](../../Examples/101/02-control-flow.swift)

```swift
func label(for score: Int) -> String {
    guard (0...100).contains(score) else { return "Invalid" }
    switch score {
    case 90...100: return "Excellent"
    case 60..<90: return "Passed"
    default: return "Practice again"
    }
}
for score in [45, 75, 95, 110] {
    print("\(score): \(label(for: score))")
}
let evenNumbers = (1...6).filter { $0.isMultiple(of: 2) }
print(evenNumbers)
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 101/02-control-flow
```

Expected output:

```text
45: Practice again
75: Passed
95: Excellent
110: Invalid
[2, 4, 6]
```

## Why it works

The guard rejects values outside the domain before grading starts. The switch then handles three disjoint regions. The filter closure returns a Boolean for each number; only matching numbers survive.

## Common mistake

Do not construct `1...count` when count might be zero. Prefer iterating the collection directly or using its indices.

## Practice

Add a Distinction category for 80 through 89 and test scores 79, 80, 89, and 90.

<details>
<summary>Solution direction — try it yourself first</summary>

Place `case 80..<90` before the broad passing case. The four results should be Passed, Distinction, Distinction, Excellent.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
