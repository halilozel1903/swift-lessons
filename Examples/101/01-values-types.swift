let course = "Swift Foundations"
let unitPriceInCents: Int = 1250
var seats = 2
seats += 1
let totalInCents = unitPriceInCents * seats
let averageHours = Double(7) / Double(2)
print("\(course): \(seats) seats")
print("Total: \(totalInCents) cents")
print("Average: \(averageHours) hours")
