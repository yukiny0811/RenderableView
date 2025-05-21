// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RenderableView",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(
            name: "RenderableView",
            targets: ["RenderableView"]
        ),
    ],
    targets: [
        .target(
            name: "RenderableView",
            dependencies: []
        ),
    ]
)
