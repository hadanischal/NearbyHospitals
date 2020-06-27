//
//  IllnessListModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - IllnessListModel

struct IllnessListModel: Codable {
    let embedded: IllnessEmbedded
    let links: IllnessListModelLinks
    let page: Page

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
        case page
    }
}

// MARK: - IllnessEmbedded

struct IllnessEmbedded: Codable, Equatable {
    let illnesses: [IllnessElement]
}

// MARK: - IllnessElement

struct IllnessElement: Codable, Equatable {
    let illness: IllnessIllness
    let links: IllnessLinks

    enum CodingKeys: String, CodingKey {
        case illness
        case links = "_links"
    }
}

// MARK: - IllnessIllness

struct IllnessIllness: Codable, Equatable {
    let name: String
    let id: Int
}

// MARK: - IllnessLinks

struct IllnessLinks: Codable, Equatable {
    let illnesses, linksSelf: Next

    enum CodingKeys: String, CodingKey {
        case illnesses
        case linksSelf = "self"
    }
}

// MARK: - IllnessListModelLinks

struct IllnessListModelLinks: Codable, Equatable {
    let linksSelf, next: Next

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case next
    }
}
