// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponents",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),
        .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UIComponents",
            targets: ["UIComponents"])
    ],
    dependencies: [
        .package(
            name: "Theme",
            path: "../Theme"
        ),
        .package(
            name: "Utils",
            path: "../Utils"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UIComponents",
            dependencies: [
                .product(
                    name: "Theme",
                    package: "Theme"
                ),
                .product(
                    name: "UIUtils",
                    package: "Utils"
                )
            ]
        ),
        .testTarget(
            name: "UIComponentsTests",
            dependencies: ["UIComponents"]
        )
    ]
)
