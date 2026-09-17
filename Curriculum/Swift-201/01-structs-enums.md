# Structs, Enums, and Invariants

Swift 201 · Modeling and Reuse · 30–45 minutes plus practice

[Level overview](README.md) · [Next lesson](02-classes-properties.md)

## Before you start

Complete Swift 101 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Structs group related values and copy with value semantics. A mutating method declares that it may change the value on which it is called. An initializer is the boundary where a model should establish its rules; a failable initializer returns nil when it cannot create a valid instance.

Enums describe a closed set of alternatives. Associated values carry data specific to a case, avoiding unrelated flags that allow contradictory states. A loading screen represented by idle, loading, loaded, or failed cannot accidentally be both loaded and loading. This approach scales from small command-line tools to feature state in applications.

## Worked example

[Complete source](../../Examples/201/01-structs-enums.swift)

```swift
struct Session {
    let title: String
    private(set) var minutes: Int
    init?(title: String, minutes: Int) {
        guard !title.isEmpty, minutes > 0 else { return nil }
        self.title = title
        self.minutes = minutes
    }
    mutating func shorten() { minutes = max(1, minutes / 2) }
}
enum LoadState { case idle, loaded([String]), failed(String) }
if var session = Session(title: "Enums", minutes: 30) {
    let original = session
    session.shorten()
    print(original.minutes, session.minutes)
}
let state = LoadState.loaded(["Optionals", "Enums"])
switch state {
case .idle: print("Ready")
case .loaded(let topics): print("Loaded \(topics.count) topics")
case .failed(let message): print(message)
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 201/01-structs-enums
```

Expected output:

```text
30 15
Loaded 2 topics
```

## Why it works

The private setter lets callers observe minutes without bypassing the model’s mutation rules. Copying `session` preserves the original value. Pattern matching unwraps the associated topics only in the loaded branch.

## Common mistake

A struct containing a class reference does not automatically deep-copy that object. Value semantics require considering all stored properties.

## Practice

Add a loading case with a progress value and decide where the 0...1 invariant should be enforced.

<details>
<summary>Solution direction — try it yourself first</summary>

Use a validated progress type as an associated value if invalid progress must be impossible. A plain Double case cannot validate itself at construction.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
