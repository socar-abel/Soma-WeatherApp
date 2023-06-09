//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김상우 on 2023/03/31.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Data",
    product: .staticFramework,
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .external(name: "Moya"),
        .external(name: "RxMoya")
    ],
    resources: ["Resources/**"]
)
