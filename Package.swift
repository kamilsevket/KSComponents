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
        .executableTarget(
            name: "KSComponentsDemo",
            dependencies: ["KSComponents"],
            path: "Examples/KSComponentsDemo"
        ),
        .testTarget(
            name: "KSComponentsTests",
            dependencies: ["KSComponents"]
        ),
    ]
)
