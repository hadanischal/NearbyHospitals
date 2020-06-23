//
//  levelOfPain.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 22/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

enum LevelOfPain: Int, Codable, CaseIterable {
    case mild = 0 /// No Pain
    case discomforting = 1 /// Hurt a Little
    case distressing = 2 /// Hurt a Little more
    case horrible = 3 /// Hurt Even more
    case excruciating = 4 /// Hurt Even more
}

extension LevelOfPain {
    var image: ImageAsset {
        switch self {
        case .mild:
            return Asset.Icons.illnessNoPain0
        case .discomforting:
            return Asset.Icons.illnessHurtLittle1
        case .distressing:
            return Asset.Icons.illnessHurtMore2
        case .horrible:
            return Asset.Icons.illnessHurtEvenMore3
        case .excruciating:
            return Asset.Icons.illnessHurtAlotmore4
        }
    }
}
