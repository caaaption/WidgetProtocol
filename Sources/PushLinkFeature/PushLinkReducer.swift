import Foundation
import ComposableArchitecture
import UserDefaultsClient

public struct PushLinkReducer: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    @BindingState var link = ""
    public init() {}
  }
  
  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case addWidget
  }
  
  @Dependency(\.userDefaults) var userDefaults
  
  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return EffectTask.none
        
      case .addWidget:
        return EffectTask.run { [link = state.link] send in
          let decoder = JSONDecoder()
          guard
            let json = userDefaults.string("widget-models"),
            let data = json.data(using: .utf8),
            var models = try? decoder.decode([WidgetModel].self, from: data)
          else {
            return
          }
          models.append(
            WidgetModel(
              title: "Push Link \(Date())",
              type: .link(link)
            )
          )
          let encoder = JSONEncoder()
          let encodeData = try! encoder.encode(models)
          let value = String(data: encodeData, encoding: .utf8)!
          await userDefaults.setString(value, "widget-models")
        }
      }
    }
  }
}
