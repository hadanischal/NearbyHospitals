//
//  MapViewModelTests.swift
//  NearbyHospitalsTests
//
//  Created by Nischal Hada on 4/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxSwift
import RxTest
import XCTest

@testable import NearbyHospitals

final class MapViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: MapViewModel!
        var testScheduler: TestScheduler!
        var mockList: [HospitaModel]!

        describe("MapViewModel test") {
            beforeEach {
                mockList = MockData().stubHospitalEmbeddedList()!.hospitals.map { HospitaModel($0, time: 20) }
                testScheduler = TestScheduler(initialClock: 0)
                testViewModel = MapViewModel(withHospitaModel: mockList, initialLocation: mockList.first?.location)
            }

            it("sets the titleText correctly") {
                let res = testScheduler.start { testViewModel.navigationTitle.asObservable() }
                expect(res.events.count).to(equal(2))
                let correctResult = [Recorded.next(200, "Hospital List"),
                                     Recorded.completed(200)]
                expect(res.events).to(equal(correctResult))
            }

            it("sets the initialLocation correctly") {
                expect(testViewModel.initialLocation).to(equal(mockList.first?.location))
            }

            describe("When set mapInfoList") {
                context("When set HospitaModel list") {
                    beforeEach {
                        testViewModel = MapViewModel(withHospitaModel: mockList)
                        testViewModel.viewDidLoad()
                    }

                    it("it sets numbersOfIllness correctly") {
                        let correctResult = mockList.map {
                            MapModel(title: $0.name,
                                     locationName: $0.name,
                                     latitude: $0.location.lat,
                                     longitude: $0.location.lng)
                        }
                        for item in correctResult.enumerated() {
                            let (index, mockDiseaseModel) = item
                            expect(testViewModel.mapInfoList[index].locationName).to(equal(mockDiseaseModel.locationName))
                            expect(testViewModel.mapInfoList[index].title).to(equal(mockDiseaseModel.title))
                            // TODO: Implement edge case testing
                        }

                        expect(testViewModel.mapInfoList.count).to(equal(10))
                    }
                }

                context("When set empty HospitaModel list") {
                    beforeEach {
                        testViewModel = MapViewModel(withHospitaModel: [])
                        testViewModel.viewDidLoad()
                    }

                    it("it sets numbersOfIllness correctly") {
                        expect(testViewModel.mapInfoList).to(beEmpty())
                    }
                }
            }
        }
    }
}
