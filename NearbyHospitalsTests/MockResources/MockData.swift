//
//  MockData.swift
//  NearbyHospitalsTests
//
//  Created by Nischal Hada on 24/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

@testable import NearbyHospitals
import XCTest

class MockData {
    func stubIllnessListModel() -> IllnessListModel? {
        guard let data = self.readJson(forResource: "DiseaseMock") else {
            XCTAssert(false, "Can't get data from DiseaseMock.json")
            return nil
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode(IllnessListModel.self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse IllnessListModel results")
            return nil
        }
    }

    func stubIllnessEmbeddedList() -> IllnessEmbedded? {
        guard let data = self.readJson(forResource: "Disease") else {
            XCTAssert(false, "Can't get data from Disease.json")
            return nil
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode(IllnessListModel.self, from: data) {
            return result.embedded
        } else {
            XCTAssert(false, "Unable to parse IllnessListModel results")
            return nil
        }
    }

    func stubHospitalListModel() -> HospitalListModel? {
        guard let data = self.readJson(forResource: "Hospitals") else {
            XCTAssert(false, "Can't get data from Hospitals.json")
            return nil
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode(HospitalListModel.self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse HospitalListModel results")
            return nil
        }
    }

    func stubHospitalEmbeddedList() -> HospitalEmbedded? {
        guard let data = self.readJson(forResource: "Hospitals") else {
            XCTAssert(false, "Can't get data from Hospitals.json")
            return nil
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode(HospitalListModel.self, from: data) {
            return result.embedded
        } else {
            XCTAssert(false, "Unable to parse HospitalListModel results")
            return nil
        }
    }

    func readJson(forResource fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            XCTFail("unable to read json")
            return nil
        }
    }

    private func mapedDiseaseModelList() -> [DiseaseModel] {
        guard let list = self.stubIllnessEmbeddedList() else {
            XCTAssert(false, "Can't get job list from jobs.json")
            return []
        }

        let info = list.illnesses.map { DiseaseModel($0) }
        return info
    }
}
