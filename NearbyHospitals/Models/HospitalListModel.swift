//
//  HospitalListModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - HospitalListModel

struct HospitalListModel: Codable {
    let embedded: HospitalEmbedded
    let links: Links
    let page: Page

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
        case page
    }
}

// MARK: - HospitalEmbedded

struct HospitalEmbedded: Codable, Equatable {
    let hospitals: [Hospital]
}

// MARK: - Hospital

struct Hospital: Codable, Equatable {
    let id: Int
    let name: String
    let waitingList: [WaitingList]
    let location: Location
}

// MARK: - Location

struct Location: Codable, Equatable {
    let lat, lng: Double
}

// MARK: - WaitingList

struct WaitingList: Codable, Equatable {
    let levelOfPain: LevelOfPain
    let patientCount, averageProcessTime: Int
}

// MARK: - Links

struct Links: Codable, Equatable {
    let linksSelf, next: Next

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case next
    }
}
