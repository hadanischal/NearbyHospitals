//
//  Page.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 23/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - Page

struct Page: Codable, Equatable {
    let size, totalElements, totalPages, number: Int
}
