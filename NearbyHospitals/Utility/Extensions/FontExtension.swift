//
//  FontExtension.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

extension UIFont {
    class func boldFont(size: CGFloat) -> UIFont {
        return UIFont(font: FontFamily.SourceSansPro.bold, size: size)
    }

    class func regularFont(size: CGFloat) -> UIFont {
        return UIFont(font: FontFamily.SourceSansPro.regular, size: size)
    }

    class func lightFont(size: CGFloat) -> UIFont {
        return UIFont(font: FontFamily.SourceSansPro.light, size: size)
    }

    class func kittenSwashFont(size: CGFloat) -> UIFont {
        return UIFont(font: FontFamily.KittenSwash.regular, size: size)
    }
}

extension UIFont {
    static var navigationBarTitle: UIFont {
        return .kittenSwashFont(size: 22)
    }

    static var navigationBarButtonItem: UIFont {
        return .lightFont(size: 20)
    }

    static var titleFont: UIFont {
        return .boldFont(size: 36)
    }

    static var descriptionFont: UIFont {
        return .regularFont(size: 14)
    }

    static var backgroundLabel: UIFont {
        return .kittenSwashFont(size: 34)
    }

    static var heading1: UIFont {
        return .boldFont(size: 25)
    }

    static var heading2: UIFont {
        return .boldFont(size: 20)
    }

    static var body1: UIFont {
        return .regularFont(size: 20)
    }

    static var body2: UIFont {
        return .lightFont(size: 22)
    }

    static var body3: UIFont {
        return .lightFont(size: 18)
    }

    static var detailTitle: UIFont {
        return .regularFont(size: 18)
    }

    static var detailBody: UIFont {
        return .lightFont(size: 16)
    }

    static var segmentTitle: UIFont {
        return .regularFont(size: 17)
    }

    static var statusTitle: UIFont {
        return .boldFont(size: 16)
    }

    static var buttonFont: UIFont {
        return .boldFont(size: 24)
    }

    static var textButton: UIFont {
        return .regularFont(size: 17)
    }

    static var floatingLabelTitle: UIFont {
        return .lightFont(size: 15)
    }

    static var onboardingTitle: UIFont {
        return .kittenSwashFont(size: 20)
    }

    static var tabBarItemnFont: UIFont {
        return .kittenSwashFont(size: 13)
    }
}
