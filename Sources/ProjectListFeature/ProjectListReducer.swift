import ComposableArchitecture
import QuickNodeBalanceFeature

public struct ProjectListReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var balance = BalanceReducer.State()
    
    @BindingState public var searchable = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case balance(BalanceReducer.Action)

    case task
    case refreshable
    case binding(BindingAction<State>)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(state: \.balance, action: /Action.balance) {
      BalanceReducer()
    }
    Reduce { state, action in
      switch action {
      case .balance:
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
