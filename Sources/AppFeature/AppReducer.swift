import ComposableArchitecture
import SwiftUI
import ProjectListFeature

public struct AppReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var projectList = ProjectListReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case projectList(ProjectListReducer.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.projectList, action: /Action.projectList) {
      ProjectListReducer()
    }
  }
}

public struct AppView: View {
  let store: StoreOf<AppReducer>

  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }

  public var body: some View {
    NavigationView {
      ProjectListView(store: store.scope(state: \.projectList, action: AppReducer.Action.projectList))
    }
  }
}
