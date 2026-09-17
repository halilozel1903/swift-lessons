# Collections, Strings, and Unicode

Swift 101 · Foundations · 30–45 minutes plus practice

[Previous lesson](03-optionals.md) · [Level overview](README.md) · [Next lesson](05-functions-closures.md)

## Before you start

No previous Swift experience required. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

An array stores an ordered sequence, a set stores unique members, and a dictionary maps unique keys to values. Choose a structure based on the operations you need, not just syntax. Sets and dictionaries offer expected constant-time lookup under ordinary hashing assumptions; array searches generally scan elements.

Swift strings are Unicode-aware collections of characters. A user-perceived character may contain several Unicode scalars or bytes, so integer byte offsets are not general-purpose string indices. Use `String.Index`, collection traversal, or prefix operations. A substring can share storage with a larger string; make a `String` copy when keeping a small slice for a long time.

## Worked example

[Complete source](../../Examples/101/04-collections-strings.swift)

```swift
let topics = ["Swift", "Actors", "Swift"]
let uniqueTopics = Set(topics)
var visits: [String: Int] = [:]
for topic in topics { visits[topic, default: 0] += 1 }
let greeting = "Hi 👩🏽‍💻"
print(uniqueTopics.sorted())
print(visits["Swift", default: 0])
print("Characters: \(greeting.count)")
print(String(greeting.prefix(2)))
print(Array(topics.enumerated()).map { "\($0.offset): \($0.element)" })
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 101/04-collections-strings
```

Expected output:

```text
["Actors", "Swift"]
2
Characters: 4
Hi
["0: Swift", "1: Actors", "2: Swift"]
```

## Why it works

Sorting the set produces deterministic output; a set itself has no promised display order. The dictionary default subscript supports incrementing a missing count. The emoji occupies one Character even though its encoding contains multiple units.

## Common mistake

An array subscript outside its valid indices traps. Dictionary lookup usually returns an optional. Do not assume these operations have identical failure behavior.

## Practice

Count each word in `["read", "code", "read", "test"]`. Print keys alphabetically with their counts.

<details>
<summary>Solution direction — try it yourself first</summary>

Increment `counts[word, default: 0]`, then iterate `counts.keys.sorted()`. Expected counts: code 1, read 2, test 1.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
