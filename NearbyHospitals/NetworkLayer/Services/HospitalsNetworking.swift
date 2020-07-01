//
//  HospitalsNetworking.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol DiseaseListHandling {
    func getDiseaseInfo() -> Observable<IllnessEmbedded>
}

protocol HospitalListHandling {
    func getHospitalsInfo() -> Observable<HospitalEmbedded>
}

typealias HospitalsNetwork = DiseaseListHandling & HospitalListHandling

final class HospitalsNetworking: HospitalsNetwork {
    private let webService: WebServiceProtocol

    init(withWebService webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }

    func getDiseaseInfo() -> Observable<IllnessEmbedded> {
        guard let url = URL.illnessesUrl else { return Observable<IllnessEmbedded>.error(NetworkError.badURL) }
        var res: Resource<IllnessListModel> { Resource(url: url) }

        return webService.load(resource: res)
            .map(\.embedded)
            .asObservable()
            .retry(2)
    }

    func getHospitalsInfo() -> Observable<HospitalEmbedded> {
        guard let url = URL.hospitalsUrl else { return Observable<HospitalEmbedded>.error(NetworkError.badURL) }

        var res: Resource<HospitalListModel> { Resource(url: url) }
        return webService.load(resource: res)
            .map(\.embedded)
            .asObservable()
            .retry(2)
    }
}
