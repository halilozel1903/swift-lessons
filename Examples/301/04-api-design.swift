protocol Named { var name: String { get } }
struct Course: Named { let name: String }
struct Author: Named { let name: String }
func featuredCourse() -> some Named { Course(name: "Advanced Swift") }
func describe<T: Named>(_ value: T) -> String { value.name }
let catalog: [any Named] = [Course(name: "Swift"), Author(name: "Alex")]
print(describe(featuredCourse()))
print(catalog.map(\.name).joined(separator: ", "))
