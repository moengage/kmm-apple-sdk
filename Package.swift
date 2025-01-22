// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
// This file generated from post_build script, modify the script instaed of this file.

import PackageDescription

let package = Package(
    name: "kmm-apple-sdk",
    platforms: [.iOS(.v12), .tvOS(.v12)],
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
            .binaryTarget(name: "MoEngageKMMConditionEvaluator", url: "https://github.com/moengage/kmm-apple-sdk/releases/download/0.0.1/MoEngageKMMConditionEvaluator.xcframework.zip", checksum: "171db1cc3c4893eb6452090d890aa9e712a208d149fe2748295e8dbe13230825"),
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

