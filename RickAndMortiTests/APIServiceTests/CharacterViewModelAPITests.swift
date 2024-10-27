import XCTest
@testable import RickAndMorti

class CharacterViewModelAPITests: XCTestCase {
  
  var viewModel: CharacterViewModel!
  var session: URLSession!
  
  @MainActor override func setUp() {
    super.setUp()
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [APIMockURLProtocol.self]
    session = URLSession(configuration: config)
    viewModel = CharacterViewModel()
  }
  
  override func tearDown() {
    APIMockURLProtocol.testData = nil
    APIMockURLProtocol.testError = nil
    super.tearDown()
  }
  
  @MainActor func testLoadCharactersSuccess() async throws {
    let mockData = """
    {
        "results": [
            {
                "id": 1,
                "name": "Rick Sanchez",
                "status": "Alive",
                "species": "Human",
                "gender": "Male",
                "image": "https://rick.com"
            }
        ]
    }
    """.data(using: .utf8)!
    
    APIMockURLProtocol.testData = mockData
    
    await viewModel.loadCharacters()
    
    XCTAssertEqual(viewModel.characters.count, 1)
    XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
    XCTAssertEqual(viewModel.characters.first?.status.rawValue, "Alive")
  }
  
  @MainActor func testLoadCharactersFailure() async throws {
    APIMockURLProtocol.testError = APIErrors.invalidURL
    
    await viewModel.loadCharacters()
    
    XCTAssertEqual(viewModel.characters.count, 0)
    XCTAssertEqual(viewModel.viewState, .error(APIErrors.invalidURL))
  }
}
