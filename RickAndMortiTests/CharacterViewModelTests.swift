import XCTest
@testable import RickAndMorti

class CharacterViewModelTests: XCTestCase {
  
  var viewModel: CharacterViewModel!
  
  @MainActor override func setUp() {
    super.setUp()
    viewModel = CharacterViewModel()
  }
  
  @MainActor func testToggleFavouriteAddsCharacter() {
    let character = Character(id: 1, name: "Rick", status: .alive, species: .human, gender: .male, image: URL(string: "https://rick.com")!)
    
    viewModel.toggleFavourite(character: character)
    
    XCTAssertTrue(viewModel.isFavourite(character: character), "Character should be added to favourites.")
  }
  
  @MainActor func testToggleFavouriteRemovesCharacter() {
    let character = Character(id: 1, name: "Rick", status: .alive, species: .human, gender: .male, image: URL(string: "https://rick.com")!)
    
    viewModel.toggleFavourite(character: character)
    viewModel.toggleFavourite(character: character)
    
    XCTAssertFalse(viewModel.isFavourite(character: character), "Character should be removed from favourites.")
  }
}

