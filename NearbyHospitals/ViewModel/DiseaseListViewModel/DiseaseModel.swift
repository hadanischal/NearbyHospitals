//
//  DiseaseModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 22/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

struct DiseaseModel: Equatable {
    let name: String
    let id: Int

    init(_ illness: IllnessElement) {
        name = illness.illness.name
        id = illness.illness.id
    }
}
