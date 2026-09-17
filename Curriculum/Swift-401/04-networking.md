# Networking and Testable HTTP Boundaries

Swift 401 · Concurrency and Data · 30–45 minutes plus practice

[Previous lesson](03-cancellation-streams.md) · [Level overview](README.md) · [Next lesson](05-files-persistence.md)

## Before you start

Complete Swift 301 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

A network request has several independent failure points: transport failure, an unacceptable HTTP status, and an invalid response body. A successful URLSession transport does not imply an HTTP success status. Validate the response before decoding and map failures at an appropriate boundary.

Keep transport behind a small Sendable interface so a deterministic fixture can exercise decoding without an internet connection. The example includes a real URLSession implementation but runs a fixture by default. Production clients also need cancellation propagation, timeouts, authentication handling, and a retry policy that respects idempotency. Never blindly retry a state-changing operation.

## Worked example

[Complete source](../../Examples/401/04-networking.swift)

```swift
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
struct Topic: Decodable, Sendable { let title: String }
enum HTTPError: Error { case unacceptableResponse }
protocol Transport: Sendable { func get(_ url: URL) async throws -> Data }
struct LiveTransport: Transport {
    func get(_ url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw HTTPError.unacceptableResponse
        }
        return data
    }
}
struct FixtureTransport: Transport {
    func get(_ url: URL) async throws -> Data {
        Data(#"{"title":"Offline networking fixture"}"#.utf8)
    }
}
func loadTopic(from url: URL, using transport: any Transport) async throws -> Topic {
    try JSONDecoder().decode(Topic.self, from: await transport.get(url))
}
@main struct Demo {
    static func main() async throws {
        guard let url = URL(string: "https://example.com/topic") else { return }
        let topic = try await loadTopic(from: url, using: FixtureTransport())
        print(topic.title)
    }
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 401/04-networking
```

Expected output:

```text
Offline networking fixture
```

## Why it works

The conditional import makes URLSession available on Linux. The live implementation rejects non-2xx responses. The decoding function accepts either transport, while the executable intentionally selects the fixture and makes no network calls.

## Common mistake

Do not log authorization headers or raw private payloads. A 204 response has no JSON body even though it is a successful status; choose endpoint-specific handling instead of one decoder for every request.

## Practice

Add a malformed JSON fixture and a transport that throws. Verify these produce distinct errors at the loader boundary.

<details>
<summary>Solution direction — try it yourself first</summary>

Return Data("invalid".utf8) to trigger DecodingError. Throw a fixture transport error before returning data to verify it propagates unchanged.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
