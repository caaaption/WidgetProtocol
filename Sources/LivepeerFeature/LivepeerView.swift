import ComposableArchitecture
import SwiftUI

public struct LivepeerView: View {
  let store: StoreOf<LivepeerReducer>

  public init(store: StoreOf<LivepeerReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        Spacer()
        
        TextField("Id", text: viewStore.binding(\.$id))
        
        Spacer()
        
        Button(action: { viewStore.send(.addWidget) }) {
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
      .padding(.horizontal, 24)
    }
  }
}
