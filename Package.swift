// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftLessons",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "LearningCore", targets: ["LearningCore"]),
        .executable(name: "study-planner", targets: ["StudyPlanner"])
    ],
    targets: [
        .target(name: "LearningCore"),
        .executableTarget(name: "StudyPlanner", dependencies: ["LearningCore"]),
        .testTarget(name: "LearningCoreTests", dependencies: ["LearningCore"])
    ],
    swiftLanguageModes: [.v6]
)
