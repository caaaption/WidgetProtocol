import SwiftUI

struct CountView: View {
  let title: String
  let count: Int
  
  var body: some View {
    VStack(alignment: .center, spacing: 16) {
      Text(title)
        .frame(maxWidth: .infinity)
      
      Text(count.description)
        .font(.largeTitle)
    }
  }
}
