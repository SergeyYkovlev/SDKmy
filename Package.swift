// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SDKmyy",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_15),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "SDKmyy",
            targets: ["SDKmyy"]),
    ],
    dependencies: [
        // Здесь можно указать зависимости, если они есть
    ],
    targets: [
        .target(
            name: "SDKmyy",
            dependencies: [],
            path: "Sources/SDKmyy"
        ),
        .testTarget(
            name: "MySDKOneTests",
            dependencies: ["SDKmyy"],
            path: "Tests/SDKmyyTests"
        ),
    ]
)
