import SwiftUI

public struct QuickNodeNFTView: View {
  let data: Data
  public init(data: Data) {
    self.data = data
  }
  
  public var body: some View {
    Group {
      if let image = UIImage(data: data) {
        Image(uiImage: image)
      } else {
        ProgressView()
      }
    }
  }
}
