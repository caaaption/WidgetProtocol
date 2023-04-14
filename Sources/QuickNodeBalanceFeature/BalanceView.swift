import ComposableArchitecture
import SwiftUI

public struct BalanceView: View {
  let store: StoreOf<BalanceReducer>

  public init(store: StoreOf<BalanceReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 8) {
        QuickNodeBalanceView(
          address: viewStore.address,
          balance: 0.9
        )
        
        Spacer()
        
        TextField(
          "address",
          text: viewStore.binding(\.$address)
        )
        
        Button(action: { viewStore.send(.addWidget) }) {
          Image(systemName: "plus.circle.fill")
            .tint(Color.white)
          Text("Add Widget")
            .bold()
            .foregroundColor(Color.white)
        }
        .disabled(viewStore.address.isEmpty)
        .frame(height: 50, alignment: .center)
        .frame(maxWidth: CGFloat.infinity)
        .background(viewStore.address.isEmpty ? Color.gray : Color.blue)
        .cornerRadius(50 / 2)
      }
      .padding(.top, 21)
      .padding(.horizontal, 24)
    }
  }
}

struct BalanceViewPreviews: PreviewProvider {
  static var previews: some View {
    BalanceView(
      store: .init(
        initialState: BalanceReducer.State(),
        reducer: BalanceReducer()
      )
    )
  }
}
