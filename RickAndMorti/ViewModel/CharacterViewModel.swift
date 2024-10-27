import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
  @Published var characters: [Character] = []
  @Published var favourites: [Character] = []
  @Published var currentPage = 1
  @Published var isLoading = false
  @Published var viewState: ViewState = .loading
  @Published var selectedStatus: CharacterStatus?
  @Published var selectedSpecies: CharacterSpecies?
  @Published var selectedGender: CharacterGender?
  
  private var apiService: APIService
  
  init(apiService: APIService = APIService()) {
    self.apiService = apiService
  }
  
  func loadCharacters() async {
    guard !isLoading else { return }
    isLoading = true
    viewState = .loading
    
    do {
      let newCharacters = try await apiService.fetchCharacters(
        page: currentPage,
        status: selectedStatus,
        species: selectedSpecies,
        gender: selectedGender
      )
      
      if newCharacters.isEmpty {
        viewState = currentPage == 1 ? .empty : .loaded
      } else {
        self.characters.append(contentsOf: newCharacters)
        currentPage += 1
        viewState = .loaded
      }
      
    } catch {
      viewState = .error(error)
    }
    
    isLoading = false
  }
  
  func toggleFavourite(character: Character) {
    if let index = favourites.firstIndex(where: { $0.id == character.id }) {
      favourites.remove(at: index)
    } else {
      favourites.append(character)
    }
  }
  
  func isFavourite(character: Character) -> Bool {
    favourites.contains(where: { $0.id == character.id })
  }
}
