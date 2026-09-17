import Foundation

public enum PlanError: Error, Equatable {
    case emptyTitle
    case invalidMinutes
    case duplicateID(UUID)
    case lessonNotFound(UUID)
}

/// An immutable, validated lesson that can safely cross isolation boundaries.
public struct Lesson: Codable, Equatable, Identifiable, Sendable {
    public let id: UUID
    public let title: String
    public let minutes: Int

    public init(id: UUID = UUID(), title: String, minutes: Int) throws {
        let title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { throw PlanError.emptyTitle }
        guard (1...480).contains(minutes) else { throw PlanError.invalidMinutes }
        self.id = id
        self.title = title
        self.minutes = minutes
    }

    // Decoding must enforce the same invariants as direct initialization.
    private enum CodingKeys: String, CodingKey { case id, title, minutes }

    public init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            id: values.decode(UUID.self, forKey: .id),
            title: values.decode(String.self, forKey: .title),
            minutes: values.decode(Int.self, forKey: .minutes)
        )
    }
}

/// A value snapshot: changing a plan does not mutate a previous copy.
public struct StudyPlan: Sendable {
    public private(set) var lessons: [Lesson]
    public private(set) var completedIDs: Set<UUID> = []

    public init(lessons: [Lesson]) throws {
        var seen: Set<UUID> = []
        for lesson in lessons {
            guard seen.insert(lesson.id).inserted else {
                throw PlanError.duplicateID(lesson.id)
            }
        }
        self.lessons = lessons
    }

    public mutating func complete(id: UUID) throws {
        guard lessons.contains(where: { $0.id == id }) else {
            throw PlanError.lessonNotFound(id)
        }
        completedIDs.insert(id)
    }

    public var progress: Double {
        lessons.isEmpty ? 0 : Double(completedIDs.count) / Double(lessons.count)
    }

    public var remainingMinutes: Int {
        lessons.lazy.filter { !completedIDs.contains($0.id) }
            .reduce(0) { $0 + $1.minutes }
    }
}

/// Keeps mutation inside one actor. No suspension occurs during completion.
public actor PlanStore {
    private var plan: StudyPlan
    public init(plan: StudyPlan) { self.plan = plan }
    public func complete(id: UUID) throws { try plan.complete(id: id) }
    public func snapshot() -> StudyPlan { plan }
}
