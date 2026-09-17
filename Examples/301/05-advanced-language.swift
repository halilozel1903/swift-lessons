struct Box<Value> { let value: Value }
extension Box: Equatable where Value: Equatable {}
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
let values: [Any] = ["Swift", 42]
for value in values {
    if let text = value as? String { print(text.uppercased()) }
}
print(Box(value: 7) == Box(value: 7))
print([10, 20][safe: 5] == nil)
