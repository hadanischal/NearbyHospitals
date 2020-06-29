//
//  DiseaseListViewModelTests.swift
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

final class DiseaseListViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: DiseaseListViewModel!
        var mockDiseaseListHandler: MockDiseaseListHandling!
        var testScheduler: TestScheduler!
        var mockDiseaseModelList: IllnessEmbedded!

        describe("DiseaseListViewModel") {
            beforeEach {
                mockDiseaseModelList = MockData().stubIllnessEmbeddedList()

                testScheduler = TestScheduler(initialClock: 0)

                mockDiseaseListHandler = MockDiseaseListHandling()
                stub(mockDiseaseListHandler) { stub in
                    when(stub.getDiseaseInfo()).thenReturn(Observable.empty())
                }

                testViewModel = DiseaseListViewModel(withDiseaseListHandling: mockDiseaseListHandler)
            }

            it("sets the titleText correctly") {
                let res = testScheduler.start { testViewModel.navigationTitle.asObservable() }
                expect(res.events.count).to(equal(2))
                let correctResult = [Recorded.next(200, "Disease List"),
                                     Recorded.completed(200)]
                expect(res.events).to(equal(correctResult))
            }

            it("sets the tableViewHeader correctly") {
                expect(testViewModel.tableViewHeader).to(equal("Select an illness:"))
            }

            context("When server request get succeed") {
                beforeEach {
                    stub(mockDiseaseListHandler) { stub in
                        when(stub.getDiseaseInfo()).thenReturn(Observable.just(mockDiseaseModelList))
                    }

                    testScheduler.scheduleAt(300) {
                        testViewModel.viewDidLoad()
                    }
                    testViewModel.viewDidLoad()
                }
                it("it completed successfully") {
                    verify(mockDiseaseListHandler).getDiseaseInfo()
                }
                it("it sets numbersOfIllness correctly") {
                    expect(testViewModel.numbersOfIllness).to(equal(10))
                }

                it("emits the jobs list to the UI") {
                    let observable = testViewModel.updateInfo.asObservable()
                    let res = testScheduler.start { observable }
                    expect(res.events.count).to(equal(1))
                    let correctResult = [Recorded.next(300, true)]
                    expect(res.events).to(equal(correctResult))
                }
            }

            context("when server request failed for getDiseaseInfo") {
                beforeEach {
                    stub(mockDiseaseListHandler) { stub in
                        when(stub.getDiseaseInfo()).thenReturn(Observable.error(mockError))
                    }
                    testScheduler.scheduleAt(300) {
                        testViewModel.viewDidLoad()
                    }
                    testViewModel.viewDidLoad()
                }
                it("it completed successfully") {
                    verify(mockDiseaseListHandler).getDiseaseInfo()
                }
                it("it sets numbersOfIllness correctly") {
                    expect(testViewModel.numbersOfIllness).to(equal(0))
                }
                it("doesnt emits jobs list to the UI") {
                    testScheduler.scheduleAt(200) {
                        testViewModel.viewDidLoad()
                    }
                    let observable = testViewModel.updateInfo.asObservable()
                    let res = testScheduler.start { observable }
                    expect(res.events).toNot(beNil())
                    expect(res.events.count).to(equal(0))
                }
            }

            context("Get diseaseInfo for index") {
                var mockResponse: [DiseaseModel]!
                beforeEach {
                    stub(mockDiseaseListHandler) { stub in
                        when(stub.getDiseaseInfo()).thenReturn(Observable.just(mockDiseaseModelList))
                    }
                    mockResponse = mockDiseaseModelList.illnesses.map { DiseaseModel($0) }
                    testViewModel.viewDidLoad()
                }

                it("it sets numbersOfIllness correctly") {
                    expect(testViewModel.numbersOfIllness).to(equal(10))
                }

                it("it sets DiseaseModel correctly") {
                    for item in mockResponse.enumerated() {
                        let (index, mockDiseaseModel) = item
                        expect(testViewModel.diseaseInfo(forIndex: index)).to(equal(mockDiseaseModel))
                    }
                }
            }
        }
    }
}
