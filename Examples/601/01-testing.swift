func completionRate(completed: Int, total: Int) -> Double? {
    guard total >= 0, completed >= 0, completed <= total else { return nil }
    return total == 0 ? 0 : Double(completed) / Double(total)
}
let cases = [(0, 0), (1, 2), (2, 2), (3, 2)]
for (completed, total) in cases {
    if let rate = completionRate(completed: completed, total: total) {
        print("\(completed)/\(total): \(rate)")
    } else {
        print("\(completed)/\(total): invalid")
    }
}
