//
//  String+Extension.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 1/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

extension Int {
    var dayHourMinute: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .full
        // number * 60 to convert min to seconds
        let formattedString = formatter.string(from: TimeInterval(self * 60))!
        return formattedString
    }
}
