import ComposableArchitecture
import QuickNodeBalanceFeature
import PushLinkFeature

public struct ProjectListReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var balance = BalanceReducer.State()
    public var link = PushLinkReducer.State()
    
    @BindingState public var searchable = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case balance(BalanceReducer.Action)
    case link(PushLinkReducer.Action)

    case task
    case refreshable
    case binding(BindingAction<State>)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(state: \.balance, action: /Action.balance) {
      BalanceReducer()
    }
    Scope(state: \.link, action: /Action.link) {
      PushLinkReducer()
    }
    Reduce { state, action in
      switch action {
      case .balance, .link:
        return EffectTask.none

      case .task:
        return EffectTask.none

      case .refreshable:
        return EffectTask.none

      case .binding:
        return EffectTask.none
      }
    }
  }
}
