// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "TensorRT",
    products: [ .library(name: "TensorRT", targets: ["TensorRT"]) ],
    dependencies: [
        .package(url: "git@githb.com:ilmco/Clibcuda.git", .upToNextMinor(from: "9.0.0")),
    ],
    targets: [
        .target(name: "Clibnvinfer", dependencies: []),
        .target(name: "ClibTensorRT", dependencies: ["Clibnvinfer"]),
        .target(name: "TensorRT", dependencies: ["Clibnvinfer", "ClibTensorRT", "Clibcuda"]),
    ],
    cxxLanguageStandard: .cxx11
)
