protocol RecommendationSource {
    func candidates() -> [String]
}
struct FixtureRecommendations: RecommendationSource {
    func candidates() -> [String] { ["Actors", "Testing", "Actors"] }
}
struct RecommendationService<Source: RecommendationSource> {
    let source: Source
    func recommendations(completed: Set<String>) -> [String] {
        Set(source.candidates()).subtracting(completed).sorted()
    }
}
let service = RecommendationService(source: FixtureRecommendations())
print(service.recommendations(completed: ["Actors"]))
