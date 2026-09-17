# Specialization Paths

[Home](../README.md) · [Official references](RESOURCES.md)

The core course prepares you to enter these areas. These are guided introductions with design examples and practice tasks, not complete runnable applications. Framework APIs and platform requirements should be verified against the documentation for the version you adopt.

## Server-side Swift

A server receives untrusted requests, validates input, invokes business rules, and encodes a response. Keep the domain independent of your HTTP framework. An adapter maps transport details such as status codes and headers to domain inputs and outcomes.

```swift
struct CreateLessonRequest: Decodable {
    let title: String
    let minutes: Int
}
struct CreateLessonResponse: Encodable {
    let id: String
}
```

Reuse the capstone’s validated Lesson type after decoding the request. Translate invalid input into a client error, unexpected infrastructure failure into a server error, and cancellation into stopped work. Never block an event loop with synchronous file operations or waiting on future work. Define request size limits, authentication, database transactions, and observability at explicit boundaries.

**Practice:** design POST /lessons and GET /lessons contracts, including malformed JSON, invalid duration, duplicate requests, and database failure. Then implement them using a framework chosen from the [Swift server guides](https://www.swift.org/documentation/server/guides/). Pin that dependency and add HTTP integration tests before deploying. No server framework is bundled here.

## Command-line applications

The capstone executable demonstrates a domain adapter. A full CLI also needs argument parsing, help output, exit codes, and persistent storage. Standard output should carry the normal result; standard error should explain failures. Keep a machine-readable output mode separate from friendly progress messages.

**Practice:** implement `list`, `complete <id>`, and `progress --json`. Decide whether an unknown ID is a usage error or a domain error, document the exit code, and test it from a separate process. Consider a maintained argument parser once manual parsing would obscure the lesson; the starter package has no external dependencies.

## Macros and compiler-assisted APIs

A macro expands source code at compile time. Freestanding macros appear as expressions or declarations; attached macros augment a declaration. `@Observable` and `@Model` demonstrate macro-based APIs in the Apple lessons, but using a macro is different from implementing one.

A custom macro generally requires a compiler-plugin target and compatible SwiftSyntax dependencies. Its public declaration describes the expansion role; its implementation transforms syntax. Test both valid expansion and useful diagnostics for unsupported input. A macro should remove meaningful repetition without hiding behavior that readers need to understand.

**Practice:** specify an attached macro that generates a description for an enum. Write the desired input, expanded output, and diagnostics first. Study the accepted macro proposals in [Swift Evolution](https://www.swift.org/swift-evolution/) before building a plugin. This repository intentionally does not pin SwiftSyntax or include an untested macro target.

## C, C++, and Objective-C interoperability

Interop is a boundary between type systems and ownership conventions. C functions may expose raw pointers and lengths; Swift should validate those contracts and keep pointer lifetimes scoped. Objective-C integration depends on Apple runtime availability and representable declarations. C++ interoperability depends on toolchain support and imported API shape.

```swift
let values: [Int32] = [1, 2, 3]
let total = values.withUnsafeBufferPointer { buffer in
    buffer.reduce(0, +)
}
print(total) // 6
```

This is a lifetime demonstration, not a call into a foreign library. Do not store the buffer pointer after the closure ends. The pointer borrows array storage; it does not transfer ownership. A real binding must also document nullability, alignment, thread safety, and which side allocates and frees memory.

**Practice:** wrap a tiny C sum function in a dedicated package target, then test zero-length and nonempty buffers. For C++, start with the official [interop guide](https://www.swift.org/documentation/cxx-interop/) and verify the supported language subset rather than assuming every C++ type imports.

## Lower-level ownership and noncopyable values

Most applications benefit from ordinary value types and ARC-managed references. Resource handles can have stricter needs: copying ownership of a file descriptor or lock can cause double cleanup. Noncopyable types and borrowing/consuming operations let an API express certain ownership constraints in the type system.

```swift
struct Token: ~Copyable {
    let id: Int
}
func inspect(_ token: borrowing Token) -> Int { token.id }
func redeem(_ token: consuming Token) -> Int { token.id }
```

The signature distinguishes temporary access from consuming ownership. Noncopyable does not automatically mean thread-safe, and a minimal token is not a complete resource manager. Generic constraints and supported operations vary with the feature and toolchain version.

**Practice:** sketch a resource wrapper whose cleanup runs exactly once. State how it handles initialization failure and explicit close, then verify the design against the ownership sections of the language guide and accepted proposals.

## The wider Apple ecosystem

| Area | What changes | Suggested next exercise |
| --- | --- | --- |
| Combine | Publisher/subscriber lifetimes, demand, cancellation | Bridge a finite publisher to a feature without leaking subscriptions |
| Core Data | Managed contexts, queue confinement, model migrations | Migrate a versioned fixture and test failure recovery |
| WidgetKit | Timeline-based rendering and constrained background work | Show a progress snapshot using shared storage with deliberate ownership |
| watchOS | Small screens, constrained interaction and background execution | Design a one-action study timer and test lifecycle transitions |
| tvOS | Focus-driven interaction | Navigate a course catalog using a remote |
| visionOS | Spatial layout and immersive interaction | Adapt the catalog to a window before adding spatial content |
| AppKit | Desktop windows, menus, responders | Build a macOS catalog window with keyboard navigation |

A framework-specific project should begin with its lifecycle and accessibility requirements, not with copying an iOS screen unchanged. CloudKit synchronization, StoreKit purchases, notifications, and background tasks each introduce additional contracts that deserve their own integration tests and failure scenarios.

## Pick one path

Complete one small end-to-end feature, write down its ownership and failure rules, and verify it on the actual target. Add another framework only when the product requirement justifies it. This keeps the language knowledge from the core course connected to observable behavior.
