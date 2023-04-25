import GitHubClient
import ContributorFeature
import ComposableArchitecture

public struct SettingReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var contributor: ContributorReducer.State?
    public init() {}
  }

  public enum Action: Equatable {
    case contributor(ContributorReducer.Action)
    case setNavigation
    case contributorsResponse(TaskResult<[GitHubClient.Contributor]>)
  }
  
  @Dependency(\.gitHubClient) var githubClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .setNavigation:
        return EffectTask.task {
          await .contributorsResponse(
            TaskResult {
              try await self.githubClient.contributors("caaaption", "WidgetProtocol")
            }
          )
        }
        
      case let .contributorsResponse(.success(contributors)):
        let contributors = contributors
          .filter { $0.type == .User }
          .sorted(by: { $0.contributions > $1.contributions })
        state.contributor = ContributorReducer.State(contributors: contributors)
        return EffectTask.none
        
      case let .contributorsResponse(.failure(error)):
        print(error)
        state.contributor = nil
        return EffectTask.none
      }
    }
  }
}
