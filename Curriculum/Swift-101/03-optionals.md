# Optionals and Safe Unwrapping

Swift 101 · Foundations · 30–45 minutes plus practice

[Previous lesson](02-control-flow.md) · [Level overview](README.md) · [Next lesson](04-collections-strings.md)

## Before you start

No previous Swift experience required. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

An optional represents either a wrapped value or its absence. `Int("42")` returns `Int?` because arbitrary text may not contain an integer. Treat this absence as part of your model rather than an exceptional crash.

Optional binding with `if let` creates a value for a branch. `guard let` creates a value for the remainder of a scope after an early exit. Optional chaining stops evaluation when an intermediate optional is absent. Nil coalescing supplies a fallback, but choose a fallback only when it makes sense in the domain: an unknown price should not silently become zero.

## Worked example

[Complete source](../../Examples/101/03-optionals.swift)

```swift
struct Profile { let nickname: String? }
func minutes(from input: String?) -> Int? {
    guard let input, let value = Int(input), value > 0 else { return nil }
    return value
}
let profile: Profile? = Profile(nickname: nil)
print(profile?.nickname ?? "Guest")
print(minutes(from: "25") ?? 0)
print(minutes(from: "invalid") == nil)
if let duration = minutes(from: "40") {
    print("Study for \(duration) minutes")
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 101/03-optionals
```

Expected output:

```text
Guest
25
true
Study for 40 minutes
```

## Why it works

The parser handles absent text, malformed numbers, and nonpositive numbers with one guard. The caller can distinguish missing data from a valid integer. The zero fallback is only a display choice in this demonstration, not a stored duration.

## Common mistake

A force unwrap (`!`) crashes if the value is nil. Replacing it with `?? 0` everywhere can hide invalid input instead of handling it.

## Practice

Parse a port number from optional text and accept only 1 through 65535. Verify nil, zero, letters, 443, and 65536.

<details>
<summary>Solution direction — try it yourself first</summary>

Bind the text and integer in a guard, then check `(1...65535).contains(value)`. Return nil for all listed cases except 443.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
