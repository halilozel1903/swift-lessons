# Actors, Sendable, and Reentrancy

Swift 401 · Concurrency and Data · 30–45 minutes plus practice

[Previous lesson](01-async-await.md) · [Level overview](README.md) · [Next lesson](03-cancellation-streams.md)

## Before you start

Complete Swift 301 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

An actor isolates its mutable state so outside callers must respect that isolation. Sendable describes values that can safely cross concurrency boundaries. Immutable value models are often a good fit; mutable class references require a stronger design. Swift 6 language mode checks many isolation violations at compile time.

Actor isolation protects individual accesses but does not make an entire async method transactional. At a suspension point another operation can enter the actor and change its state. Recheck assumptions after awaiting, or perform a mutation in one synchronous actor-isolated section. `@MainActor` expresses UI isolation; it is not a general-purpose substitute for all application actors.

## Worked example

[Complete source](../../Examples/401/02-actors-sendable.swift)

```swift
actor SeatInventory {
    private var available = 2
    func reserve() -> Bool {
        guard available > 0 else { return false }
        available -= 1
        return true
    }
    func remaining() -> Int { available }
}
@main struct Demo {
    static func main() async {
        let inventory = SeatInventory()
        let successes = await withTaskGroup(of: Bool.self) { group in
            for _ in 0..<5 { group.addTask { await inventory.reserve() } }
            var count = 0
            for await reserved in group { if reserved { count += 1 } }
            return count
        }
        print("Reservations: \(successes)")
        print("Remaining: \(await inventory.remaining())")
    }
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 401/02-actors-sendable
```

Expected output:

```text
Reservations: 2
Remaining: 0
```

## Why it works

Reservation checks and subtraction occur without suspension, preventing overselling within this actor. Five callers compete for two seats, but the identity of the successful callers is deliberately unspecified.

## Common mistake

`@unchecked Sendable` disables compiler verification for a conformance; it does not add locks. Use it only when a documented synchronization design establishes the guarantee.

## Practice

Imagine reserve awaits payment after reading availability. Describe how two callers could use the same stale availability and design a reservation token.

<details>
<summary>Solution direction — try it yourself first</summary>

Deduct capacity and create a pending token before suspension; confirm or release the token after payment. Define duplicate completion and cancellation behavior explicitly.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
