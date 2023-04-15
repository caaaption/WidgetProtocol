import UserDefaultsClient
import ComposableArchitecture

public struct BalanceReducer: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    @BindingState public var address = ""
    public var addresses: [String] = []
    public init() {}
  }
  
  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case addWidget
    case task
  }
  
  @Dependency(\.userDefaults) var userDefaults
  
  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .addWidget:
        return EffectTask.run { [address = state.address] send in
          var addresses = userDefaults.stringArray("quick-node-balance-addresses") ?? []
          print("[old]: \(addresses)")
          if !addresses.contains(address) {
            addresses.append(address)
          }
          await userDefaults.setArray(addresses, "quick-node-balance-addresses")
          await send(.task)
        }
        
      case .binding:
        return EffectTask.none
        
      case .task:
        state.addresses = userDefaults.stringArray("quick-node-balance-addresses") ?? []
        return EffectTask.none.animation()
      }
    }
  }
}
