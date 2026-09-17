# Navigation, Identity, and Accessibility

Swift 501 · Apple Application Development · 30–45 minutes plus practice

[Previous lesson](01-swiftui-state.md) · [Level overview](README.md) · [Next lesson](03-swiftdata.md)

## Before you start

Complete Swift 401 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

NavigationStack models hierarchical navigation with typed destinations. Stable identity matters because SwiftUI uses it to connect state with views across updates. Use a stored identifier from the domain, not a fresh UUID generated every time an id property is read.

Accessibility is part of the interaction contract. Prefer standard controls, scalable text styles, meaningful labels, and layouts that tolerate large Dynamic Type sizes. A decorative image should not duplicate information already read aloud. Test navigation with VoiceOver and large text on a real simulator or device; compilation cannot verify the usability of an interface.

## Worked example

[Complete source](../../AppleExamples/02-navigation-accessibility.swift)

```swift
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
            .navigationTitle("Swift Dersleri")
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
```

## Run it

Run commands from the repository root.

See [Apple sample setup](../../AppleExamples/README.md) for the Xcode host and SDK requirements.

Expected interaction:

```text
Preview: a two-row catalog. Selecting a row opens its matching course destination.
```

## Why it works

The route is both identifiable for list diffing and hashable for navigation values. Native text and navigation controls provide a useful accessibility baseline without custom gesture-only interactions.

## Common mistake

A visually obvious icon may have no meaningful spoken name. Do not communicate progress or errors through color alone, and do not constrain text to fixed heights that clip at larger sizes.

## Practice

Add Swift 301 using a stable ID. Test the largest accessibility text size and navigate back using VoiceOver.

<details>
<summary>Solution direction — try it yourself first</summary>

Add CourseRoute(id: 301, title: "Advanced Language"). Check that the full title remains readable and each row is announced as a navigation action.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
