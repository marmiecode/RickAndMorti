import Foundation

@MainActor

class CharacterViewModel: ObservableObject {
  @Published var character: [Character] = []
  @Published var favourites: [Character] = []
  @Published var currentPage = 1
  @Published var isLoading = false
  @Published var selectedStatus: CharacterStatus?
  @Published var selectedSpecies: CharacterSpecies?
  @Published var selectedGender: CharacterGender?
  
  private let apiService = APIService()
  
  func loadCharacter() async {
    guard !isLoading else {return}
    isLoading = true
    do {
      let newCharacters = try await apiService.fetchCharacters(
        page: currentPage,
        status: selectedStatus,
        species: selectedSpecies,
        gender: selectedGender
      )
      self.character.append(contentsOf: newCharacters)
      self.currentPage += 1
      self.isLoading = false
    } catch {
      print("Failed to load characters: \(error)")
      self.isLoading = false
    }
  }
  
  func toggleFavourite(character: Character) {
    if let index = favourites.firstIndex(where: { $0.id == character.id }) {
      favourites.remove(at: index)
    } else {
      favourites.append(character)
    }
  }
  
  func isFavourite(character: Character) -> Bool  {
    favourites.contains(where: { $0.id == character.id })
  }
}
