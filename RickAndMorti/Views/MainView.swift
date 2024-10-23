import SwiftUI

struct MainView: View {
  @ObservedObject var viewModel: CharacterViewModel  
  
  var body: some View {
    NavigationView {
      VStack {
        Image("firstview")
          .resizable()
          .scaledToFit()
          .padding()
        
        
        NavigationLink(destination: CharactersListView(viewModel: viewModel)) {
          Label("Search", systemImage: "magnifyingglass")
            .font(.title2)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        
        
        NavigationLink(destination: FavoritesView(viewModel: viewModel)) {
          Label("Favorites", systemImage: "heart")
            .font(.title2)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
      }
      .navigationTitle("Main Menu")
    }
  }
}

