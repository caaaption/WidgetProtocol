import SwiftUI
import WidgetKit

public struct EmptyWidgetView: View {
  @Environment(\.widgetFamily) var widgetFamily
  
  public init() {}
  
  var font: Font? {
    switch widgetFamily {
    case .systemSmall:
      return .caption2
    case .systemMedium:
      return .body
      
    case .systemLarge:
      return .title
    default:
      return .body
    }
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text("How to use")
        .frame(alignment: .center)
        .frame(maxWidth: .infinity)
        .bold()
        .font(widgetFamily == .systemLarge ? .largeTitle : .body)
      
      Text("1 - Tap Add Widget with the size you want to set.")
        .font(font)
      
      Text("2 - Tap the Widget while the icon is shaking.")
        .font(font)
    
      Text("3 - Tap blue letter selection.")
        .font(font)
      
      Text("4 - Select the Widget you want to place.")
        .font(font)
    }
    .padding(.horizontal, 4)
  }
}

struct EmptyWidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    EmptyWidgetView()
      .previewLayout(.sizeThatFits)
  }
}
