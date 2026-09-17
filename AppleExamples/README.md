# Apple Framework Samples

[Home](../README.md) · [Swift 501](../Curriculum/Swift-501/README.md)

These four files are independent teaching samples, not an Xcode project or a bundled application. They are excluded from the portable Swift package. Use full Xcode with a Swift 6 toolchain; choose iOS 17+ or macOS 14+ for the first three samples and iOS 17+ for UIKit.

## Run a sample in Xcode

1. Create a new **iOS App** project with Swift and SwiftUI. Choose a deployment target of iOS 17 or later and Swift 6 language mode. No third-party dependencies are needed.
2. Add the sample `.swift` file to the app target, preserving its target membership.
3. Replace the generated app’s WindowGroup content using the matching view below.
4. Build for an iOS simulator and open the file’s Preview canvas. Use the simulator to verify interaction.

| File | Root view | Special requirement |
| --- | --- | --- |
| [State](01-swiftui-state.swift) | `StudyView()` | Observation |
| [Navigation](02-navigation-accessibility.swift) | `CatalogView()` | NavigationStack |
| [Persistence](03-swiftdata.swift) | `SavedTopicsView()` | Attach `.modelContainer(for: SavedTopic.self)` to the scene |
| [UIKit bridge](04-uikit-interop.swift) | `LegacyEditor()` | iOS target |

For example, a persistence host uses:

```swift
import SwiftUI
import SwiftData

@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup { SavedTopicsView() }
            .modelContainer(for: SavedTopic.self)
    }
}
```

Keep only one `@main` app entry point. For a disposable in-memory app, pass `inMemory: true` to modelContainer. The sample preview already uses an in-memory container; the host above persists between launches.

## Verification

```bash
bash scripts/check-apple.sh
```

This type-checks the first three files against the macOS SDK and the UIKit bridge against the iOS Simulator SDK, all in Swift 6 language mode. It does not launch previews or exercise UI interactions. Verify those manually using each lesson’s expected interaction and the following checklist:

- The count increments and resets if you implement the exercise.
- Each catalog row reaches the expected destination and supports back navigation.
- Inserted topics appear and save failures are presented.
- Typing updates the binding and a programmatic change updates the text field.
- VoiceOver labels are meaningful; large text stays readable.

Before shipping an app, add UI tests, a migration policy, realistic error recovery, and platform-specific lifecycle handling.
