# Performance, Complexity, and Diagnostics

Swift 601 · Engineering and Delivery · 30–45 minutes plus practice

[Previous lesson](02-architecture.md) · [Level overview](README.md) · [Next lesson](04-tooling-delivery.md)

## Before you start

Complete Swift 501 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Performance starts with a measurable workload and a concrete goal. Algorithmic complexity explains growth as input size increases; profiling identifies where your actual program spends time. A linear scan can be perfectly appropriate for small data, while repeated scans inside a loop may become a bottleneck.

Measure optimized builds, use realistic inputs, and distinguish wall-clock time, allocations, and memory retained after an operation. On Apple platforms, Instruments helps inspect time and allocations. Avoid presenting one tiny benchmark as universal proof. UI responsiveness also depends on isolation: a fast average does not excuse blocking the main actor during a long worst-case input.

## Worked example

[Complete source](../../Examples/601/03-performance.swift)

```swift
let completed = Array(0..<10_000)
let candidates = [3, 9_999, 10_001]
// Build once when performing many membership queries.
let lookup = Set(completed)
let remaining = candidates.filter { !lookup.contains($0) }
print(remaining)
let sortedCandidates = candidates.sorted()
print(sortedCandidates)
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 601/03-performance
```

Expected output:

```text
[10001]
[3, 9999, 10001]
```

## Why it works

Building the set costs time and memory up front but allows expected constant-time membership queries. Filtering with repeated array contains calls would scan up to the entire completed list for each candidate.

## Common mistake

The set is not automatically faster for one lookup on a tiny array. Hashing cost and memory overhead matter. Do not optimize by removing validation without evidence and a preserved contract.

## Practice

Compare repeated array membership with a prebuilt set for 100, 10,000, and 100,000 inputs. Record build mode and include construction cost separately.

<details>
<summary>Solution direction — try it yourself first</summary>

Use a monotonic clock, repeat measurements, and retain the computed results so the optimizer cannot discard unused work. Report distributions and workload details rather than a single universal speedup.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
