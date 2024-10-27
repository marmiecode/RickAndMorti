import XCTest
@testable import RickAndMorti

class APIMockURLProtocol: URLProtocol {
  static var testData: Data?
  static var testError: Error?
  
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override func startLoading() {
    if let error = APIMockURLProtocol.testError {
      self.client?.urlProtocol(self, didFailWithError: error)
    } else if let data = APIMockURLProtocol.testData {
      self.client?.urlProtocol(self, didLoad: data)
    }
    self.client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() {}
}

class APIServiceTests: XCTestCase {
  
  var apiService: APIService!
  var session: URLSession!
  
  override func setUp() {
    super.setUp()
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [APIMockURLProtocol.self]
    session = URLSession(configuration: config)
    apiService = APIService()
  }
  
  override func tearDown() {
    APIMockURLProtocol.testData = nil
    APIMockURLProtocol.testError = nil
    super.tearDown()
  }
  
  func testFetchCharactersSuccess() async throws {
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
    
    let characters = try await apiService.fetchCharacters(page: 1)
    
    XCTAssertEqual(characters.first?.name, "Rick Sanchez")
    XCTAssertEqual(characters.first?.status.rawValue, "Alive")
    
  }
}
