import SwiftUI

struct BalanceWidgetView: View {
  let address: String
  let balance: Decimal
  
  var body: some View {
    VStack {
      Text("Balance")
        .font(.headline)
      Text(address.prefix(8) + "...")
      Text(balance.description.prefix(6) + "ETH")
        .font(.title2)
        .bold()
        .foregroundColor(.blue)
    }
  }
}
