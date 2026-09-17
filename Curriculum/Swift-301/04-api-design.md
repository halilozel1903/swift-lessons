# Access Control, Opaque Types, and API Design

Swift 301 · Advanced Language · 30–45 minutes plus practice

[Previous lesson](03-wrappers-builders.md) · [Level overview](README.md) · [Next lesson](05-advanced-language.md)

## Before you start

Complete Swift 201 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Access control limits the surface other code can depend on. Declarations default to internal within a module. Public libraries must explicitly expose intended types, initializers, and members. `private` is a lexical implementation boundary, while `fileprivate` allows access within the file. An open class or method permits external subclassing or overriding; public alone does not.

Use a concrete type when it is the best API. A generic input preserves the caller’s type. An opaque result hides a concrete implementation while retaining static identity. An existential allows runtime variation behind a protocol. These tools solve different problems and should not be selected solely to shorten a signature.

## Worked example

[Complete source](../../Examples/301/04-api-design.swift)

```swift
protocol Named { var name: String { get } }
struct Course: Named { let name: String }
struct Author: Named { let name: String }
func featuredCourse() -> some Named { Course(name: "Advanced Swift") }
func describe<T: Named>(_ value: T) -> String { value.name }
let catalog: [any Named] = [Course(name: "Swift"), Author(name: "Alex")]
print(describe(featuredCourse()))
print(catalog.map(\.name).joined(separator: ", "))
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 301/04-api-design
```

Expected output:

```text
Advanced Swift
Swift, Alex
```

## Why it works

The opaque result always uses Course here. The existential array contains two different underlying types. The generic describe function works with each concrete conformer without erasing its type at the parameter boundary.

## Common mistake

A function returning `some Named` cannot return Course in one branch and Author in another unless both branches are unified into one underlying type. Also, an implicit memberwise struct initializer is not automatically public.

## Practice

Design a public Course value with a publicly readable name and a public initializer, while preventing later mutation.

<details>
<summary>Solution direction — try it yourself first</summary>

Declare `public struct Course`, `public let name: String`, and an explicit `public init(name: String)`. Keep storage details private when they are not part of the contract.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
