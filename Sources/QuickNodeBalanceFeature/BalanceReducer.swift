import Foundation
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
      @Sendable func getModels() -> [WidgetModel] {
        let decoder = JSONDecoder()
        guard
          let json = userDefaults.string("widget-models"),
          let data = json.data(using: .utf8),
          let models = try? decoder.decode([WidgetModel].self, from: data)
        else {
          return []
        }
        return models
      }
      switch action {
      case .addWidget:
        return EffectTask.run { [address = state.address] send in
          var models = getModels()
          models.append(
            WidgetModel(
              title: "balance \(Date())",
              type: .balance(address)
            )
          )
          let encoder = JSONEncoder()
          let data = try! encoder.encode(models)
          let json = String(data: data, encoding: .utf8)!
          await userDefaults.setString(json, "widget-models")
          await send(.task)
        }
        
      case .binding:
        return EffectTask.none
        
      case .task:
        let models = getModels()
        let addresses = models.filter { model in
          switch model.type {
          case .balance:
            return true
          case .art:
            return false
          }
        }.map { model in
          switch model.type {
          case let .balance(address):
            return address
          default:
            return ""
          }
        }
        print(addresses)
        state.addresses = addresses
        return EffectTask.none.animation()
      }
    }
  }
}
