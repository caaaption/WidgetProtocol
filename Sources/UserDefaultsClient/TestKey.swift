import Dependencies
import Foundation
import XCTestDynamicOverlay

extension UserDefaultsClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    string: unimplemented("\(Self.self).string"),
    setString: unimplemented("\(Self.self).setString")
  )
}

extension UserDefaultsClient {
  public static let noop = Self(
    string: { _ in "" },
    setString: { _, _ in }
  )
}
