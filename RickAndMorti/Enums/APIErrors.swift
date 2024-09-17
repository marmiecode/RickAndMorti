import Foundation

enum APIErrors: Error {
  case invalidURL
  case noData
  
  var localizedDescription: String {
    switch self {
    case .invalidURL:
      return "Invalid URL. Please chceck the API endpoint"
    case .noData:
      return "No data was returned from the server"
    }
  }
}
