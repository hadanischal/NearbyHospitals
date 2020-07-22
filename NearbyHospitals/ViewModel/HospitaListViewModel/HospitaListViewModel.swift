//
//  HospitaListViewModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol HospitaListDataSource: BaseViewModelProtocol {
    var navigationTitle: Observable<String> { get }
    var numberOfRowsInSection: Int { get }
    var tableViewHeader: String { get }
    var waitingTimeDescription: String { get }
    var hospitalList: [HospitaModel] { get }
    func hospitals(forIndex index: Int) -> HospitaModel
}

final class HospitaListViewModel: HospitaListDataSource {
    var navigationTitle: Observable<String> { Observable.just(L10n.HospitaList.navigationTitle) }
    var numberOfRowsInSection: Int { hospitalList.count }
    var tableViewHeader: String { L10n.HospitaList.tableViewTitle }
    var waitingTimeDescription: String { L10n.HospitaList.waitingTime }

    var hospitalList = [HospitaModel]()

    let updateInfo: Observable<Bool>
    let errorResult: Observable<Error>
    let isLoading: Observable<Bool>

    private let disposeBag = DisposeBag()
    private let hospitalListHandling: HospitalListHandling
    private let levelOfPain: LevelOfPain

    private let updateInfoSubject = PublishSubject<Bool>()
    private let errorResultSubject = PublishSubject<Error>()
    private let loadingSubject = BehaviorSubject<Bool>(value: true)

    init(withHospitalListHandling hospitalListHandling: HospitalListHandling = HospitalsNetworking(),
         withLevelOfPain levelOfPain: LevelOfPain) {
        self.hospitalListHandling = hospitalListHandling
        self.levelOfPain = levelOfPain

        self.updateInfo = updateInfoSubject.asObservable()
        self.errorResult = errorResultSubject.asObservable()
        self.isLoading = loadingSubject.asObservable()
    }

    func viewDidLoad() {
        hospitalListHandling
            .getHospitalsInfo()
            .map(\.hospitals)
            .compactMap { illnessList -> [HospitaModel] in
                illnessList.map { HospitaModel($0, time: self.waitingTime($0.waitingList)) }
        }
        .subscribe(onNext: { [weak self] result in
            self?.hospitalList = result
            self?.updateInfoSubject.onNext(true)
            self?.loadingSubject.onNext(false)
            }, onError: { [weak self] error in

                self?.errorResultSubject.on(.next(error))
                self?.loadingSubject.onNext(false)

        })
        .disposed(by: disposeBag)
    }

    func hospitals(forIndex index: Int) -> HospitaModel {
        return self.hospitalList[index]
    }

    /// Calculate waiting times based on the patient’s level of pain and hospitals average process times
    /// - Parameter waitingList: list of waiting time
    /// - Returns: 'patientCount' * 'averageProcessTime'
    private func waitingTime(_ waitingList: [WaitingList]) -> Int {
        guard let waitingValue = waitingList.filter({ $0.levelOfPain == levelOfPain }).first else { return 0 }
        return waitingValue.patientCount * waitingValue.averageProcessTime
    }
}
