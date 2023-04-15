import SwiftUI
import ProgressAsyncImage

struct ProjectCard: View {
  var body: some View {
    HStack(spacing: 16) {
      ProgressAsyncImage(
        "https://pbs.twimg.com/profile_images/1610359829763162112/UZjRjq0q_400x400.png",
        content: { $0.frame(width: 48, height: 48).cornerRadius(12) }
      )
      
      VStack(alignment: .leading, spacing: 0) {
        Text("QuickNode")
          .font(.headline)
        
        Text("Please select the address to display")
      }
    }
    .frame(height: 72)
  }
}

struct ProjectCardPreviews: PreviewProvider {
  static var previews: some View {
    List {
      ProjectCard()
    }
    .listStyle(.plain)
  }
}
