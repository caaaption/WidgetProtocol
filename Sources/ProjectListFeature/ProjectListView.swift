import SwiftUI
import ComposableArchitecture
import QuickNodeBalanceFeature
import PushLinkFeature

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
              title: "Balance for QuickNode",
              description: "Please select the address to display"
            )
          }
        )
        
        NavigationLink(
          destination: PushLinkView(
            store: store.scope(state: \.link, action: ProjectListReducer.Action.link)
          ),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1616110831975931909/5tUeoUR__400x400.png",
              title: "Link for Push Protocol",
              description: "Open the configured chat window"
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
