struct Topic {
    let title: String
    let minutes: Int
}
let topics = [Topic(title: "ARC", minutes: 20), Topic(title: "Actors", minutes: 40)]
print(topics.map(\.title))
let total = topics.lazy.filter { $0.minutes >= 30 }.map(\.minutes).reduce(0, +)
print(total)
let firstThreeSquares = (1...).lazy.map { $0 * $0 }.prefix(3)
print(Array(firstThreeSquares))
