import Foundation

class APIService {
  private let baseURL = "https://rickandmortyapi.com/api/character"
  
  func fetchCharacters(page: Int, status: CharacterStatus? = nil, species: CharacterSpecies? = nil, gender: CharacterGender? = nil) async throws -> [Character] {
    
    var urlComponents = URLComponents(string: baseURL)
    
    guard var components = URLComponents(string: baseURL) else {
      throw APIErrors.invalidURL
    }
    
    var queryIteams = [URLQueryItem(name: "page", value: "\(page)")]
    
    if let status = status {
      queryIteams.append(URLQueryItem(name: "status", value: status.rawValue))
    }
    if let species = species {
      queryIteams.append(URLQueryItem(name: "species", value: species.rawValue))
    }
    if let gender = gender {
      queryIteams.append(URLQueryItem(name: "gender", value: gender.rawValue))
    }
    
    components.queryItems = queryIteams
    
    guard let url = components.url else {
      throw APIErrors.invalidURL
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    guard !data.isEmpty else {
      throw APIErrors.noData
    }
    
    let response = try JSONDecoder().decode(APIResponse.self,  from: data)
    
    return response.results
  }
}
