actor SeatInventory {
    private var available = 2
    func reserve() -> Bool {
        guard available > 0 else { return false }
        available -= 1
        return true
    }
    func remaining() -> Int { available }
}
@main struct Demo {
    static func main() async {
        let inventory = SeatInventory()
        let successes = await withTaskGroup(of: Bool.self) { group in
            for _ in 0..<5 { group.addTask { await inventory.reserve() } }
            var count = 0
            for await reserved in group { if reserved { count += 1 } }
            return count
        }
        print("Reservations: \(successes)")
        print("Remaining: \(await inventory.remaining())")
    }
}
