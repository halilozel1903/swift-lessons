import Foundation
import Testing
@testable import LearningCore

@Test(arguments: ["", " ", "\n\t"])
func rejectsBlankTitles(title: String) {
    #expect(throws: PlanError.emptyTitle) { try Lesson(title: title, minutes: 20) }
}

@Test(arguments: [-1, 0, 481])
func rejectsInvalidDurations(minutes: Int) {
    #expect(throws: PlanError.invalidMinutes) { try Lesson(title: "Swift", minutes: minutes) }
}

@Test(arguments: [1, 480])
func acceptsDurationBoundaries(minutes: Int) throws {
    #expect(try Lesson(title: " Swift ", minutes: minutes).title == "Swift")
}

@Test func duplicateIDsAreRejected() throws {
    let lesson = try Lesson(title: "Swift", minutes: 10)
    #expect(throws: PlanError.duplicateID(lesson.id)) {
        try StudyPlan(lessons: [lesson, lesson])
    }
}

@Test func completionIsIdempotentAndPreservesValueSemantics() throws {
    let lesson = try Lesson(title: "Swift", minutes: 10)
    let original = try StudyPlan(lessons: [lesson])
    var changed = original
    try changed.complete(id: lesson.id)
    try changed.complete(id: lesson.id)
    #expect(changed.progress == 1)
    #expect(changed.remainingMinutes == 0)
    #expect(original.progress == 0)
    #expect(original.remainingMinutes == 10)
}

@Test func unknownCompletionDoesNotMutatePlan() throws {
    var plan = try StudyPlan(lessons: [])
    let unknown = UUID()
    #expect(throws: PlanError.lessonNotFound(unknown)) { try plan.complete(id: unknown) }
    #expect(plan.completedIDs.isEmpty)
    #expect(plan.progress == 0)
}

@Test func partialProgress() throws {
    let first = try Lesson(title: "A", minutes: 10)
    let second = try Lesson(title: "B", minutes: 20)
    var plan = try StudyPlan(lessons: [first, second])
    try plan.complete(id: first.id)
    #expect(plan.progress == 0.5)
    #expect(plan.remainingMinutes == 20)
}

@Test func decodingCannotBypassValidation() throws {
    let invalid = Data("{\"id\":\"00000000-0000-0000-0000-000000000001\",\"title\":\"Swift\",\"minutes\":0}".utf8)
    #expect(throws: PlanError.invalidMinutes) { try JSONDecoder().decode(Lesson.self, from: invalid) }
    let lesson = try Lesson(title: "Actors", minutes: 40)
    #expect(try JSONDecoder().decode(Lesson.self, from: JSONEncoder().encode(lesson)) == lesson)
}

@Test func concurrentCompletionsDoNotLoseUpdates() async throws {
    let lessons = try (1...20).map { try Lesson(title: "Lesson \($0)", minutes: 5) }
    let store = PlanStore(plan: try StudyPlan(lessons: lessons))
    try await withThrowingTaskGroup(of: Void.self) { group in
        for lesson in lessons {
            group.addTask { try await store.complete(id: lesson.id) }
        }
        try await group.waitForAll()
    }
    let snapshot = await store.snapshot()
    #expect(snapshot.progress == 1)
    #expect(snapshot.remainingMinutes == 0)
    #expect(snapshot.completedIDs.count == 20)
}
