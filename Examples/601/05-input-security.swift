struct ExportName {
    let value: String
    init?(_ input: String) {
        let allowed = Set("abcdefghijklmnopqrstuvwxyz0123456789-")
        guard !input.isEmpty, input.utf8.count <= 40,
              input.allSatisfy({ allowed.contains($0) }) else { return nil }
        value = input
    }
}
for input in ["swift-101", "../private", "", "Swift"] {
    if let name = ExportName(input) {
        print("Accepted: \(name.value)")
    } else {
        print("Rejected")
    }
}
