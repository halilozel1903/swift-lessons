# Input Boundaries and Secure Defaults

Swift 601 · Engineering and Delivery · 30–45 minutes plus practice

[Previous lesson](04-tooling-delivery.md) · [Level overview](README.md)

## Before you start

Complete Swift 501 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

External data needs more than syntactic decoding. Establish domain limits, avoid accidental disclosure, and distinguish display labels from identifiers used to locate resources. A filename supplied by a user should not automatically become an unrestricted path. Parse a small allowlisted identifier and resolve it within storage that your application owns.

Security also depends on context. An input validator does not replace authorization, safe filesystem operations, or a threat model. Treat tokens and private data as secrets, keep them out of source control and logs, and avoid embedding credentials in a distributable application. Platform credential stores and server-side authorization solve different parts of that problem.

## Worked example

[Complete source](../../Examples/601/05-input-security.swift)

```swift
struct ExportName {
    let value: String
    init?(_ input: String) {
        let allowed = Set("abcdefghijklmnopqrstuvwxyz0123456789-")
        guard !input.isEmpty, input.utf8.count <= 40,
              input.allSatisfy({ allowed.contains($0) }) else { return nil }
        value = input
    }
}
for input in ["swift-101", "../private", "", "Swift"] {
    if let name = ExportName(input) {
        print("Accepted: \(name.value)")
    } else {
        print("Rejected")
    }
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 601/05-input-security
```

Expected output:

```text
Accepted: swift-101
Rejected
Rejected
Rejected
```

## Why it works

The validator chooses an intentionally narrow ASCII policy and bounds the encoded length. Slashes, dots, uppercase letters, and empty input are outside that policy. The resulting value can be used as an export label under an application-owned directory, subject to the storage layer’s own rules.

## Common mistake

This is not a general path sanitizer. Symbolic links, races, file permissions, and authorization need separate handling. Do not advertise a short allowlist as a complete secure file-writing implementation.

## Practice

Test exactly 40 and 41 characters, an accented character, a newline, and a slash. Document whether the product should reject or normalize uppercase input.

<details>
<summary>Solution direction — try it yourself first</summary>

The 40-character lowercase identifier is accepted; the others are rejected except when the product explicitly adds a normalization step. Apply normalization before validation and test the resulting policy.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
