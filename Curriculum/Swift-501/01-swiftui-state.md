# SwiftUI State and Observation

Swift 501 · Apple Application Development · 30–45 minutes plus practice

[Level overview](README.md) · [Next lesson](02-navigation-accessibility.md)

## Before you start

Complete Swift 401 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

SwiftUI describes a view hierarchy as a function of state. View structs are lightweight descriptions that can be recreated; persistent state is managed by the framework. Keep one owner for each piece of mutable state and pass values or bindings to children according to their responsibilities.

Observation tracks reads of observable properties so dependent UI can update. This example owns a reference model with State and confines its mutation to the main actor. Button actions change the model; the body derives its text from that state. Do not perform network requests or expensive work directly in body, which may be evaluated repeatedly.

## Worked example

[Complete source](../../AppleExamples/01-swiftui-state.swift)

```swift
import SwiftUI
import Observation
@MainActor @Observable
final class StudyModel {
    var completed = 0
    func complete() { completed += 1 }
}
@MainActor
struct StudyView: View {
    @State private var model = StudyModel()
    var body: some View {
        VStack(spacing: 16) {
            Text("Completed: \(model.completed)")
                .accessibilityLabel("Completed lessons: \(model.completed)")
            Button("Complete lesson") { model.complete() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
#Preview { StudyView() }
```

## Run it

Run commands from the repository root.

See [Apple sample setup](../../AppleExamples/README.md) for the Xcode host and SDK requirements.

Expected interaction:

```text
Preview: “Completed: 0”. Each button press increments the displayed count.
```

## Why it works

State owns the model for this view’s identity. Observation tracks completed when body reads it. A child that edits an observable model through bindings can use @Bindable; a child that only displays data should receive the value it needs.

## Common mistake

Recreating the model as an ordinary local variable in body resets ownership. Using @State for a value does not mean every value passed to a child automatically becomes a writable binding.

## Practice

Add a Reset button and disable it while completed is zero. Verify both actions in Preview.

<details>
<summary>Solution direction — try it yourself first</summary>

Assign zero in the reset action and apply `.disabled(model.completed == 0)`. Keep the mutation on the main actor.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
