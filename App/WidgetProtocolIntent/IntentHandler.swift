import Intents

public enum WidgetModel: Codable {
  case balance(String)
  case art(Data)
  
  public var rawValue: NSString {
    switch self {
    case let .balance(address):
      return address.prefix(6) + " for balance"
    case .art:
      return "NFT Art"
    }
  }
}

class IntentHandler: INExtension, ConfigurationIntentHandling {
  let userDefaults = UserDefaults(suiteName: "group.com.caaaption.app.WidgetProtocol")!

  func provideWidgetTypeOptionsCollection(
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
    let allNameIdentifiers = INObjectCollection(items: models.map(\.rawValue))
    completion(allNameIdentifiers, nil)
  }
  
  override func handler(for intent: INIntent) -> Any {
    return self
  }
}
