import ComposableArchitecture
import SwiftUI

public struct LensLinkView: View {
  let store: StoreOf<LensLinkReducer>

  public init(store: StoreOf<LensLinkReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        Spacer()
        
        TextField("Username", text: viewStore.binding(\.$username))
        
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
