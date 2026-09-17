# Classes, Properties, and Identity

Swift 201 · Modeling and Reuse · 30–45 minutes plus practice

[Previous lesson](01-structs-enums.md) · [Level overview](README.md) · [Next lesson](03-protocols-extensions.md)

## Before you start

Complete Swift 101 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Classes have reference semantics: multiple variables can refer to the same instance. Use them when identity and shared lifetime are part of the problem. Prefer `final` when subclassing is not an intended extension point. A constant class binding still allows mutation of the object’s mutable properties.

Computed properties derive values instead of storing duplicate state. Property observers respond to assignments but are not a substitute for a validated API. Inheritance reuses behavior through a class hierarchy; composition often makes dependencies more explicit. Subclass initializers must satisfy Swift’s initialization rules before using the instance freely.

## Worked example

[Complete source](../../Examples/201/02-classes-properties.swift)

```swift
final class StudyTimer {
    var elapsedSeconds: Int = 0
    var elapsedMinutes: Int { elapsedSeconds / 60 }
    func tick(seconds: Int) {
        guard seconds > 0 else { return }
        elapsedSeconds += seconds
    }
}
let timer = StudyTimer()
let shared = timer
shared.tick(seconds: 125)
print(timer === shared)
print(timer.elapsedMinutes)
struct Settings { var dailyGoal = 20 }
var first = Settings()
var second = first
second.dailyGoal = 40
print(first.dailyGoal, second.dailyGoal)
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 201/02-classes-properties
```

Expected output:

```text
true
2
20 40
```

## Why it works

`===` checks class identity. The shared reference updates the same timer observed by the original binding. The settings struct, by contrast, behaves as an independent value after assignment.

## Common mistake

This timer is an ownership demonstration, not a thread-safe clock. Concurrent access to mutable class state needs isolation. Real elapsed-time tracking should use a clock rather than assume periodic callbacks arrive exactly on time.

## Practice

Make elapsedSeconds externally read-only and add reset(). Explain why `let timer` still permits reset.

<details>
<summary>Solution direction — try it yourself first</summary>

Use `private(set)` and a method that assigns zero. The binding retains the same object, so object mutation does not reassign the binding.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
