import Foundation
import ComposableArchitecture

public struct BalanceResponse: Codable {
  public let result: String
}

public struct QuickNodeClient {
  public var getBalance: @Sendable (String) async throws -> Decimal
  public var getNfts: @Sendable (String) async throws -> [String]
}
