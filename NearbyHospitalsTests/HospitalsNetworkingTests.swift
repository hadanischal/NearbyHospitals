//
//  HospitalsNetworkingTests.swift
//  NearbyHospitalsTests
//
//  Created by Nischal Hada on 26/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxSwift
import RxTest
import XCTest

@testable import NearbyHospitals

final class HospitalsNetworkingTests: QuickSpec {
    override func spec() {
        var testViewModel: HospitalsNetworking!
        var mockDiseaseListHandler: MockWebServiceProtocol!
        var testScheduler: TestScheduler!
        var mockIllnessListModel: IllnessListModel!

        describe("HospitalsNetworking Test") {
            beforeEach {
                mockIllnessListModel = MockData().stubIllnessListModel()

                testScheduler = TestScheduler(initialClock: 0)
                mockDiseaseListHandler = MockWebServiceProtocol()
                stub(mockDiseaseListHandler) { stub in
                    when(stub.load(resource: any())).thenReturn(Observable<IllnessListModel>.error(mockError))
                }
                testViewModel = HospitalsNetworking(withWebService: mockDiseaseListHandler)
            }

            describe("test getDiseaseInfo") {
                context("When server request get succeed") {
                    beforeEach {
                        stub(mockDiseaseListHandler) { stub in
                            when(stub.load(resource: any(Resource<IllnessListModel>.self))).thenReturn(Observable.just(mockIllnessListModel))
                        }
                    }

                    it("emits the DiseaseInfo") {
                        let observable = testViewModel.getDiseaseInfo().asObservable()
                        let res = testScheduler.start { observable }

                        expect(res.events.count).to(equal(2))
                        let correctResult: [Recorded<Event<IllnessEmbedded?>>] = [Recorded.next(200, mockIllnessListModel.embedded), Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("when server request failed with error") {
                    beforeEach {
                        stub(mockDiseaseListHandler) { stub in
                            when(stub.load(resource: any(Resource<IllnessListModel>.self))).thenReturn(Observable.error(mockError))
                        }
                    }

                    it("emits the error") {
                        let observable = testViewModel.getDiseaseInfo().asObservable()
                        let res = testScheduler.start { observable }

                        expect(res.events.count).to(equal(1))
                        let correctResult: [Recorded<Event<IllnessEmbedded?>>] = [Recorded.error(200, mockError)]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }

            describe("test HospitalsInfo") {
                let mockHospitalListModel: HospitalListModel! = MockData().stubHospitalListModel()
                context("When server request get succeed") {
                    beforeEach {
                        stub(mockDiseaseListHandler) { stub in
                            when(stub.load(resource: any(Resource<HospitalListModel>.self))).thenReturn(Observable.just(mockHospitalListModel))
                        }
                    }

                    it("emits the HospitalsInfo") {
                        let observable = testViewModel.getHospitalsInfo().asObservable()
                        let res = testScheduler.start { observable }

                        expect(res.events.count).to(equal(2))
                        let correctResult: [Recorded<Event<HospitalEmbedded?>>] = [Recorded.next(200, mockHospitalListModel.embedded), Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("when server request failed with error") {
                    beforeEach {
                        stub(mockDiseaseListHandler) { stub in
                            when(stub.load(resource: any(Resource<HospitalListModel>.self))).thenReturn(Observable.error(mockError))
                        }
                    }

                    it("emits the error") {
                        let observable = testViewModel.getHospitalsInfo().asObservable()
                        let res = testScheduler.start { observable }

                        expect(res.events.count).to(equal(1))
                        let correctResult: [Recorded<Event<HospitalEmbedded?>>] = [Recorded.error(200, mockError)]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }
        }
    }
}
