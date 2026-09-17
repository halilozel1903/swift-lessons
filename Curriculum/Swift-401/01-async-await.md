# Async/Await and Structured Concurrency

Swift 401 · Concurrency and Data · 30–45 minutes plus practice

[Level overview](README.md) · [Next lesson](02-actors-sendable.md)

## Before you start

Complete Swift 301 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

An async function can suspend without blocking a thread while it waits. `await` marks a possible suspension point; it does not itself mean work starts on a background thread. Async code can still perform expensive synchronous work, so separate CPU-heavy work from UI isolation deliberately.

Use `async let` for a fixed number of child operations that belong to one scope. A task group supports a dynamic number of children. Structured children have a bounded lifetime: the parent scope cannot simply abandon them. Results from a task group arrive in completion order, which may differ from input order; attach an index if input ordering matters.

## Worked example

[Complete source](../../Examples/401/01-async-await.swift)

```swift
func loadTitle() async -> String { "Structured Concurrency" }
func loadDuration() async -> Int { 45 }
@main struct Demo {
    static func main() async {
        async let title = loadTitle()
        async let duration = loadDuration()
        let result = await (title, duration)
        print("\(result.0): \(result.1) minutes")
        let total = await withTaskGroup(of: Int.self) { group in
            for value in 1...3 { group.addTask { value * value } }
            var sum = 0
            for await value in group { sum += value }
            return sum
        }
        print("Sum: \(total)")
    }
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 401/01-async-await
```

Expected output:

```text
Structured Concurrency: 45 minutes
Sum: 14
```

## Why it works

The two async-let bindings express independent child operations. The tuple awaits both values. The task-group reduction uses addition, so it produces the same answer regardless of child completion order. The fixture functions return immediately to keep the example offline.

## Common mistake

Creating thousands of child tasks at once can overwhelm memory or a service. Limit in-flight work when processing large inputs. `Task {}` creates an unstructured task; retain its handle when ownership requires cancellation or awaiting completion.

## Practice

Change the group to return `(index, square)` pairs and collect results in the original order.

<details>
<summary>Solution direction — try it yourself first</summary>

Keep each input index with its result, sort by index after collection, and map to the square. Completion order should never be assumed.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
