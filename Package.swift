// swift-tools-version:4.0
//
// Package.swift
// RomeKit
//
// Created by Yehor Popovych on 22/09/2017.
// Copyright © 2017 Yehor Popovych. All rights reserved.
//
import PackageDescription

let package = Package(
    name: "RomeKit",
    products: [
        .library(name: "RomeKit", targets: ["RomeKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.7.3"),
        .package(url: "https://github.com/Hearst-DD/ObjectMapper.git", from: "3.4.0")
    ],
    targets: [
        .target(name: "RomeKit", dependencies: ["Alamofire", "ObjectMapper"]),
        .testTarget(name: "RomeKitTests", dependencies: ["RomeKit"])
    ]
)
