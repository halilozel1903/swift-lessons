# Generics and Associated Types

Swift 201 · Modeling and Reuse · 30–45 minutes plus practice

[Previous lesson](04-errors-codable.md) · [Level overview](README.md)

## Before you start

Complete Swift 101 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Generic code preserves relationships between types while reusing an algorithm or container. A generic parameter is a placeholder selected by the caller, and a constraint states the capabilities the algorithm requires. `Equatable` permits equality comparison; it does not imply ordering.

Protocols can declare associated types when each conformer chooses a related type. Prefer generics when the caller and compiler should retain that type relationship. An existential is useful for storing different conformers behind one interface. `some Protocol` hides a concrete result type from the caller while keeping one underlying type identity for that declaration.

## Worked example

[Complete source](../../Examples/201/05-generics.swift)

```swift
struct Stack<Element> {
    private var elements: [Element] = []
    mutating func push(_ element: Element) { elements.append(element) }
    mutating func pop() -> Element? { elements.popLast() }
}
func allEqual<T: Equatable>(_ values: [T]) -> Bool {
    guard let first = values.first else { return true }
    return values.dropFirst().allSatisfy { $0 == first }
}
var stack = Stack<String>()
stack.push("Swift")
stack.push("Generics")
print(stack.pop() ?? "Empty")
print(allEqual([3, 3, 3]))
print(allEqual([String]()))
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 201/05-generics
```

Expected output:

```text
Generics
true
true
```

## Why it works

The stack never needs to know the operations supported by Element, because it only stores and returns values. allEqual adds exactly the capability it uses. The empty case follows the convention that no element violates the condition.

## Common mistake

Do not replace every generic parameter with Any. That discards compile-time relationships and moves failures into runtime casts.

## Practice

Add a read-only `peek: Element?` property and verify it does not remove an element.

<details>
<summary>Solution direction — try it yourself first</summary>

Return `elements.last` from the property. Call peek twice before pop; all three should observe the same last element.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
