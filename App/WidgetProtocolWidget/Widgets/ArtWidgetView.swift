import SwiftUI

struct ArtWidgetView: View {
  let data: Data
  
  var body: some View {
    Group {
      if let uiImage = UIImage(data: data) {
        Image(uiImage: uiImage)
      } else {
        ProgressView()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
