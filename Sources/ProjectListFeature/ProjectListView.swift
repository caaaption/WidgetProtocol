import SwiftUI
import ComposableArchitecture
import QuickNodeBalanceFeature
import PushLinkFeature
import PushNotificationFeature
import LensLinkFeature
import LensFollowerFeature
import LensFollowingFeature

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
        
        NavigationLink(
          destination: PushNotificationView(
            store: store.scope(state: \.notification, action: ProjectListReducer.Action.notification)
          ),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1616110831975931909/5tUeoUR__400x400.png",
              title: "Notifications for Push Protocol"
            )
          }
        )
        
        NavigationLink(
          destination: LensLinkView(
            store: store.scope(state: \.lensLink, action: ProjectListReducer.Action.lensLink)
          ),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1611047066746093593/cd3kFbZ4_400x400.jpg",
              title: "Link for Lens Protocol"
            )
          }
        )
        
        NavigationLink(
          destination: LensFollowerView(
            store: store.scope(state: \.lensFollower, action: ProjectListReducer.Action.lensFollower)
          ),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1611047066746093593/cd3kFbZ4_400x400.jpg",
              title: "Follower for Lens Protocol"
            )
          }
        )
        
        NavigationLink(
          destination: LensFollowingView(
            store: store.scope(state: \.lensFollowing, action: ProjectListReducer.Action.lensFollowing)
          ),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1611047066746093593/cd3kFbZ4_400x400.jpg",
              title: "Following for Lens Protocol"
            )
          }
        )
        
        NavigationLink(
          destination: Text("404 not found"),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1341100720943054848/C4RKAej-_400x400.jpg",
              title: "The Graph"
            )
          }
        )
        
        NavigationLink(
          destination: Text("404 not found"),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1639270979288399876/3OT3Lsux_400x400.jpg",
              title: "Polygon"
            )
          }
        )
        
        NavigationLink(
          destination: Text("404 not found"),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1603829076346667022/6J-QZXPB_400x400.jpg",
              title: "Gnosis Chain"
            )
          }
        )
        
        NavigationLink(
          destination: Text("404 not found"),
          label: {
            ProjectCard(
              imageUrl: "https://pbs.twimg.com/profile_images/1529510825152483330/hb8hQIWP_400x400.jpg",
              title: "Dogechain"
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
