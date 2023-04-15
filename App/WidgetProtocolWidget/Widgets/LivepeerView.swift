import SwiftUI

struct LivepeerView: View {
  var body: some View {
    GeometryReader { proxy in
      Image("image")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: proxy.size.width, height: proxy.size.height)
        .clipped()
    }
  }
}
