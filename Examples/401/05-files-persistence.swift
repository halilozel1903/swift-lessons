import Foundation
struct Archive: Codable, Equatable {
    let version: Int
    let topics: [String]
}
let manager = FileManager.default
let directory = manager.temporaryDirectory.appendingPathComponent(UUID().uuidString)
try manager.createDirectory(at: directory, withIntermediateDirectories: true)
defer { try? manager.removeItem(at: directory) }
let file = directory.appendingPathComponent("topics.json")
let archive = Archive(version: 1, topics: ["Files", "Migration"])
try JSONEncoder().encode(archive).write(to: file, options: .atomic)
let restored = try JSONDecoder().decode(Archive.self, from: Data(contentsOf: file))
print("Version: \(restored.version)")
print(restored == archive)
