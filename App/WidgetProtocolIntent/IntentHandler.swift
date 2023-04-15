import Intents

public struct WidgetModel: Codable {
  let title: String
  let type: WidgetType
  
  public enum WidgetType: Codable {
    case balance(String)
    case link(String)
  }
}

class IntentHandler: INExtension, ConfigurationIntentHandling {
  let userDefaults = UserDefaults(suiteName: "group.com.caaaption.app.WidgetProtocol")!

  func provideTitleOptionsCollection(
    for intent: ConfigurationIntent,
    with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void
  ) {
    let decoder = JSONDecoder()
    guard
      let json = userDefaults.string(forKey: "widget-models"),
      let data = json.data(using: .utf8),
      let models = try? decoder.decode([WidgetModel].self, from: data)
    else {
      userDefaults.removeObject(forKey: "widget-models")
      completion(nil, nil)
      return
    }
    let items = models.map(\.title).map { $0 as NSString }
    let allNameIdentifiers = INObjectCollection(items: items)
    completion(allNameIdentifiers, nil)
  }
  
  override func handler(for intent: INIntent) -> Any {
    return self
  }
}
