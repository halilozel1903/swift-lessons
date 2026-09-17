# Files, Persistence, and Schema Evolution

Swift 401 · Concurrency and Data · 30–45 minutes plus practice

[Previous lesson](04-networking.md) · [Level overview](README.md)

## Before you start

Complete Swift 301 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Persistence extends your data contract beyond a single process run. Codable is convenient for small structured files, but you must decide where files belong, how corruption is handled, and how old versions migrate. Bundle resources are usually read-only; user documents, caches, and application support have different lifecycle rules.

An atomic write uses a replacement strategy to reduce the chance of leaving a partially written destination. It does not coordinate competing writers or create a database transaction. Serialize ownership of writes and keep large disk operations away from latency-sensitive UI work. A temporary directory makes this lesson safe to run repeatedly without changing user files.

## Worked example

[Complete source](../../Examples/401/05-files-persistence.swift)

```swift
import Foundation
struct Archive: Codable, Equatable {
    let version: Int
    let topics: [String]
}
let manager = FileManager.default
let directory = manager.temporaryDirectory.appendingPathComponent(UUID().uuidString)
try manager.createDirectory(at: directory, withIntermediateDirectories: true)
defer { try? manager.removeItem(at: directory) }
let file = directory.appendingPathComponent("topics.json")
let archive = Archive(version: 1, topics: ["Files", "Migration"])
try JSONEncoder().encode(archive).write(to: file, options: .atomic)
let restored = try JSONDecoder().decode(Archive.self, from: Data(contentsOf: file))
print("Version: \(restored.version)")
print(restored == archive)
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 401/05-files-persistence
```

Expected output:

```text
Version: 1
true
```

## Why it works

The example owns a unique temporary directory and removes it on scope exit. Encoding, writing, reading, and decoding are separate failure points. Equality verifies the round trip rather than relying on dictionary key order in generated JSON.

## Common mistake

A schema version field alone does not implement migration. Branch on supported versions and reject or migrate unknown formats before treating them as valid domain data.

## Practice

Design version 2 with a duration per topic. Specify what duration older archives receive and how you will test migration.

<details>
<summary>Solution direction — try it yourself first</summary>

Decode version 1 into its original DTO, map each title to a version 2 topic with a documented default duration, and test a committed version 1 fixture.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
