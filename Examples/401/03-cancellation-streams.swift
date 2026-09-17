@main struct Demo {
    static func main() async {
        let stream = AsyncStream<Int> { continuation in
            continuation.yield(10)
            continuation.yield(20)
            continuation.finish()
        }
        var total = 0
        for await minutes in stream { total += minutes }
        print("Stream total: \(total)")
        let task = Task { () throws -> Void in
            while true {
                try Task.checkCancellation()
                try await Task.sleep(for: .seconds(60))
            }
        }
        task.cancel()
        do { try await task.value }
        catch is CancellationError { print("Cancelled cleanly") }
        catch { print("Unexpected: \(error)") }
    }
}
