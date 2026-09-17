# Language Supplement

[Home](../README.md) · [Coverage map](CURRICULUM.md)

These short examples cover useful features that do not need a full standalone chapter. They are explanatory snippets rather than entries in the executable example manifest. Consult the [language reference](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/) for complete rules.

## Inout and exclusive access

An inout parameter allows a function to update the caller’s variable. Think of this as scoped access to a value, not a general-purpose reference that may be retained indefinitely.

```swift
func addBonus(to minutes: inout Int) { minutes += 5 }
var minutes = 20
addBonus(to: &minutes)
print(minutes) // 25
```

Swift requires exclusive access during mutation. Passing overlapping storage to operations requiring simultaneous mutation can violate exclusivity. Prefer returning a new value when the transformation is easier to reason about that way. Exercise: rewrite addBonus as a pure function and explain the different call sites.

## Defer and scoped cleanup

A defer body runs when its surrounding scope exits, including an early return or thrown error. Multiple defer statements execute in reverse registration order. Defer does not run before it has been reached and cannot guarantee cleanup after every kind of process termination.

```swift
func demonstrateCleanup() {
    defer { print("Closed") }
    print("Opened")
}
demonstrateCleanup() // Opened, then Closed
```

Use it for scoped cleanup such as closing a handle or removing a temporary fixture. Do not use an unstructured asynchronous task inside defer as a substitute for awaited cleanup. Exercise: add an early return after the first print and predict the output.

## Typed throws

Swift 6 can express a specific thrown error type. This is useful when a small API has a deliberately closed failure contract. A broad integration boundary may need ordinary throws because dependencies produce multiple error types.

```swift
enum DurationError: Error { case notPositive }
func duration(_ value: Int) throws(DurationError) -> Int {
    guard value > 0 else { throw .notPositive }
    return value
}
```

Typed errors are still errors; callers must handle or propagate them. Do not erase meaningful dependency failures merely to force them into an overly narrow type. Exercise: add an upper-limit error and update a caller’s handling.

## Regular expressions

A regex is useful for a well-defined textual pattern. Foundation’s string search also supports a regular-expression option, making a small full-string validation example accessible without constructing a parser.

```swift
import Foundation
let identifier = "swift_101"
let valid = identifier.range(
    of: #"\A[a-z][a-z0-9_]*\z"#,
    options: .regularExpression
) != nil
print(valid) // true
```

This policy deliberately accepts ASCII identifiers only. It is not an email validator or a universal username policy. Swift also provides native Regex and RegexBuilder APIs with typed captures; study those when a structured match is more useful than a Boolean. Exercise: test uppercase input, a leading digit, an empty string, and a trailing newline.

## Availability and conditional compilation

Use `#if canImport(...)` when a module may not exist for a target. Use `if #available(...)` for APIs that exist in the SDK but may not exist on the deployment OS. These solve different problems: a runtime availability check cannot make UIKit importable on Linux.

The networking lesson conditionally imports FoundationNetworking. Apple examples declare their minimum deployment targets in the checker script and setup guide. Exercise: identify which kind of check a newer iOS-only view modifier needs in an app supporting older iOS versions.

## Operators and nested types

Operator overloads should preserve familiar mathematical or semantic expectations. A named method often communicates a domain operation better than a novel symbol. Nested types group helper concepts under their owner and can keep a public namespace small.

```swift
struct Counter {
    var value: Int
    static func + (lhs: Self, rhs: Self) -> Self {
        Self(value: lhs.value + rhs.value)
    }
    enum Format { case short, verbose }
}
```

Define overflow behavior for arithmetic domains. Do not invent an operator just to avoid a descriptive function name. Exercise: explain when merging two course plans should be a throwing named method instead of `+`.
