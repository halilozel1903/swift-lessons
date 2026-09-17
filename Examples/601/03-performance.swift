let completed = Array(0..<10_000)
let candidates = [3, 9_999, 10_001]
// Build once when performing many membership queries.
let lookup = Set(completed)
let remaining = candidates.filter { !lookup.contains($0) }
print(remaining)
let sortedCandidates = candidates.sorted()
print(sortedCandidates)
