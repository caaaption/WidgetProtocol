import SwiftUI
import ProgressAsyncImage

struct ProjectCard: View {
  let imageUrl: String
  let title: String
  var description: String? = nil
  
  var body: some View {
    HStack(spacing: 16) {
      ProgressAsyncImage(
        imageUrl,
        content: { $0.frame(width: 48, height: 48).cornerRadius(12) }
      )
      
      VStack(alignment: .leading, spacing: 0) {
        Text(title)
          .font(.headline)
        
        if let description = description {
          Text(description)
        }
      }
    }
    .frame(height: 72)
  }
}
