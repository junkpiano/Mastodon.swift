// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Mastodon",
    products: [
        .library(
            name: "Mastodon",
            targets: ["Mastodon"]),
    ],
    dependencies: [
        .package(url: "https://github.com/junkpiano/Kiri.git", from: "1.0.2")
    ],
    targets: [
        .target(
            name: "Mastodon",
            dependencies: ["Kiri"]),
        .testTarget(
            name: "MastodonTests",
            dependencies: ["Mastodon"]),
    ]
)
