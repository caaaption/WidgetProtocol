import Foundation
import ComposableArchitecture

extension QuickNodeClient: DependencyKey {
  public static let liveValue = Self.live()

  public static func live() -> Self {
    let baseUrl = Config.baseUrl
    let session = QuickNodeClientSession(baseUrl: baseUrl)
    return Self(
      getBalance: { try await session.getBalance(address: $0) },
      getNfts: { try await session.getNfts(address: $0) }
    )
  }
}

actor QuickNodeClientSession {
  let baseUrl: URL

  init(baseUrl: URL) {
    self.baseUrl = baseUrl
  }
  
  func apiRequest(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
    return try await URLSession.shared.data(for: urlRequest)
  }
  
  func getBalance(address: String) async throws -> Decimal {
    var urlRequest = URLRequest(url: baseUrl)
    urlRequest.httpMethod = "POST"
    urlRequest.allHTTPHeaderFields = [
      "Content-Type": "application/json"
    ]
    urlRequest.httpBody = """
    {
      "method": "eth_getBalance",
      "params": ["\(address)", "latest"],
      "id": 1,
      "jsonrpc": "2.0"
    }
    """.data(using: .utf8)!
    let (data, _) = try await apiRequest(urlRequest: urlRequest)
    let response = try JSONDecoder().decode(BalanceResponse.self, from: data)
    let value = Int(strtoul(response.result, nil, 16))
    return Converter.toEther(wei: value)
  }
  
  func getNfts(address: String) async throws -> [String] {
    var urlRequest = URLRequest(url: baseUrl)
    urlRequest.httpMethod = "POST"
    urlRequest.allHTTPHeaderFields = [
      "Content-Type": "application/json"
    ]
    urlRequest.httpBody = """
    {
      "method": "qn_fetchNFTs",
      "params": [
        "wallet": "\(address)",
      ],
      "id": 1,
      "jsonrpc": "2.0"
    }
    """.data(using: .utf8)!
    let (data, _) = try await apiRequest(urlRequest: urlRequest)
    let response = String(data: data, encoding: .utf8)!
    print(response)
    return []
  }
}

enum Converter {
  static let etherInWei = pow(Decimal(10), 18)
  
  static func toEther(wei: Int) -> Decimal {
    guard let decimalWei = Decimal(string: wei.description) else {
      return 0.0
    }
    return decimalWei / etherInWei
  }
}
