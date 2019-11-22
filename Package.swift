// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "TensorRT",
    products: [ .library(name: "TensorRT", targets: ["TensorRT"]) ],
    dependencies: [
        .package(url: "git@github.com:Slyce-Inc/swift-cuda.git", .upToNextMinor(from: "1.0.0")),
    ],
    targets: [
        .target(name: "Clibnvinfer", dependencies: []),
        .target(name: "ClibTensorRT", dependencies: ["Clibnvinfer", "Clibcudart"]),
        .target(name: "TensorRT", dependencies: ["ClibTensorRT"]),
    ],
    cxxLanguageStandard: .cxx11
)
