//
//  BaseViewModelProtocol.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 19/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModelProtocol: AnyObject {
    var updateInfo: Observable<Bool> { get }
    var errorResult: Observable<Error> { get }
    var isLoading: Observable<Bool> { get }

    func viewDidLoad()
}
