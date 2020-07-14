//
//  ArtworkView.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 1/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import MapKit

final class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let mapInfo = newValue as? MapModel else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            // 2
            markerTintColor = mapInfo.markerTintColor
            glyphImage = mapInfo.annotationImage.image
        }
    }
}

final class ArtworkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? MapModel else { return }

            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            rightCalloutAccessoryView = mapsButton

            image = artwork.annotationImage.image

            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = artwork.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
