// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
  name: "WidgetProtocol",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "EmptyWidget", targets: ["EmptyWidget"]),
    .library(name: "ProgressAsyncImage", targets: ["ProgressAsyncImage"]),
    .library(name: "ProjectFeature", targets: ["ProjectFeature"]),
    .library(name: "ProjectListFeature", targets: ["ProjectListFeature"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.51.0"),
  ],
  targets: [
    .target(name: "ProgressAsyncImage"),
    .target(name: "EmptyWidget"),
    .target(name: "AppFeature", dependencies: [
      "ProjectListFeature",
    ]),
    .target(name: "ProjectListFeature", dependencies: [
      "ProjectFeature",
      "QuickNodeBalanceFeature",
    ]),
    .target(name: "ProjectFeature", dependencies: [
      "ProgressAsyncImage",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
)

package.products.append(contentsOf: [
  .library(name: "QuickNodeClient", targets: ["QuickNodeClient"]),
  .library(name: "QuickNodeBalanceFeature", targets: ["QuickNodeBalanceFeature"]),
])
package.targets.append(contentsOf: [
  .target(name: "QuickNodeClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "QuickNodeBalanceFeature", dependencies: [
    "UserDefaultsClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])

package.products.append(contentsOf: [
  .library(name: "UserDefaultsClient", targets: ["UserDefaultsClient"]),
])

package.targets.append(contentsOf: [
  .target(name: "UserDefaultsClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])
