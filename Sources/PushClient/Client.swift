import Foundation
import ComposableArchitecture

public struct Notification: Codable {
  
}

public struct PushClient {
  public var getNotifications: @Sendable (String) async throws -> [Notification]
}
