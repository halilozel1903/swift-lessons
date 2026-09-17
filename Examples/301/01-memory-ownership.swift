final class LessonOwner {
    let name: String
    var onFinish: (() -> Void)?
    init(name: String) { self.name = name }
    func configure() {
        onFinish = { [weak self] in
            guard let self else { return }
            print("Finished: \(self.name)")
        }
    }
    deinit { print("Owner released") }
}
do {
    let owner = LessonOwner(name: "ARC")
    owner.configure()
    owner.onFinish?()
}
