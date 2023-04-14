import ComposableArchitecture

public struct BalanceReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState public var address = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case addWidget
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { _, action in
      switch action {
      case .addWidget:
        print("addWidget")
        return EffectTask.none

      case .binding:
        return EffectTask.none
      }
    }
  }
}
