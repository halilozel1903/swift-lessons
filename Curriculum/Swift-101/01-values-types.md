# Values, Types, and Operators

Swift 101 · Foundations · 30–45 minutes plus practice

[Level overview](README.md) · [Next lesson](02-control-flow.md)

## Before you start

No previous Swift experience required. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Swift checks types before a program runs. Use `let` for a binding that does not need reassignment and `var` for changing state. Type inference keeps declarations short without making values dynamically typed. An explicit annotation documents an important boundary, such as a function parameter or a numeric conversion.

Integers and floating-point values serve different purposes. Integer division discards the fractional part; convert operands before division when you need a fraction. Prefer integer minor units for this small price example. Real financial calculations also need explicit currency, rounding, and overflow policies. Operators follow precedence rules; parentheses make business intent easier to read.

## Worked example

[Complete source](../../Examples/101/01-values-types.swift)

```swift
let course = "Swift Foundations"
let unitPriceInCents: Int = 1250
var seats = 2
seats += 1
let totalInCents = unitPriceInCents * seats
let averageHours = Double(7) / Double(2)
print("\(course): \(seats) seats")
print("Total: \(totalInCents) cents")
print("Average: \(averageHours) hours")
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 101/01-values-types
```

Expected output:

```text
Swift Foundations: 3 seats
Total: 3750 cents
Average: 3.5 hours
```

## Why it works

`seats += 1` updates the only mutable binding. Interpolation inserts values into a string without changing their types. `Double(7) / Double(2)` produces 3.5; converting the result of `7 / 2` would produce 3.0 because truncation already happened.

## Common mistake

`let` prevents reassignment of a binding. It does not make every object reachable through a class reference immutable. Ordinary integer arithmetic can trap on overflow; wrapping operators are a separate, deliberate choice.

## Practice

Add a 250-cent discount per seat. Print the total after the discount. Explain why converting an already-divided integer does not restore its fraction.

<details>
<summary>Solution direction — try it yourself first</summary>

Compute `(unitPriceInCents - 250) * seats`; the result is 3000. Convert operands, not a truncated result.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
