// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WRLDSCore",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WRLDSCore",
            targets: ["WRLDSCore"]),
    ],
    dependencies: [
        .package(
            name: "SDWebImage",
            url: "https://github.com/SDWebImage/SDWebImage.git",
            from: "5.1.0"),
        .package(name: "Lottie",
                 url: "https://github.com/airbnb/lottie-ios.git",
                 from: "3.1.2")
    ],
    targets: [
    
        .target(
            name: "WRLDSCore",
            dependencies: ["SDWebImage", "Lottie"],
            resources: [
                .process("WRLDSCore/Resources/loader.json"),
                .process("WRLDSCore/Resources/cellLoader.json")
            ]),

        .testTarget(
            name: "WRLDSCoreTests",
            dependencies: ["WRLDSCore"]),
    ]
)
