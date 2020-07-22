//
//  SeverityLevelViewModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol SeverityLevelDataSource: AnyObject {
    var navigationTitle: Observable<String> { get }
    var numberOfRowsInSection: Int { get }
    var collectionViewHeader: String { get }
    func severity(forIndex index: Int) -> LevelOfPain
}

final class SeverityLevelViewModel: SeverityLevelDataSource {

    var navigationTitle: Observable<String> { Observable.just(L10n.SeverityLevel.navigationTitle) }
    var collectionViewHeader: String { L10n.SeverityLevel.collectionviewViewTitle }
    var numberOfRowsInSection: Int { illnessesList.count }

    private var illnessesList: [LevelOfPain] { LevelOfPain.allCases }

    func severity(forIndex index: Int) -> LevelOfPain {
        self.illnessesList[index]
    }
}
