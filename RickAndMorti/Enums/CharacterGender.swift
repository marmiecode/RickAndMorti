import Foundation

enum CharacterGender: String, Codable, CaseIterable {
  case female = "Female"
  case male = "Male"
  case genderless = "Genderless"
  case unknown = "unknown"
  
  var description: String {
    switch self {
    case .female:
      return "Female"
    case .male:
      return "Male"
    case .genderless:
      return "Genderless"
    case .unknown:
      return "Unknown"
    }
  }
}
