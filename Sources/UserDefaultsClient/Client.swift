import Dependencies
import Foundation

extension DependencyValues {
  public var userDefaults: UserDefaultsClient {
    get { self[UserDefaultsClient.self] }
    set { self[UserDefaultsClient.self] = newValue }
  }
}

public struct UserDefaultsClient {
  public var stringArray: @Sendable (String) -> Array<String>?
  public var setArray: @Sendable (Array<String>, String) async -> Void
}

