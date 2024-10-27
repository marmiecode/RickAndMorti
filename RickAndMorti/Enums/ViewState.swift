import Foundation

enum ViewState: Equatable {
  case loading
  case loaded
  case empty
  case error(Error)
  
  static func == (lhs: ViewState, rhs: ViewState) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading), (.loaded, .loaded), (.empty, .empty):
      return true
    case let (.error(lhsError), .error(rhsError)):
      return lhsError.localizedDescription == rhsError.localizedDescription
    default:
      return false
    }
  }
}

