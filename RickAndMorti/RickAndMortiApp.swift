import SwiftUI

@main
struct RickAndMortiApp: App {
    @StateObject private var viewModel = CharacterViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel) 
        }
    }
}

