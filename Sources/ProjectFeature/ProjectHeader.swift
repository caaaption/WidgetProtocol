import SwiftUI
import ProgressAsyncImage

struct ProjectHeader: View {
  @Environment(\.dismiss) var dismiss

  var body: some View {
    HStack(spacing: 8) {
      ProgressAsyncImage(
        "https://pbs.twimg.com/profile_images/1610359829763162112/UZjRjq0q_400x400.png",
        content: { image in
          image
            .frame(width: 30, height: 30)
            .cornerRadius(6)
        }
      )
      Text("Quick Node")
        .font(.caption)
        .bold()
      
      Spacer()
      
      Button(action: { dismiss() }) {
        Image(systemName: "xmark.circle.fill")
          .font(.system(size: 30))
      }
    }
  }
}

struct ProjectHeaderPreviews: PreviewProvider {
  static var previews: some View {
    ProjectHeader()
      .previewLayout(.sizeThatFits)
  }
}
