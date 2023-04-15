import Foundation
import ComposableArchitecture
import UserDefaultsClient
import PushClient

public struct PushNotificationReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState var address = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case addWidget
  }
  
  @Dependency(\.userDefaults) var userDefaults
  @Dependency(\.pushClient) var pushClient

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return EffectTask.none
        
      case .addWidget:
        return EffectTask.run { [address = state.address] send in
          let hoge = try await pushClient.getNotifications(address)
//          let decoder = JSONDecoder()
//          guard
//            let json = userDefaults.string("widget-models"),
//            let data = json.data(using: .utf8),
//            var models = try? decoder.decode([WidgetModel].self, from: data)
//          else {
//            return
//          }
//          models.append(
//            WidgetModel(
//              title: "Push Link \(Date())",
//              type: .link("https://app.push.org/chat/\(address)")
//            )
//          )
//          let encoder = JSONEncoder()
//          let encodeData = try! encoder.encode(models)
//          let value = String(data: encodeData, encoding: .utf8)!
//          await userDefaults.setString(value, "widget-models")
        }
      }
    }
  }
}
