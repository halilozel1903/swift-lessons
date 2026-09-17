import Foundation
struct SessionDTO: Decodable { let title: String; let minutes: Int }
enum ValidationError: Error { case invalidDuration }
func validatedMinutes(from data: Data) throws -> Int {
    let dto = try JSONDecoder().decode(SessionDTO.self, from: data)
    guard dto.minutes > 0 else { throw ValidationError.invalidDuration }
    return dto.minutes
}
let data = Data(#"{"title":"Decoding","minutes":30}"#.utf8)
do {
    print("Duration: \(try validatedMinutes(from: data))")
    _ = try validatedMinutes(from: Data(#"{"title":"Bad","minutes":0}"#.utf8))
} catch ValidationError.invalidDuration {
    print("Duration must be positive")
} catch {
    print("Could not decode: \(error)")
}
