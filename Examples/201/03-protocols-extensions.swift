protocol TopicSource {
    func topics() -> [String]
}
struct LocalTopics: TopicSource {
    func topics() -> [String] { ["Protocols", "Testing"] }
}
extension TopicSource {
    func summary() -> String { topics().joined(separator: ", ") }
}
struct CourseScreen {
    let source: any TopicSource
    func render() -> String { source.summary() }
}
let screen = CourseScreen(source: LocalTopics())
print(screen.render())
