import SwiftUI

struct FavoritesView: View {
  @ObservedObject var viewModel = CharacterViewModel()
  
  var body: some View {
    VStack {
      if viewModel.favourites.isEmpty {
        Text("Empty")
          .font(.title2)
          .padding()
      }else {
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
            
            LikeButton(isLiked: Binding(
              get: { viewModel.isFavourite(character: character) },
              set: { newValue in viewModel.toggleFavourite(character: character) }
            ))
          }
        }
      }
    }
  }
}

#if DEBUG
#Preview {
  FavoritesView()
}
#endif
