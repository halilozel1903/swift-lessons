# Cancellation and Asynchronous Sequences

Swift 401 · Concurrency and Data · 30–45 minutes plus practice

[Previous lesson](02-actors-sendable.md) · [Level overview](README.md) · [Next lesson](04-networking.md)

## Before you start

Complete Swift 301 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Cancellation is a cooperative signal. An operation must check cancellation or call a cancellation-aware API to stop promptly. Code that catches every error and continues can accidentally swallow cancellation. Task cancellation does not undo side effects that already happened; transactional or compensation logic belongs in the domain.

AsyncSequence models a stream of values produced over time. `for await` consumes a nonthrowing sequence, while a throwing iterator requires `for try await`. AsyncStream adapts callback-style producers, but real adapters must also stop the producer when consumption ends and define buffering behavior. A finite, prefilled stream keeps this first example deterministic.

## Worked example

[Complete source](../../Examples/401/03-cancellation-streams.swift)

```swift
@main struct Demo {
    static func main() async {
        let stream = AsyncStream<Int> { continuation in
            continuation.yield(10)
            continuation.yield(20)
            continuation.finish()
        }
        var total = 0
        for await minutes in stream { total += minutes }
        print("Stream total: \(total)")
        let task = Task { () throws -> Void in
            while true {
                try Task.checkCancellation()
                try await Task.sleep(for: .seconds(60))
            }
        }
        task.cancel()
        do { try await task.value }
        catch is CancellationError { print("Cancelled cleanly") }
        catch { print("Unexpected: \(error)") }
    }
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 401/03-cancellation-streams
```

Expected output:

```text
Stream total: 30
Cancelled cleanly
```

## Why it works

The continuation finishes explicitly, allowing iteration to end. Cancelling the task before awaiting its result makes the loop exit either through the explicit check or the cancellation-aware sleep.

## Common mistake

The default AsyncStream buffer can grow without bound for a fast producer. Choose a buffering policy and handle dropped values when adapting live events. Install onTermination cleanup for subscriptions.

## Practice

Create a stream using `.bufferingNewest(1)` and yield 1, 2, and 3 before starting consumption. Predict the observed values.

<details>
<summary>Solution direction — try it yourself first</summary>

Only 3 remains in the buffer when consumption begins. This policy is suitable for replaceable state updates, not lossless financial events.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
