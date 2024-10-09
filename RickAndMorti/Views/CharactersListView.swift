import SwiftUI

struct CharactersListView: View {
  @StateObject var viewModel = CharacterViewModel()
  
  @State private var selectStatus: CharacterStatus? = nil
  @State private var selectSpecies: CharacterSpecies? = nil
  @State private var selectGender: CharacterGender? = nil
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Picker("Status", selection: $selectStatus){ Text("Status").tag(CharacterStatus?.none)
            ForEach(CharacterStatus.allCases, id:\.self) { species in Text(species.description).tag(species as CharacterStatus?)
            }
          }
          .frame(width: 100)
          .padding()
          .accentColor(.black)
          .background(Color.blue.opacity(0.2))
          .cornerRadius(8)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.blue, lineWidth: 1)
          )
          
          
          Picker("Species", selection: $selectSpecies) {
            Text("Species").tag(CharacterSpecies?.none)
            ForEach(CharacterSpecies.allCases, id:\.self) { species in Text(species.description).tag(species as CharacterSpecies?)
            }
          }
          .frame(width: 100)
          .padding()
          .accentColor(.black)
          .background(Color.blue.opacity(0.2))
          .cornerRadius(8)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.blue, lineWidth: 1)
          )
          
          Picker("Gender", selection: $selectGender) {
            Text("Gender").tag(CharacterGender?.none)
            ForEach(CharacterGender.allCases, id: \.self) { gender in Text(gender.description).tag(gender as CharacterGender?)
            }
          }
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
          .padding()
          .accentColor(.black)
          .background(Color.blue.opacity(0.2))
          .cornerRadius(8)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.blue, lineWidth: 1)
          )
        }
        .padding(.horizontal)
        
        List(filteredCharacters()) { character in
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
  
  private func filteredCharacters() -> [Character] {
    return viewModel.character.filter { character in
      (selectGender == nil || character.gender == selectGender) &&
      (selectSpecies == nil || character.species == selectSpecies) &&
      (selectStatus == nil || character.status == selectStatus)
    }
  }
}

#if DEBUG
#Preview {
  CharactersListView()
}
#endif
