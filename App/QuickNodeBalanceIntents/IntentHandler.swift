import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
  func provideAddressOptionsCollection(
    for intent: ConfigurationIntent,
    with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void
  ) {
    
    let userDefaults = UserDefaults(suiteName: "group.com.caaaption.app.WidgetProtocol")
    guard let addresses = userDefaults?.array(forKey: "quick-node-balance-addresses") as? [NSString] else {
      completion(nil, nil)
      return
    }
    
    let allNameIdentifiers = INObjectCollection(items: addresses)
    
    completion(allNameIdentifiers, nil)
  }
  
  override func handler(for intent: INIntent) -> Any {
    return self
  }
}
