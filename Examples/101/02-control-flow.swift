func label(for score: Int) -> String {
    guard (0...100).contains(score) else { return "Invalid" }
    switch score {
    case 90...100: return "Excellent"
    case 60..<90: return "Passed"
    default: return "Practice again"
    }
}
for score in [45, 75, 95, 110] {
    print("\(score): \(label(for: score))")
}
let evenNumbers = (1...6).filter { $0.isMultiple(of: 2) }
print(evenNumbers)
