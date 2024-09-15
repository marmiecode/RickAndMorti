import Foundation

enum CharacterSpecies: String, Codable, CaseIterable {
  case human =  "Human"
  case alien = "Alien"
  case unknown = "unknown"
  
  var description: String {
    switch self {
    case .human:
      return "Human"
    case .alien:
      return "Alien"
    case .unknown:
      return "Unknown"
    }
  }
}
