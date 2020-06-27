//
//  HospitaModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 22/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

struct HospitaModel: Equatable {
    let name: String
    let id: Int
    let lat, lng: Double
    let waitingTime: Int
    let description: String

    init(_ hospital: Hospital, time: Int) {
        name = hospital.name
        id = hospital.id
        lat = hospital.location.lat
        lng = hospital.location.lng
        waitingTime = time
        description = L10n.HospitaList.averageTime(time)
    }
}
