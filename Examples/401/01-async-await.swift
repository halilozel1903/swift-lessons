func loadTitle() async -> String { "Structured Concurrency" }
func loadDuration() async -> Int { 45 }
@main struct Demo {
    static func main() async {
        async let title = loadTitle()
        async let duration = loadDuration()
        let result = await (title, duration)
        print("\(result.0): \(result.1) minutes")
        let total = await withTaskGroup(of: Int.self) { group in
            for value in 1...3 { group.addTask { value * value } }
            var sum = 0
            for await value in group { sum += value }
            return sum
        }
        print("Sum: \(total)")
    }
}
