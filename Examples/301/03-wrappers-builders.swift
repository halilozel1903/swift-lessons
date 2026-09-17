@propertyWrapper
struct NonNegative {
    private var value: Int
    init(wrappedValue: Int) { value = max(0, wrappedValue) }
    var wrappedValue: Int {
        get { value }
        set { value = max(0, newValue) }
    }
}
@resultBuilder
struct OutlineBuilder {
    static func buildBlock(_ lines: String...) -> [String] { lines }
}
func outline(@OutlineBuilder content: () -> [String]) -> String {
    content().joined(separator: " -> ")
}
struct Goal { @NonNegative var minutes = 20 }
var goal = Goal()
goal.minutes = -5
print(goal.minutes)
print(outline { "Read"; "Code"; "Review" })
