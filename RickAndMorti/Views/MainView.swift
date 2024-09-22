import SwiftUI

struct MainView: View {
  var body: some View {
    NavigationView {
      VStack {
        Image( "firstview")
          .resizable()
          .scaledToFit()
          .padding()
        
        //NavigationLink(destination: CharacterListView()) {
          Label("Search", systemImage: "magnifyingglass")
          .font(.title2)
          .padding()
          .background(Color.black)
          .foregroundColor(.white)
          .cornerRadius(10)
        Label("Favorites", systemImage: "heart")
          .font(.title2)
          .padding()
          .background(Color.black)
          .foregroundColor(.white)
          .cornerRadius(10)
        
       // } .padding
      }
      // NavigationLin(destination: FavouritesView() {}
      
    }
  }
}

#Preview {
    MainView()
}
