#!/usr/bin/ruby

# Usage:
# Update Package.swift file according to package.json

require 'fileutils'
require 'json'
require 'ostruct'

config = JSON.parse(File.read('package.json'), {object_class: OpenStruct})

def package_for_pod(podspec, config)
  package_index = config.packages.find_index { |package| package.name == podspec }
  config.packages[package_index]
end

kmm_ce_package = package_for_pod('MoEngageKMMConditionEvaluator', config)

package_swift = <<PACKAGE
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
            .binaryTarget(name: "MoEngageKMMConditionEvaluator", url: "https://github.com/moengage/kmm-apple-sdk/releases/download/#{kmm_ce_package.version}/MoEngageKMMConditionEvaluator.xcframework.zip", checksum: "#{kmm_ce_package[:hash]}"),
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

PACKAGE

File.open('Package.swift', 'w') do |file|
  file.write(package_swift)
end
