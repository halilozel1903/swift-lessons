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
