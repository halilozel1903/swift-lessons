struct Version: Comparable {
    let major: Int
    let minor: Int
    let patch: Int
    static func < (lhs: Self, rhs: Self) -> Bool {
        (lhs.major, lhs.minor, lhs.patch) < (rhs.major, rhs.minor, rhs.patch)
    }
}
let current = Version(major: 1, minor: 2, patch: 0)
let next = Version(major: 1, minor: 3, patch: 0)
print(current < next)
print("Build -> Test -> Review -> Release")
