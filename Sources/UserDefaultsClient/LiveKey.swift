import Dependencies
import Foundation

extension UserDefaultsClient: DependencyKey {
  public static let liveValue: Self = {
    let defaults = { UserDefaults(suiteName: "group.com.caaaption.app.WidgetProtocol")! }
    return Self(
      string: { defaults().string(forKey: $0) },
      setString: { defaults().set($0, forKey: $1) }
    )
  }()
}
