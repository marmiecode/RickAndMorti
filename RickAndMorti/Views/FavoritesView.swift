import SwiftUI

struct FavoritesView: View {
  @ObservedObject var viewModel = CharacterViewModel()
  
    var body: some View {
      List(viewModel.favourites) { character in
        HStack {
          AsyncImage(url: character.image) { image in image.resizable().scaledToFill()
          } placeholder: {
            ProgressView()
          }
          .frame(width: 50, height: 50)
          .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
          
          VStack(alignment: .leading) {
            Text(character.name)
              .font(.headline)
            Text(character.species.description)
              .font(.subheadline)
            
          }
          
          Spacer()
          
          //likeb
        }}
    }
}

#Preview {
    FavoritesView()
}
