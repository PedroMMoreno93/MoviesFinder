// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MVVM_Core",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),
        .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MVVM_Core",
            targets: ["MVVM_Core"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MVVM_Core"),
        .testTarget(
            name: "MVVMCoreTests",
            dependencies: ["MVVM_Core"]
        )
    ]
)
