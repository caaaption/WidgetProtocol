import Foundation
import ComposableArchitecture

extension PushClient: DependencyKey {
  public static let liveValue = Self.live()
  public static func live() -> Self {
    let baseUrl = URL(string: "https://asia-northeast1-widgetprotocol.cloudfunctions.net")!
    let session = PushClientSession(baseURL: baseUrl)
    return Self(
      getNotifications: { try await session.getNotifications(address: $0) }
    )
  }
}

actor PushClientSession {
  let baseURL: URL
  init(baseURL: URL) {
    self.baseURL = baseURL
  }
  
  func apiRequest(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
    return try await URLSession.shared.data(for: urlRequest)
  }
  
  func getNotifications(address: String) async throws -> [Notification] {
    let url = URL(string: baseURL.absoluteString + "/api/notifications/\(address)")!
    var urlRequest = URLRequest(url: url)
    urlRequest.allHTTPHeaderFields = [
      "Content-Type": "application/json"
    ]
    let (data, _) = try await apiRequest(urlRequest: urlRequest)
    print(String(data: data, encoding: .utf8)!)
    let response = try JSONDecoder().decode([Notification].self, from: data)
    return response
  }
}
