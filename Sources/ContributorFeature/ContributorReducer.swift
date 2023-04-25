import GitHubClient
import ComposableArchitecture

public struct ContributorReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var contributors: [GitHubClient.Contributor]

    public init(contributors: [GitHubClient.Contributor]) {
      self.contributors = contributors
    }
  }

  public enum Action: Equatable {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {}
    }
  }
}
