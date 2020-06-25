//
//  CustomViewExtension.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

extension UIView {
    func roundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }

    // Draw shadow to view
    func drawShadow(offset: CGSize, radius: CGFloat, opacity: Float) {
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }

    // Draw shadow to view
    func drawShadowOrange(offset: CGSize, radius: CGFloat, opacity: Float) {
        layer.shadowColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}
