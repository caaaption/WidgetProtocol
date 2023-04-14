import WidgetKit
import SwiftUI
import Intents
import EmptyWidget
import QuickNodeClient
import ComposableArchitecture

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(
      date: .init(),
      balance: 0.0,
      configuration: ConfigurationIntent()
    )
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    guard let address = configuration.address else {
      return
    }
    Task {
      do {
        let balance = try await quickNodeClient.getBalance(address)
        let entry = SimpleEntry(
          date: .init(),
          balance: balance,
          configuration: configuration
        )
        completion(entry)
      } catch {
        print(error)
      }
    }
  }
  
  @Dependency(\.quickNodeClient) var quickNodeClient
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    let refresh = Calendar.current.date(
      byAdding: .minute,
      value: 30,
      to: .init()
    ) ?? Date()
    
    guard let address = configuration.address else {
      return
    }
    
    Task {
      do {
        let balance = try await quickNodeClient.getBalance(address)
        let entry = SimpleEntry(
          date: .init(),
          balance: balance,
          configuration: configuration
        )
        let timeline = Timeline(entries: [entry], policy: .after(refresh))
        completion(timeline)
      } catch {
        print(error)
      }
    }
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let balance: Decimal
  let configuration: ConfigurationIntent
}

struct QuickNodeBalanceEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    if let address = entry.configuration.address {
      VStack {
        Text("Balance")
          .font(.headline)
        Text(address.prefix(8) + "...")
        Text(entry.balance.description.prefix(6) + "ETH")
          .font(.title2)
          .bold()
          .foregroundColor(.blue)
      }
    } else {
      EmptyWidgetView()
    }
  }
}

struct QuickNodeBalance: Widget {
  let kind: String = "QuickNodeBalance"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      QuickNodeBalanceEntryView(entry: entry)
    }
    .configurationDisplayName("Balance")
    .description("Balance of the set address")
  }
}

struct QuickNodeBalance_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      QuickNodeBalanceEntryView(entry: SimpleEntry(date: .init(), balance: 0.0, configuration: .init()))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
      
      QuickNodeBalanceEntryView(entry: SimpleEntry(date: .init(), balance: 0.0, configuration: .init()))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
      
      QuickNodeBalanceEntryView(entry: SimpleEntry(date: .init(), balance: 0.0, configuration: .init()))
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
  }
}
