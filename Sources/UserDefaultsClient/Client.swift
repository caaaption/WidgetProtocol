import Dependencies
import Foundation

extension DependencyValues {
  public var userDefaults: UserDefaultsClient {
    get { self[UserDefaultsClient.self] }
    set { self[UserDefaultsClient.self] = newValue }
  }
}

public struct UserDefaultsClient {
  public var string: @Sendable (String) -> String?
  public var setString: @Sendable (String, String) async -> Void
}

public struct WidgetModel: Codable, Equatable {
  public let title: String
  public let type: WidgetType
  
  public enum WidgetType: Codable, Equatable {
    case balance(String)
    case link(String)
  }
  
  public init(
    title: String,
    type: WidgetType
  ) {
    self.title = title
    self.type = type
  }
}
