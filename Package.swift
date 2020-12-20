// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sqnano",
    dependencies: [],
    targets: [
    .target(name: "sqnano", dependencies: ["SQNanoCore"]),
    .target(name: "SQNanoCore", dependencies: []),
    .testTarget(name: "sqnanoTests", dependencies: ["sqnano"]),
    ]
)
