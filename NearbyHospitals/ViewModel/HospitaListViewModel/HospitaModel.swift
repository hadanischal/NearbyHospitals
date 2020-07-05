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
    let location: Location
    let waitingTime: String

    init(_ hospital: Hospital, time: Int) {
        name = hospital.name
        id = hospital.id
        location = hospital.location
        waitingTime = time.dayHourMinute
    }
}
