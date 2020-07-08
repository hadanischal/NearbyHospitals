//
//  HospitaModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 22/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Contacts
import Foundation
import MapKit

final class MapModel: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D

    init(
        title: String?,
        locationName: String?,
        latitude: Double, longitude: Double
    ) {
        self.title = title
        self.locationName = locationName
        self.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                 longitude: longitude)
        super.init()
    }

    var subtitle: String? { locationName }

    var mapItem: MKMapItem? {
        guard let location = self.locationName else { return nil }

        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: addressDict
        )
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }

    var markerTintColor: UIColor { markerTintColorList.randomElement() ?? .red }

    var annotationImage: ImageAsset { imageList.randomElement() ?? Asset.Icons.flag }
}

private let markerTintColorList: [UIColor] = { [.red, .cyan, .blue, .purple, .green] }()

private let imageList: [ImageAsset] = { [Asset.Icons.flag,
                                         Asset.Icons.map,
                                         Asset.Icons.monument,
                                         Asset.Icons.mural,
                                         Asset.Icons.plaque,
                                         Asset.Icons.sculpture] }()
