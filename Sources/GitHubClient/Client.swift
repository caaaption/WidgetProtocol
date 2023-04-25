import ComposableArchitecture

public struct GitHubClient {
  public var contributors: @Sendable (String, String) async throws -> [Contributor]
  
  public struct Contributor: Codable, Equatable, Identifiable {
    public let login: String
    public let id: Int
    public let avatarUrl: String
    public let type: ContributorType
    public let contributions: Int
    
    public enum ContributorType: String, Codable {
      case User
      case Bot
    }
  }
}
