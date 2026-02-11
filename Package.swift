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
            .binaryTarget(name: "MoEngageKMMConditionEvaluator", url: "https://github.com/moengage/kmm-apple-sdk/releases/download/kmmce-1.0.1/MoEngageKMMConditionEvaluator.xcframework.zip", checksum: "f10293e1b5ce459de29a9440e4f39befc32a4b5f64c94db4c5b9b087039ebabc"),
            .target(name: "MoEngageKMMConditionEvaluatorSPM")
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

