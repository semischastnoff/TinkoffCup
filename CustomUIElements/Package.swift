// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CustomUIElements",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "CustomUIElements",
            targets: ["CustomUIElements"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CustomUIElements",
            dependencies: []),
        .testTarget(
            name: "CustomUIElementsTests",
            dependencies: ["CustomUIElements"]),
    ]
)
