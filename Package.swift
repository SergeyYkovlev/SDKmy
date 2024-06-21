// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SDKmy",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_15),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "SDKmy",
            targets: ["SDKmy"]),
    ],
    dependencies: [
        // Здесь можно указать зависимости, если они есть
    ],
    targets: [
        .target(
            name: "SDKmy",
            dependencies: [],
            path: "Sources/SDKmy"
        ),
        .testTarget(
            name: "MySDKOneTests",
            dependencies: ["SDKmy"],
            path: "Tests/SDKmyTests"
        ),
    ]
)
