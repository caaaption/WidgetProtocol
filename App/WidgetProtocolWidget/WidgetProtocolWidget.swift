import WidgetKit
import SwiftUI
import Intents
import QuickNodeClient
import ComposableArchitecture

public struct WidgetModel: Codable {
  let title: String
  let type: WidgetType
  
  public enum WidgetType: Codable {
    case balance(String)
    case link(String)
    case notification
    case lens(String)
    case lensFollowers(Int)
  }
}

struct Provider: IntentTimelineProvider {
  let userDefaults = UserDefaults(suiteName: "group.com.caaaption.app.WidgetProtocol")!
  @Dependency(\.quickNodeClient) var quickNodeClient
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(
      date: Date(),
      type: nil,
      configuration: ConfigurationIntent()
    )
  }
  
  func getSnapshot(
    for configuration: ConfigurationIntent,
    in context: Context,
    completion: @escaping (SimpleEntry) -> ()
  ) {
    let decoder = JSONDecoder()
    guard
      let title = configuration.title,
      let json = userDefaults.string(forKey: "widget-models"),
      let data = json.data(using: .utf8),
      let models = try? decoder.decode([WidgetModel].self, from: data),
      let model = models.first(where: { $0.title == title })
    else {
      completion(
        SimpleEntry(
          date: .init(),
          type: nil,
          configuration: configuration
        )
      )
      return
    }
//  case balance(String)
//  case link(String)
//  case notification
//  case lens(String)
//  case lensFollowers(Int)
    switch model.type {
    case let .balance(address):
      Task {
        let balance = try await quickNodeClient.getBalance(address)
        completion(
          SimpleEntry(
            date: .init(),
            type: .balance(address, balance),
            configuration: configuration
          )
        )
      }
    case let .link(link):
      completion(
        SimpleEntry(
          date: .init(),
          type: .link(link),
          configuration: configuration
        )
      )
    case .notification:
      completion(
        SimpleEntry(
          date: .init(),
          type: .notification,
          configuration: configuration
        )
      )
    case let .lens(useranme):
      completion(
        SimpleEntry(
          date: .init(),
          type: .lens(useranme),
          configuration: configuration
        )
      )
    case let .lensFollowers(count):
      completion(
        SimpleEntry(
          date: .init(),
          type: .lensFollowers(count),
          configuration: configuration
        )
      )
    }
  }
  
  func getTimeline(
    for configuration: ConfigurationIntent,
    in context: Context,
    completion: @escaping (Timeline<Entry>) -> ()
  ) {
    getSnapshot(for: configuration, in: context) { entry in
      let timeline = Timeline(entries: [entry], policy: .atEnd)
      completion(timeline)
    }
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let type: DisplayType?
  let configuration: ConfigurationIntent
  
  enum DisplayType {
    case balance(String, Decimal)
    case link(String)
    case notification
    case lens(String)
    case lensFollowers(Int)
  }
}

struct WidgetProtocolWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    switch entry.type {
    case let .balance(address, balance):
      BalanceWidgetView(
        address: address,
        balance: balance
      )
    case let .link(link):
      PushLinkWidgetView(link: link)
        .widgetURL(
          URL(string: link)
        )
    case let .lens(username):
      LensLinkView(username: username)
        .widgetURL(
          URL(string: "https://lenster.xyz/u/" + username)
        )
    case let .lensFollowers(count):
      CountView(
        title: "Follower Count",
        count: count
      )
    default:
      ProgressView()
    }
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
        type: nil,
        configuration: ConfigurationIntent()
      )
    )
    .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
