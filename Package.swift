// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Sync",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "Sync", targets: ["Sync"]),
    ],
    dependencies: [
        .package(url: "https://github.com/foxterm/libetos.git", branch: "main"),
        .package(url: "https://github.com/foxterm/Extension.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Sync",
            dependencies: [
                .product(name: "libetos", package: "libetos"),
                .product(name: "Extension", package: "Extension"),
            ]
        ),
    ]
)
