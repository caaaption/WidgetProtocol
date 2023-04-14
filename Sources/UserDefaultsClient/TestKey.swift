import Dependencies
import Foundation
import XCTestDynamicOverlay

extension UserDefaultsClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    stringArray: unimplemented("\(Self.self).stringArray"),
    setArray: unimplemented("\(Self.self).setArray")
  )
}

extension UserDefaultsClient {
  public static let noop = Self(
    stringArray: { _ in [] },
    setArray: { _, _ in }
  )
}
