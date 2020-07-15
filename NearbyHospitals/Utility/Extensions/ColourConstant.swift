//
//  ColourConstant.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

extension UIColor {
    static var primary: UIColor {
        return ColorName.primary.color
    }

    static var viewBackgroundColor: UIColor {
        return Asset.ColorsAssets.viewBackgroundColor.color
    }

    static var titleColor: UIColor {
        return Asset.ColorsAssets.titleColor.color
    }

    static var descriptionColor: UIColor {
        return Asset.ColorsAssets.descriptionColor.color
    }

    static var buttonBaground: UIColor {
        return ColorName.darkRed.color
    }

    static var barTintColor: UIColor {
        return ColorName.primary.color
    }

    static var titleTintColor: UIColor {
        return UIColor.white
    }

    static var dimBlackColor: UIColor {
        return ColorName.dimBlackColor.color
    }

    static var coral: UIColor {
        return ColorName.coral.color
    }

    static var segmentSelectedTitle: UIColor {
        return UIColor.black
    }

    static var segmentDefaultTitle: UIColor {
        return UIColor.darkGray
    }

    static var segmentIndicator: UIColor {
        return ColorName.orange.color
    }

    static var segmentSeparator: UIColor {
        return ColorName.lightSilver.color
    }

    static var cellBorderColor: UIColor {
        return ColorName.lightSilver.color
    }

    static var statusColor: UIColor {
        return ColorName.turquoiseSurf.color
    }

    static var onboardingTitleColor: UIColor {
        return ColorName.onboardingRed.color
    }
}
