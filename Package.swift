// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "YQLineView",
    platforms: [
        // 与 CocoaPods 配置保持一致，避免提高现有使用方的最低系统版本。
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "YQLineView",
            targets: ["YQLineView"]
        )
    ],
    targets: [
        .target(
            name: "YQLineView",
            path: "YQLineView/Classes"
        ),
        .testTarget(
            name: "YQLineViewTests",
            dependencies: ["YQLineView"],
            path: "Tests/YQLineViewTests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
