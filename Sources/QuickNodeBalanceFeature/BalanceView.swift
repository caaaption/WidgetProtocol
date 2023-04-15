import ComposableArchitecture
import SwiftUI

public struct BalanceView: View {
  let store: StoreOf<BalanceReducer>
  
  let columns = [
    GridItem(.flexible(), spacing: 20),
    GridItem(.flexible(), spacing: 20),
  ]

  public init(store: StoreOf<BalanceReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 16) {
        
        ScrollView {
          LazyVGrid(columns: columns) {
            ForEach(viewStore.addresses, id: \.self) { address in
              QuickNodeBalanceView(
                address: address,
                balance: 1.0
              )
            }
          }
        }
        
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
      .padding(.horizontal, 24)
      .padding(.bottom, 24)
      .task { await viewStore.send(.task).finish() }
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
