// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CombineKeyboard",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "CombineKeyboard", targets: ["CombineKeyboard"]),
    ],
    targets: [
        .target(name: "CombineKeyboard", path: "CombineKeyboard"),
    ],
    swiftLanguageVersions: [.v5]
)
