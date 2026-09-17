# UIKit Interoperability and Platform Boundaries

Swift 501 · Apple Application Development · 30–45 minutes plus practice

[Previous lesson](03-swiftdata.md) · [Level overview](README.md)

## Before you start

Complete Swift 401 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

Existing Apple applications often mix SwiftUI and UIKit. A UIViewRepresentable adapts a UIKit view to SwiftUI through creation and update hooks. A coordinator bridges delegate callbacks back into SwiftUI state. The wrapper must update both directions: SwiftUI changes must reach UIKit, and user edits must reach the binding.

Keep UIKit-specific code in an iOS target. The portable Swift package cannot import UIKit on Linux or macOS. AppKit is the corresponding desktop framework, and its wrappers use NSViewRepresentable. Framework boundaries are also a good place to document lifecycle, accessibility, thread isolation, and callback ownership.

## Worked example

[Complete source](../../AppleExamples/04-uikit-interop.swift)

```swift
import SwiftUI
import UIKit
struct LegacyTextField: UIViewRepresentable {
    @Binding var text: String
    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }
    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.placeholder = "Topic title"
        field.accessibilityLabel = "Topic title"
        field.delegate = context.coordinator
        return field
    }
    func updateUIView(_ view: UITextField, context: Context) {
        context.coordinator.parent = self
        if view.text != text { view.text = text }
    }
    @MainActor final class Coordinator: NSObject, UITextFieldDelegate {
        var parent: LegacyTextField
        init(parent: LegacyTextField) { self.parent = parent }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
struct LegacyEditor: View {
    @State private var text = "Swift"
    var body: some View { LegacyTextField(text: $text).padding() }
}
#Preview { LegacyEditor() }
```

## Run it

Run commands from the repository root.

See [Apple sample setup](../../AppleExamples/README.md) for the Xcode host and SDK requirements.

Expected interaction:

```text
iOS Preview: a text field initially containing Swift, synchronized with its SwiftUI binding.
```

## Why it works

The coordinator retains the latest wrapper value so callbacks use the current binding. updateUIView avoids redundant assignments that could disturb selection. The UITextField delegate reference is weak, while SwiftUI manages the coordinator lifetime.

## Common mistake

A representable update can happen often. Avoid rebuilding expensive resources on every update or unconditionally triggering another state update. This small adapter does not implement every text-input policy, such as validation during marked-text composition.

## Practice

Add a SwiftUI Text below the field showing the current binding and verify programmatic reset updates the field.

<details>
<summary>Solution direction — try it yourself first</summary>

Use a VStack containing LegacyTextField, Text(text), and a Button assigning an empty string. Test typing and reset in an iOS simulator.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
