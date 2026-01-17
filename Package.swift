// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KSComponents",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "KSComponents",
            targets: ["KSComponents"]
        ),
    ],
    targets: [
        .target(
            name: "KSComponents",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "KSComponentsTests",
            dependencies: ["KSComponents"]
        ),
    ]
)
