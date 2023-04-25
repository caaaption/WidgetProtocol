import ProgressAsyncImage
import ComposableArchitecture
import SwiftUI

public struct ContributorView: View {
  let store: StoreOf<ContributorReducer>

  public init(store: StoreOf<ContributorReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(viewStore.contributors) { contributor in
        HStack(alignment: .center, spacing: 12) {
          ProgressAsyncImage(contributor.avatarUrl) {
            $0.frame(width: 44, height: 44)
              .cornerRadius(22)
          }
          
          Text(contributor.login)
            .bold()
        }
        .frame(height: 68)
      }
      .navigationTitle("Contributors")
    }
  }
}
