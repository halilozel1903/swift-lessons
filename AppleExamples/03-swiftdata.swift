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
