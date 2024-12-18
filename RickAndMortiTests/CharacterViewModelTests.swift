@testable import RickAndMorti
import XCTest

@MainActor
class CharacterViewModelTests: XCTestCase {
  
  var viewModel: CharacterViewModel!
  var session: URLSession!
  
  override func setUp() {
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
  
  func testLoadCharactersSuccess() async throws {
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
    XCTAssertEqual(viewModel.viewState, .loaded)
  }
  
  func testLoadCharactersEmpty() async throws {
    let emptyMockData = """
        { "results": [] }
        """.data(using: .utf8)!
    
    APIMockURLProtocol.testData = emptyMockData
    await viewModel.loadCharacters()
    
    XCTAssertEqual(viewModel.characters.count, 0)
    XCTAssertEqual(viewModel.viewState, .empty)
  }
  
  func testLoadCharactersFailure() async throws {
    APIMockURLProtocol.testError = APIErrors.invalidURL
    await viewModel.loadCharacters()
    
    XCTAssertEqual(viewModel.characters.count, 0)
    XCTAssertEqual(viewModel.viewState, .error(APIErrors.invalidURL))
  }
}
