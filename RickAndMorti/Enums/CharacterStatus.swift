import Foundation

enum CharacterStatus: String, Codable, CaseIterable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown = "unknown"
  
  var description: String {
    switch self {
    case .alive:
      return "Alive"
    case .dead:
      return "Dead"
    case .unknown:
      return "Unknown"
      
    }
  }
}
