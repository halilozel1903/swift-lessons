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
