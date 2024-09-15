import Foundation

struct Character: Identifiable, Codable {
  let id: Int
  let name: String
  let status: CharacterStatus
  let species: CharacterSpecies
  let gender: CharacterGender
  let image: URL
}
