import SwiftUI

struct CharactersListView: View {
  @ObservedObject var viewModel: CharacterViewModel
  
  @State private var selectStatus: CharacterStatus? = nil
  @State private var selectSpecies: CharacterSpecies? = nil
  @State private var selectGender: CharacterGender? = nil
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Picker("Status", selection: $selectStatus) {
            Text("Status").tag(CharacterStatus?.none)
            ForEach(CharacterStatus.allCases, id: \.self) { status in
              Text(status.description).tag(status as CharacterStatus?)
            }
          }
          .frame(width: 100)
          .padding()
          
          Picker("Species", selection: $selectSpecies) {
            Text("Species").tag(CharacterSpecies?.none)
            ForEach(CharacterSpecies.allCases, id: \.self) { species in
              Text(species.description).tag(species as CharacterSpecies?)
            }
          }
          .frame(width: 100)
          .padding()
          
          Picker("Gender", selection: $selectGender) {
            Text("Gender").tag(CharacterGender?.none)
            ForEach(CharacterGender.allCases, id: \.self) { gender in
              Text(gender.description).tag(gender as CharacterGender?)
            }
          }
          .frame(width: 100)
          .padding()
        }
        
        List(filteredCharacters()) { character in
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
            
            LikeButton(isLiked: Binding(
              get: { viewModel.isFavourite(character: character) },
              set: { newValue in viewModel.toggleFavourite(character: character) }
            ))
          }
        }
        .onAppear {
          Task {
            await viewModel.loadCharacters()
          }
        }
      }
      .navigationTitle("Characters")
    }
  }
  
  private func filteredCharacters() -> [Character] {
    return viewModel.characters.filter { character in
      let matchesGender = (selectGender == nil || character.gender == selectGender)
      let matchesSpecies = (selectSpecies == nil || character.species == selectSpecies)
      let matchesStatus = (selectStatus == nil || character.status == selectStatus)
      
      return matchesGender && matchesSpecies && matchesStatus
    }
  }
}
