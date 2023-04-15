import Dependencies
import XCTestDynamicOverlay

extension DependencyValues {
  public var pushClient: PushClient {
    get { self[PushClient.self] }
    set { self[PushClient.self] = newValue }
  }
}

extension PushClient: TestDependencyKey {
  public static let testValue = Self(
    getNotifications: unimplemented("\(Self.self).getNotifications")
  )
}

extension PushClient {
  public static let noop = Self(
    getNotifications: { _ in try await Task.never() }
  )
}
