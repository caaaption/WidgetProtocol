import SwiftUI

struct PushLinkWidgetView: View {
  let link: String
  var body: some View {
    GeometryReader { proxy in
      VStack(spacing: 8) {
        Color.red
          .frame(width: proxy.size.width / 3, height: proxy.size.width / 3)
          .cornerRadius(proxy.size.width / 6)
        
        Text(link)
      }
      .padding()
    }
  }
}
