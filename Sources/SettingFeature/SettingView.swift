import ContributorFeature
import ComposableArchitecture
import SwiftUI

public struct SettingView: View {
  let store: StoreOf<SettingReducer>

  public init(store: StoreOf<SettingReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        NavigationLink(
          destination: IfLetStore(
            store.scope(
              state: \.contributor,
              action: SettingReducer.Action.contributor
            ),
            then: ContributorView.init(store:),
            else: ProgressView.init
          ),
          label: {
            Text("Contributors")
          }
        )
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Setting")
      .task { await viewStore.send(.setNavigation).finish() }
    }
  }
}

struct SettingViewPreviews: PreviewProvider {
  static var previews: some View {
    SettingView(
      store: .init(
        initialState: SettingReducer.State(),
        reducer: SettingReducer()
      )
    )
  }
}
