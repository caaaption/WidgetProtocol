import SwiftUI
import ComposableArchitecture
import QuickNodeBalanceFeature

public struct ProjectListView: View {
  let store: StoreOf<ProjectListReducer>
  
  public init(store: StoreOf<ProjectListReducer>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        NavigationLink(
          destination: BalanceView(
            store: store.scope(state: \.balance, action: ProjectListReducer.Action.balance)
          ),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1610359829763162112/UZjRjq0q_400x400.png",
              title: "balance for QuickNode",
              description: "Please select the address to display"
            )
          }
        )
      }
      .listStyle(.plain)
      .navigationTitle("dApps / Protocol")
      .task { await viewStore.send(.task).finish() }
      .refreshable { await viewStore.send(.refreshable).finish() }
      .searchable(
        text: viewStore.binding(\.$searchable),
        placement: .navigationBarDrawer(
          displayMode: .always
        ),
        prompt: "Search Widget"
      )
    }
  }
}

struct ProjectListViewPreviews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ProjectListView(
        store: .init(
          initialState: ProjectListReducer.State(),
          reducer: ProjectListReducer()
        )
      )
    }
  }
}
