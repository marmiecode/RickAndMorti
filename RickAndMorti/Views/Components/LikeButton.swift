import SwiftUI

struct LikeButton: View {
  @Binding var isLiked: Bool
  
  var body: some View {
    Button(action: {
      isLiked.toggle()
    }) {
      Image(systemName: isLiked ? "heart.fill" : "heart")
        .foregroundColor(isLiked ? .red : .gray)
        .imageScale(.large)
        .padding()
    }
  }
}

#if DEBUG
#Preview {
  LikeButton(isLiked: .constant(false))
}
#endif
