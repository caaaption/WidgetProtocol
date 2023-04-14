import Dependencies
import Foundation

extension UserDefaultsClient: DependencyKey {
  public static let liveValue: Self = {
    let defaults = { UserDefaults(suiteName: "group.com.caaaption.app.WidgetProtocol")! }
    return Self(
      stringArray: { defaults().stringArray(forKey: $0) },
      setArray: { defaults().set($0, forKey: $1) }
    )
  }()
}
