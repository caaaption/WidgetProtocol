import SwiftUI

struct LensLinkView: View {
  let username: String
  var body: some View {
    GeometryReader { proxy in
      VStack(alignment: .center, spacing: 8) {
        Image("lens")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: proxy.size.width / 3, height: proxy.size.width / 3)
          .cornerRadius(proxy.size.width / 6)
        
        Text(username)
      }
      .padding()
    }
  }
}
