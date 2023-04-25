import ComposableArchitecture
import SwiftUI
import ProjectListFeature
import SettingFeature

public struct AppReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var projectList = ProjectListReducer.State()
    public var setting = SettingReducer.State()
    
    public var isSheetPresented = false
    public init() {}
  }

  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case projectList(ProjectListReducer.Action)
    case setting(SettingReducer.Action)
    
    case setSheet(isPresented: Bool)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.projectList, action: /Action.projectList) {
      ProjectListReducer()
    }
    Scope(state: \.setting, action: /Action.setting) {
      SettingReducer()
    }
    Reduce { state, action in
      switch action {
      case let .setSheet(isPresented):
        state.isSheetPresented = isPresented
        return EffectTask.none.animation()
        
      default:
        return EffectTask.none
      }
    }
  }
}

public struct AppView: View {
  let store: StoreOf<AppReducer>

  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationView {
        ProjectListView(store: store.scope(state: \.projectList, action: AppReducer.Action.projectList))
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              Button {
                viewStore.send(.setSheet(isPresented: true))
              } label: {
                Image(systemName: "gearshape.fill")
              }
            }
          }
      }
      .onOpenURL { url in
        UIApplication.shared.open(url)
      }
      .sheet(
        isPresented: viewStore.binding(
          get: \.isSheetPresented,
          send: AppReducer.Action.setSheet(isPresented:)
        ),
        content: {
          NavigationView {
            SettingView(store: store.scope(state: \.setting, action: AppReducer.Action.setting))
          }
        }
      )
    }
  }
}
