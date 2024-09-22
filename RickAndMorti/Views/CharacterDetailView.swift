import SwiftUI

struct CharacterDetailView: View {
  var character: Character
  
  var body: some View {
    VStack {
      AsyncImage(url: character.image) { image in
        image.resizable().scaledToFit()
      } placeholder: {
        ProgressView()
      }
      .frame(height: 200)
      
      Text(character.name)
        .font(.largeTitle)
        .padding()
      
      Text("Status: \(character.status.rawValue.capitalized)")
      Text("Species: \(character.species.rawValue.capitalized)")
      Text("Gender: \(character.gender.rawValue.capitalized)")
    }
    .padding()
    .navigationTitle(character.name)
  }
}


