import Foundation

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
    }
  }
  
}
