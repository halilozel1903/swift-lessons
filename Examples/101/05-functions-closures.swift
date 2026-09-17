func studyMessage(for name: String, minutes: Int = 25) -> String {
    "\(name), study for \(minutes) minutes."
}
let sessions = [10, 25, 40]
let focusedSessions = sessions.filter { $0 >= 25 }
let doubled = focusedSessions.map { $0 * 2 }
let total = doubled.reduce(0, +)
print(studyMessage(for: "Alex"))
print(doubled)
print("Total: \(total)")
