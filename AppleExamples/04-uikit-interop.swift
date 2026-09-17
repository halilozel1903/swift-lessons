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
