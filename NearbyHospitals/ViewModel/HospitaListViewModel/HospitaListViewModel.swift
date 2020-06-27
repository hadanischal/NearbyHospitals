//
//  HospitaListViewModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol HospitaListDataSource: AnyObject {
    var navigationTitle: Observable<String> { get }
    var numbersOfHospital: Int { get }
    var tableViewHeader: String { get }
    var updateInfo: Observable<Bool> { get }
    func viewDidLoad()
    func hospitals(forIndex index: Int) -> HospitaModel
}

final class HospitaListViewModel: HospitaListDataSource {
    var navigationTitle: Observable<String> { Observable.just(L10n.HospitaList.navigationTitle) }
    var numbersOfHospital: Int { self.hospitalList.count }
    var tableViewHeader: String { L10n.HospitaList.tableViewTitle }
    let updateInfo: Observable<Bool>

    private let disposeBag = DisposeBag()
    private var hospitalList = [HospitaModel]()
    private let hospitalListHandling: HospitalListHandling
    private let levelOfPain: LevelOfPain

    private let updateInfoSubject = PublishSubject<Bool>()

    init(withHospitalListHandling hospitalListHandling: HospitalListHandling = HospitalsNetworking(),
         withLevelOfPain levelOfPain: LevelOfPain) {
        self.hospitalListHandling = hospitalListHandling
        self.levelOfPain = levelOfPain
        self.updateInfo = updateInfoSubject.asObservable()
    }

    func viewDidLoad() {
        hospitalListHandling.getHospitalsInfo()
            .map { ($0?.hospitals ?? []) }
            .compactMap { illnessList -> [HospitaModel] in
                illnessList.map { HospitaModel($0, time: self.waitingTime($0.waitingList)) }
            }
            .subscribe(onNext: { [weak self] result in
                self?.hospitalList = result
                self?.updateInfoSubject.onNext(true)
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
