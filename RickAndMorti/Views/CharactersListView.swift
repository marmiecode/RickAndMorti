import SwiftUI

struct CharactersListView: View {
  @StateObject var viewModel = CharacterViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        List(viewModel.character) { character in
          NavigationLink(destination: CharacterDetailView(character: character)) {
            HStack {
              AsyncImage(url: character.image) { image in
                image.resizable().scaledToFill()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 50, height: 50)
              .clipShape(Circle())
              
              VStack(alignment: .leading) {
                Text(character.name)
                  .font(.headline)
                Text(character.species.description)
                  .font(.subheadline)
                  .lineLimit(1)
              }
              
              Spacer()
            }
          }
        }
        .onAppear {
          Task {
            await viewModel.loadCharacter()
          }
        }
      }
      .navigationTitle("Characters")
    }
  }
}

#if DEBUG
#Preview {
  CharactersListView()
}
#endif
