# Errors, Codable, and Boundary Validation

Swift 201 · Modeling and Reuse · 30–45 minutes plus practice

[Previous lesson](03-protocols-extensions.md) · [Level overview](README.md) · [Next lesson](05-generics.md)

## Before you start

Complete Swift 101 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Thrown errors represent operations that cannot produce their promised result. `do`/`catch` handles failures, `try` propagates them, and `try?` converts failure to absence when the distinction is intentionally unnecessary. `defer` schedules cleanup for leaving the current scope, including a throwing exit.

Codable combines Encodable and Decodable for conversion between values and external representations. Synthesized decoding maps fields but does not automatically enforce custom business invariants. Treat decoded data as input from outside your domain. Use a custom decoder initializer or validate a transfer object before creating your domain model.

## Worked example

[Complete source](../../Examples/201/04-errors-codable.swift)

```swift
import Foundation
struct SessionDTO: Decodable { let title: String; let minutes: Int }
enum ValidationError: Error { case invalidDuration }
func validatedMinutes(from data: Data) throws -> Int {
    let dto = try JSONDecoder().decode(SessionDTO.self, from: data)
    guard dto.minutes > 0 else { throw ValidationError.invalidDuration }
    return dto.minutes
}
let data = Data(#"{"title":"Decoding","minutes":30}"#.utf8)
do {
    print("Duration: \(try validatedMinutes(from: data))")
    _ = try validatedMinutes(from: Data(#"{"title":"Bad","minutes":0}"#.utf8))
} catch ValidationError.invalidDuration {
    print("Duration must be positive")
} catch {
    print("Could not decode: \(error)")
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 201/04-errors-codable
```

Expected output:

```text
Duration: 30
Duration must be positive
```

## Why it works

The decoder checks structure and primitive types. The guard checks a separate domain rule. Catching a specific validation error produces a useful message without treating malformed JSON and invalid minutes as identical problems.

## Common mistake

Using `try!` with remote JSON turns ordinary invalid input into a crash. A custom initializer is not invoked automatically by synthesized Decodable.

## Practice

Add an upper duration limit of 480 and test a missing minutes key separately from minutes equal to 481.

<details>
<summary>Solution direction — try it yourself first</summary>

Validate `(1...480).contains(dto.minutes)`. A missing key throws a decoding error; 481 should throw your validation error.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
