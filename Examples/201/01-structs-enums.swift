struct Session {
    let title: String
    private(set) var minutes: Int
    init?(title: String, minutes: Int) {
        guard !title.isEmpty, minutes > 0 else { return nil }
        self.title = title
        self.minutes = minutes
    }
    mutating func shorten() { minutes = max(1, minutes / 2) }
}
enum LoadState { case idle, loaded([String]), failed(String) }
if var session = Session(title: "Enums", minutes: 30) {
    let original = session
    session.shorten()
    print(original.minutes, session.minutes)
}
let state = LoadState.loaded(["Optionals", "Enums"])
switch state {
case .idle: print("Ready")
case .loaded(let topics): print("Loaded \(topics.count) topics")
case .failed(let message): print(message)
}
