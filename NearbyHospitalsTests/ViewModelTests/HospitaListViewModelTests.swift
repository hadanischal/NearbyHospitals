//
//  HospitaListViewModelTests.swift
//  NearbyHospitalsTests
//
//  Created by Nischal Hada on 24/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxSwift
import RxTest
import XCTest

@testable import NearbyHospitals

final class HospitaListViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: HospitaListViewModel!
        var mockDiseaseListHandler: MockHospitalListHandling!
        var testScheduler: TestScheduler!
        var mockDiseaseModelList: HospitalEmbedded!

        describe("HospitaListViewModel") {
            beforeEach {
                mockDiseaseModelList = MockData().stubHospitalEmbeddedList()

                testScheduler = TestScheduler(initialClock: 0)

                mockDiseaseListHandler = MockHospitalListHandling()
                stub(mockDiseaseListHandler) { stub in
                    when(stub.getHospitalsInfo()).thenReturn(Observable.empty())
                }

                testViewModel = HospitaListViewModel(withHospitalListHandling: mockDiseaseListHandler, withLevelOfPain: .mild)
            }

            it("sets the titleText correctly") {
                let res = testScheduler.start { testViewModel.navigationTitle.asObservable() }
                expect(res.events.count).to(equal(2))
                let correctResult = [Recorded.next(200, "Hospital List"),
                                     Recorded.completed(200)]
                expect(res.events).to(equal(correctResult))
            }

            it("sets the tableViewHeader correctly") {
                expect(testViewModel.tableViewHeader).to(equal("Our suggested Hospitals:"))
            }

            it("sets the waitingTimeDescription correctly") {
                expect(testViewModel.waitingTimeDescription).to(equal("Waiting time: "))
            }

            context("When server request get succeed") {
                beforeEach {
                    stub(mockDiseaseListHandler) { stub in
                        when(stub.getHospitalsInfo()).thenReturn(Observable.just(mockDiseaseModelList))
                    }
                    testScheduler.scheduleAt(300) {
                        testViewModel.viewDidLoad()
                    }
                    testViewModel.viewDidLoad()
                }
                it("it completed successfully") {
                    verify(mockDiseaseListHandler).getHospitalsInfo()
                }
                it("it sets numbersOfIllness correctly") {
                    expect(testViewModel.numberOfRowsInSection).to(equal(10))
                }
                it("it sets correct hospitalList") {
                    let correctResult = mockDiseaseModelList.hospitals.map { HospitaModel($0, time: waitingTime($0.waitingList)) }
                    expect(testViewModel.hospitalList).to(equal(correctResult))
                }
                it("emits the jobs list to the UI") {
                    let observable = testViewModel.updateInfo.asObservable()
                    let res = testScheduler.start { observable }
                    expect(res.events.count).to(equal(1))
                    let correctResult = [Recorded.next(300, true)]
                    expect(res.events).to(equal(correctResult))
                }

                it("wont emits the errorResult to the UI") {
                    let res = testScheduler.start { testViewModel.errorResult }
                    expect(res.events).toNot(beNil())
                    expect(res.events.count).to(equal(0))
                }

                it("emits the isLoading to the UI") {
                    let res = testScheduler.start { testViewModel.isLoading }
                    expect(res.events.count).to(equal(2))
                    let correctResult = [Recorded.next(200, false), Recorded.next(300, false)]
                    expect(res.events).to(equal(correctResult))
                }
            }

            context("when server request failed for getDiseaseInfo") {
                beforeEach {
                    stub(mockDiseaseListHandler) { stub in
                        when(stub.getHospitalsInfo()).thenReturn(Observable.error(mockError))
                    }
                    testScheduler.scheduleAt(300) {
                        testViewModel.viewDidLoad()
                    }
                    testViewModel.viewDidLoad()
                }
                it("it completed successfully") {
                    verify(mockDiseaseListHandler).getHospitalsInfo()
                }
                it("it sets numbersOfIllness correctly") {
                    expect(testViewModel.numberOfRowsInSection).to(equal(0))
                }
                it("it sets correct hospitalList") {
                    expect(testViewModel.hospitalList).to(equal([]))
                }
                it("doesnt emits jobs list to the UI") {
                    let observable = testViewModel.updateInfo.asObservable()
                    let res = testScheduler.start { observable }
                    expect(res.events).toNot(beNil())
                    expect(res.events.count).to(equal(0))
                }
                it("emits the errorResult to the UI") {
                    let res = testScheduler.start { testViewModel.errorResult.map { $0 as! MockError } }
                    expect(res.events).toNot(beNil())
                    expect(res.events.count).to(equal(1))

                    let correctResult = [Recorded.next(300, mockError)]
                    expect(res.events).to(equal(correctResult))
                }

                it("emits the isLoading to the UI") {
                    let res = testScheduler.start { testViewModel.isLoading }
                    expect(res.events.count).to(equal(2))
                    let correctResult = [Recorded.next(200, false), Recorded.next(300, false)]
                    expect(res.events).to(equal(correctResult))
                }
            }

            context("Get diseaseInfo for index") {
                var mockResponse: [HospitaModel]!
                beforeEach {
                    stub(mockDiseaseListHandler) { stub in
                        when(stub.getHospitalsInfo()).thenReturn(Observable.just(mockDiseaseModelList))
                    }
                    mockResponse = mockDiseaseModelList.hospitals.map { HospitaModel($0, time: waitingTime($0.waitingList)) }
                    testViewModel.viewDidLoad()
                }

                it("it sets numbersOfIllness correctly") {
                    expect(testViewModel.numberOfRowsInSection).to(equal(10))
                }

                it("it sets DiseaseModel correctly") {
                    for item in mockResponse.enumerated() {
                        let (index, mockDiseaseModel) = item
                        expect(testViewModel.hospitals(forIndex: index)).to(equal(mockDiseaseModel))
                    }
                }
            }
        }
    }
}

private func waitingTime(_ waitingList: [WaitingList]) -> Int {
    guard let waitingValue = waitingList.filter({ $0.levelOfPain == LevelOfPain.mild }).first else { return 0 }
    return waitingValue.patientCount * waitingValue.averageProcessTime
}
