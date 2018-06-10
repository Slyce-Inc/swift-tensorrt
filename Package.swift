// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "libnvinfer",
    products: [ .library(name: "NvInfer", targets: ["NvInfer"]) ],
    dependencies: [],
    targets: [
        .target(name: "libnvinfer", dependencies: []),
        .target(name: "NvInfer", dependencies: ["libnvinfer"]),
    ],
    cxxLanguageStandard: .cxx11
)
