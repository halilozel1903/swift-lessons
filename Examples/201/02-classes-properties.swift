final class StudyTimer {
    var elapsedSeconds: Int = 0
    var elapsedMinutes: Int { elapsedSeconds / 60 }
    func tick(seconds: Int) {
        guard seconds > 0 else { return }
        elapsedSeconds += seconds
    }
}
let timer = StudyTimer()
let shared = timer
shared.tick(seconds: 125)
print(timer === shared)
print(timer.elapsedMinutes)
struct Settings { var dailyGoal = 20 }
var first = Settings()
var second = first
second.dailyGoal = 40
print(first.dailyGoal, second.dailyGoal)
