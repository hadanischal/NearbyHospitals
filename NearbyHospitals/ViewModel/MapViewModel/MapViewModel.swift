//
//  HospitaListViewModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol MapDataSource: AnyObject {
    var navigationTitle: Observable<String> { get }
    var initialLocation: Location? { get }
    var mapInfoList: [MapModel] { get }
    func viewDidLoad()
}

final class MapViewModel: MapDataSource {
    var navigationTitle: Observable<String> { Observable.just(L10n.HospitaList.navigationTitle) }
    var mapInfoList: [MapModel] = []
    var initialLocation: Location?

    private var hospitalList = [HospitaModel]()

    init(withHospitaModel list: [HospitaModel], initialLocation: Location? = nil) {
        self.hospitalList = list
        self.initialLocation = initialLocation ?? hospitalList.first.map { $0.location }
    }

    func viewDidLoad() {
        mapInfoList = hospitalList.map {
            MapModel(title: $0.name,
                     locationName: $0.name,
                     latitude: $0.location.lat,
                     longitude: $0.location.lng)
        }
    }
}
