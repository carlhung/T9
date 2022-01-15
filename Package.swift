// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "T9",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "T9",
            targets: ["T9"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "T9",
            dependencies: [],

            // exclude and resources can be folder.
            // exclude: ["Resources/budget_data.csv"]
            resources: [
                // A process rule: Applies platform specific rules to the resource such as compressing png files. If there are no specific rules for a resource the file is copied to the top-level directory of the bundle. You can specify a directory to have Xcode process the contents. The directory structure is not preserved.
                // .process("Resources/budget_data.csv")
                // A copy rule: Copies files untouched. If you pass a directory the contents are copied preserving the sub-directory structure.
                .copy("Resources"),
                // .copy("Resources/T9.txt")

                // Xcode doesn’t do anything special for csv files so I could have used a copy rule. If we didn’t care about the directory structure we could have also used a single process rule on the Resources directory
                // .process("Resources")
            ]
            ),
        .testTarget(
            name: "T9Tests",
            dependencies: ["T9"]),
    ]
)
