//
//  URL+Extensions.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

extension URL {
    static var sourcesUrl: URL? { URL(string: ApiConstant.baseServerURL) }
    static var illnessesUrl: URL? { URL(string: ApiConstant.baseServerURL + ApiConstant.illnesses) }
    static var hospitalsUrl: URL? { URL(string: ApiConstant.baseServerURL + ApiConstant.hospitals) }
}

struct ApiConstant {
    // For server URL
    static let baseServerURL = "https://gist.githubusercontent.com/hadanischal/"
    static let illnesses = "a56692e45fd7f9f146a1b74c42b73fed/raw/0b8a171fe6cf67e6803e252edf4f745409291ca6/illnesses"
    static let hospitals = "683246cd092c701b3564db2b59f6dc51/raw/fd1ebeb0c72984d9832744936b2720855d87774c/hospitals"
}
