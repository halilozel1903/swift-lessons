let topics = ["Swift", "Actors", "Swift"]
let uniqueTopics = Set(topics)
var visits: [String: Int] = [:]
for topic in topics { visits[topic, default: 0] += 1 }
let greeting = "Hi 👩🏽‍💻"
print(uniqueTopics.sorted())
print(visits["Swift", default: 0])
print("Characters: \(greeting.count)")
print(String(greeting.prefix(2)))
print(Array(topics.enumerated()).map { "\($0.offset): \($0.element)" })
