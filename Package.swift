// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
// This file generated from post_build script, modify the script instaed of this file.

import PackageDescription

let package = Package(
    name: "kmm-apple-sdk",
    platforms: [.iOS(.v11), .tvOS(.v11)],
    products: [], dependencies: [], targets: [],
    swiftLanguageVersions: [.v5]
)

struct MoEngagePackageProduct {
    let name: String
    let targets: [Target]
}

let products: [MoEngagePackageProduct] = [
    .init(
        name: "MoEngageKMMConditionEvaluator",
        targets: [
            .binaryTarget(name: "MoEngageKMMConditionEvaluator", url: "https://github.com/moengage/kmm-apple-sdk/releases/download/1.0.0/MoEngageKMMConditionEvaluator.xcframework.zip", checksum: "16fb97f6c5973c6daed338307e717427aad470ea9e913252b3de5f9a1e209485"),
        ]
    ),
]

for product in products {
    for target in product.targets {
        package.targets.append(target)
    }
    package.products.append(
        .library(name: product.name, targets: product.targets.map { $0.name })
    )
}

