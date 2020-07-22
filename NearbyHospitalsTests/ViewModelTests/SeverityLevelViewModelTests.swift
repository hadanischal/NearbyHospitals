//
//  SeverityLevelViewModelTests.swift
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

final class SeverityLevelViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: SeverityLevelViewModel!
        var testScheduler: TestScheduler!
        var mockList: [LevelOfPain]!

        describe("SeverityLevelViewModel") {
            beforeEach {
                mockList = LevelOfPain.allCases
                testScheduler = TestScheduler(initialClock: 0)
                testViewModel = SeverityLevelViewModel()
            }

            it("sets the titleText correctly") {
                let res = testScheduler.start { testViewModel.navigationTitle.asObservable() }
                expect(res.events.count).to(equal(2))
                let correctResult = [Recorded.next(200, "Select severity level"),
                                     Recorded.completed(200)]
                expect(res.events).to(equal(correctResult))
            }

            it("sets the tableViewHeader correctly") {
                expect(testViewModel.collectionViewHeader).to(equal("Withing Parasite"))
            }

            it("it sets numbersOfIllness correctly") {
                expect(testViewModel.numberOfRowsInSection).to(equal(5))
            }

            context("Get severity info for index") {
                it("it sets severity info correctly") {
                    for item in mockList.enumerated() {
                        let (index, mockDiseaseModel) = item
                        expect(testViewModel.severity(forIndex: index)).to(equal(mockDiseaseModel))
                    }
                }
            }
        }
    }
}
