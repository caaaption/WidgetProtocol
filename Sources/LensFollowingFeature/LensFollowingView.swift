import ComposableArchitecture
import SwiftUI

public struct LensFollowingView: View {
  let store: StoreOf<LensFollowingReducer>

  public init(store: StoreOf<LensFollowingReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        Spacer()
        
        TextField("Address", text: viewStore.binding(\.$address))
        
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
