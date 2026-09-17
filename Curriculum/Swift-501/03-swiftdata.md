# SwiftData and Data Ownership

Swift 501 · Apple Application Development · 30–45 minutes plus practice

[Previous lesson](02-navigation-accessibility.md) · [Level overview](README.md) · [Next lesson](04-uikit-interop.md)

## Before you start

Complete Swift 401 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

SwiftData persists model objects through a model container and model context. A container describes the storage configuration; the context tracks reads and changes. The @Query wrapper connects a SwiftUI view to fetched results. Keep domain rules explicit rather than assuming a persistence framework validates your business model.

Use an in-memory container for previews and isolated tests. A shipping application needs a persistent configuration, error handling, and a migration plan. This sample asks for an explicit save so failure can be presented. A failed save does not mean every in-memory change automatically disappears; rollback is a separate operation and can affect all pending context changes.

## Worked example

[Complete source](../../AppleExamples/03-swiftdata.swift)

```swift
import SwiftUI
import SwiftData
@Model final class SavedTopic {
    var title: String
    init(title: String) { self.title = title }
}
struct SavedTopicsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \SavedTopic.title) private var topics: [SavedTopic]
    @State private var errorMessage: String?
    var body: some View {
        VStack {
            List(topics) { topic in Text(topic.title) }
            Button("Add topic") {
                context.insert(SavedTopic(title: "Persistence"))
                do { try context.save() }
                catch {
                    context.rollback()
                    errorMessage = "Could not save the topic. Please try again."
                }
            }
            if let errorMessage { Text(errorMessage).foregroundStyle(.red) }
        }
    }
}
#Preview {
    SavedTopicsView().modelContainer(for: SavedTopic.self, inMemory: true)
}
```

## Run it

Run commands from the repository root.

See [Apple sample setup](../../AppleExamples/README.md) for the Xcode host and SDK requirements.

Expected interaction:

```text
Preview: an initially empty list. Add topic inserts and saves a Persistence row in memory.
```

## Why it works

The model macro provides persistence integration. The environment supplies the same context used by Query. The preview’s in-memory setting deliberately discards data when its container is recreated.

## Common mistake

Rollback here is suitable for an isolated teaching context. In a shared editing context it can discard unrelated pending changes. Design context ownership and transactions before applying it broadly.

## Practice

Add deletion and handle save failure. Define whether duplicate titles are allowed before adding uniqueness constraints.

<details>
<summary>Solution direction — try it yourself first</summary>

Delete selected model objects through the context, call save, and show an actionable error. Test the chosen duplicate policy and migration behavior separately.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
