import Foundation

struct APIResponse: Codable {
  let info: Info
  let results: [Character]
}

struct Info: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}
