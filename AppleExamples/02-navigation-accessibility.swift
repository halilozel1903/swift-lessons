import SwiftUI
struct CourseRoute: Identifiable, Hashable {
    let id: Int
    let title: String
}
struct CatalogView: View {
    private let courses = [
        CourseRoute(id: 101, title: "Foundations"),
        CourseRoute(id: 201, title: "Modeling")
    ]
    var body: some View {
        NavigationStack {
            List(courses) { course in
                NavigationLink(value: course) {
                    Text("Swift \(course.id): \(course.title)")
                }
            }
            .navigationTitle("Swift Lessons")
            .navigationDestination(for: CourseRoute.self) { course in
                Text(course.title)
                    .font(.title)
                    .padding()
                    .navigationTitle("Swift \(course.id)")
            }
        }
    }
}
#Preview { CatalogView() }
