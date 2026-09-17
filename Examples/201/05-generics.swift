struct Stack<Element> {
    private var elements: [Element] = []
    mutating func push(_ element: Element) { elements.append(element) }
    mutating func pop() -> Element? { elements.popLast() }
}
func allEqual<T: Equatable>(_ values: [T]) -> Bool {
    guard let first = values.first else { return true }
    return values.dropFirst().allSatisfy { $0 == first }
}
var stack = Stack<String>()
stack.push("Swift")
stack.push("Generics")
print(stack.pop() ?? "Empty")
print(allEqual([3, 3, 3]))
print(allEqual([String]()))
