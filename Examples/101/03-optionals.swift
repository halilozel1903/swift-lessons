struct Profile { let nickname: String? }
func minutes(from input: String?) -> Int? {
    guard let input, let value = Int(input), value > 0 else { return nil }
    return value
}
let profile: Profile? = Profile(nickname: nil)
print(profile?.nickname ?? "Guest")
print(minutes(from: "25") ?? 0)
print(minutes(from: "invalid") == nil)
if let duration = minutes(from: "40") {
    print("Study for \(duration) minutes")
}
