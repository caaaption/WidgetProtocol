import ComposableArchitecture
import SwiftUI

public struct ProjectView: View {
  let store: StoreOf<ProjectReducer>

  public init(store: StoreOf<ProjectReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
      VStack {
        ProjectHeader()
        Spacer()
        
        Button(action: {}) {
          Image(systemName: "plus.circle.fill")
            .tint(Color.white)
          Text("Add Widget")
            .bold()
            .foregroundColor(Color.white)
        }
        .frame(height: 50, alignment: .center)
        .frame(maxWidth: CGFloat.infinity)
        .background(Color.blue)
        .cornerRadius(50 / 2)
      }
      .padding(.top, 21)
      .padding(.horizontal, 24)
    }
  }
}

struct ProjectViewPreviews: PreviewProvider {
  static var previews: some View {
    ProjectView(
      store: .init(
        initialState: ProjectReducer.State(),
        reducer: ProjectReducer()
      )
    )
  }
}
