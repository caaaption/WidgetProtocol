import SwiftUI

public struct ProgressAsyncImage<V>: View where V : View {
  let url: URL?
  let content: (AnyView) -> V
  
  public init(_ url: String, @ViewBuilder content: @escaping (AnyView) -> V) {
    self.url = URL(string: url)
    self.content = content
  }
  
  public var body: some View {
    AsyncImage(
      url: url,
      content: { image in
        content(AnyView(image.resizable().aspectRatio(contentMode: .fill)))
      },
      placeholder: {
        ProgressView()
      }
    )
  }
}
