# ARC, Capture Lists, and Resource Lifetime

Swift 301 · Advanced Language · 30–45 minutes plus practice

[Level overview](README.md) · [Next lesson](02-sequences-keypaths.md)

## Before you start

Complete Swift 201 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Automatic Reference Counting manages the lifetime of class instances by tracking strong references. If two objects strongly retain each other, their counts may never reach zero. A stored closure is another object that can retain captured references and participate in a cycle.

A weak reference does not keep its object alive and becomes nil after deallocation. An unowned reference assumes the object remains alive whenever used, so an incorrect lifetime assumption can trap. Use weak when absence is valid. Resource cleanup, such as closing a file, should still have explicit scope or lifecycle management rather than depending on an unpredictable final owner.

## Worked example

[Complete source](../../Examples/301/01-memory-ownership.swift)

```swift
final class LessonOwner {
    let name: String
    var onFinish: (() -> Void)?
    init(name: String) { self.name = name }
    func configure() {
        onFinish = { [weak self] in
            guard let self else { return }
            print("Finished: \(self.name)")
        }
    }
    deinit { print("Owner released") }
}
do {
    let owner = LessonOwner(name: "ARC")
    owner.configure()
    owner.onFinish?()
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 301/01-memory-ownership
```

Expected output:

```text
Finished: ARC
Owner released
```

## Why it works

The owner retains its closure, but the closure captures the owner weakly. Binding self keeps it alive for the duration of that invocation. At the end of the scope no persistent strong owner remains.

## Common mistake

Adding `[weak self]` to every closure can silently drop work that must finish. Choose ownership deliberately. A temporary nonescaping closure usually does not need weak capture.

## Practice

Explain the retain graph if the capture list is removed. Identify which edge must become weak or be explicitly cleared.

<details>
<summary>Solution direction — try it yourself first</summary>

The owner retains onFinish and onFinish retains owner. Break either edge: weak capture is appropriate here, or clear the stored closure at an explicit lifecycle boundary.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
