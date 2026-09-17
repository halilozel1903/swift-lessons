import Foundation
import LearningCore

@main
struct StudyPlanner {
    static func main() async throws {
        let lessons = try [
            Lesson(title: "Optionals", minutes: 25),
            Lesson(title: "Protocols", minutes: 35),
            Lesson(title: "Actors", minutes: 40)
        ]
        let store = PlanStore(plan: try StudyPlan(lessons: lessons))
        try await store.complete(id: lessons[0].id)
        let snapshot = await store.snapshot()
        print("Study Planner")
        print("Completed: \(snapshot.completedIDs.count)/\(snapshot.lessons.count)")
        print("Remaining: \(snapshot.remainingMinutes) minutes")
        print("Progress: \(Int(snapshot.progress * 100))%")
    }
}
