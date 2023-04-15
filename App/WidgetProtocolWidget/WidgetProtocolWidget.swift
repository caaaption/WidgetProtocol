import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), type: .balance(0.0), configuration: ConfigurationIntent())
  }
  
  func getSnapshot(
    for configuration: ConfigurationIntent,
    in context: Context,
    completion: @escaping (SimpleEntry) -> ()
  ) {
    completion(
      SimpleEntry(
        date: .init(),
        type: .balance(0.0),
        configuration: configuration
      )
    )
  }
  
  func getTimeline(
    for configuration: ConfigurationIntent,
    in context: Context,
    completion: @escaping (Timeline<Entry>) -> ()
  ) {
    let entry = SimpleEntry(
      date: .init(),
      type: .balance(0.0),
      configuration: configuration
    )
    
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let type: DisplayType
  let configuration: ConfigurationIntent
  
  enum DisplayType {
    case balance(Decimal)
    case art(Data)
  }
}

struct WidgetProtocolWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    Text(entry.date, style: .time)
  }
}

struct WidgetProtocolWidget: Widget {
  let kind: String = "WidgetProtocolWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(
      kind: kind,
      intent: ConfigurationIntent.self,
      provider: Provider()
    ) { entry in
      WidgetProtocolWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("WidgetProtocol")
    .description("This is an example widget.")
  }
}

struct WidgetProtocolWidget_Previews: PreviewProvider {
  static var previews: some View {
    WidgetProtocolWidgetEntryView(
      entry: SimpleEntry(
        date: Date(),
        type: .balance(0.0),
        configuration: ConfigurationIntent()
      )
    )
    .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
