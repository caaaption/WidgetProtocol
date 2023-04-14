import SwiftUI

public struct QuickNodeBalanceView: View {
  
  let address: String
  let balance: Decimal
  
  public init(
    address: String,
    balance: Decimal
  ) {
    self.address = address
    self.balance = balance
  }
  
  public var body: some View {
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

struct QuickNodeBalanceViewPreviews: PreviewProvider {
  static var previews: some View {
    QuickNodeBalanceView(
      address: "0x4F...De53",
      balance: 1874.08
    )
    .previewLayout(.sizeThatFits)
  }
}
