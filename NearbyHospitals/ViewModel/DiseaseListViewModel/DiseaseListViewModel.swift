//
//  DiseaseListViewModel.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol DiseaseListDataSource: BaseViewModelProtocol {
    var navigationTitle: Observable<String> { get }
    var numbersOfIllness: Int { get }
    var tableViewHeader: String { get }

    func viewDidLoad()
    func diseaseInfo(forIndex index: Int) -> DiseaseModel
}

final class DiseaseListViewModel: DiseaseListDataSource {
    var navigationTitle: Observable<String> { Observable.just(L10n.DiseaseList.navigationTitle) }
    var tableViewHeader: String { L10n.DiseaseList.tableViewTitle }

    var numbersOfIllness: Int { self.diseaseList.count }

    let updateInfo: Observable<Bool>
    let errorResult: Observable<Error>
    let isLoading: Observable<Bool>

    private let disposeBag = DisposeBag()
    private var diseaseList = [DiseaseModel]()
    private let diseaseListHandler: DiseaseListHandling

    private let updateInfoSubject = PublishSubject<Bool>()
    private let errorResultSubject = PublishSubject<Error>()
    private let loadingSubject = BehaviorSubject<Bool>(value: true)

    init(withDiseaseListHandling diseaseListHandler: DiseaseListHandling = HospitalsNetworking()) {
        self.diseaseListHandler = diseaseListHandler

        self.updateInfo = updateInfoSubject.asObservable()
        self.errorResult = errorResultSubject.asObservable()
        self.isLoading = loadingSubject.asObservable()
    }

    func viewDidLoad() {
        diseaseListHandler
            .getDiseaseInfo()
            .map(\.illnesses)
            .compactMap { illnessList -> [DiseaseModel] in
                illnessList.map { DiseaseModel($0) }
        }
        .subscribe(onNext: { [weak self] result in
            self?.diseaseList = result
            self?.updateInfoSubject.onNext(true)
            self?.loadingSubject.onNext(false)
            }, onError: { [weak self] error in

                self?.errorResultSubject.on(.next(error))
                self?.loadingSubject.onNext(false)

        })
        .disposed(by: disposeBag)
    }

    func diseaseInfo(forIndex index: Int) -> DiseaseModel {
        self.diseaseList[index]
    }
}
