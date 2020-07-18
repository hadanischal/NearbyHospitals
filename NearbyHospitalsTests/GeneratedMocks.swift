// MARK: - Mocks generated from file: NearbyHospitals/NetworkLayer/Core/WebServiceProtocol.swift at 2020-07-16 23:07:53 +0000

//
//  WebServiceProtocol.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
@testable import NearbyHospitals

import RxSwift

 class MockWebServiceProtocol: WebServiceProtocol, Cuckoo.ProtocolMock {
     typealias MocksType = WebServiceProtocol

     typealias Stubbing = __StubbingProxy_WebServiceProtocol
     typealias Verification = __VerificationProxy_WebServiceProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: WebServiceProtocol?

     func enableDefaultImplementation(_ stub: WebServiceProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

     func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
    return cuckoo_manager.call("load(resource: Resource<T>) -> Observable<T>",
                               parameters: resource,
                               escapingParameters: resource,
                               superclassCall:

                Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                               
            defaultCall: __defaultImplStub!.load(resource: resource))
    }

	 struct __StubbingProxy_WebServiceProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager

	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }

	    func load<M1: Cuckoo.Matchable, T: Decodable>(resource: M1) -> Cuckoo.ProtocolStubFunction<Resource<T>, Observable<T>> where M1.MatchedType == Resource<T> {
	        let matchers: [Cuckoo.ParameterMatcher<Resource<T>>] = [wrap(matchable: resource) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWebServiceProtocol.self, method: "load(resource: Resource<T>) -> Observable<T>", parameterMatchers: matchers))
	    }
	}

	 struct __VerificationProxy_WebServiceProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation

	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }

	    @discardableResult
	    func load<M1: Cuckoo.Matchable, T: Decodable>(resource: M1) -> Cuckoo.__DoNotUse<Resource<T>, Observable<T>> where M1.MatchedType == Resource<T> {
	        let matchers: [Cuckoo.ParameterMatcher<Resource<T>>] = [wrap(matchable: resource) { $0 }]
	        return cuckoo_manager.verify("load(resource: Resource<T>) -> Observable<T>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	}
}

 class WebServiceProtocolStub: WebServiceProtocol {
     func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return DefaultValueRegistry.defaultValue(for: Observable<T>.self)
    }
}

// MARK: - Mocks generated from file: NearbyHospitals/NetworkLayer/Services/HospitalsNetworking.swift at 2020-07-16 23:07:53 +0000

//
//  HospitalsNetworking.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
@testable import NearbyHospitals

import Foundation
import RxSwift

 class MockDiseaseListHandling: DiseaseListHandling, Cuckoo.ProtocolMock {
     typealias MocksType = DiseaseListHandling

     typealias Stubbing = __StubbingProxy_DiseaseListHandling
     typealias Verification = __VerificationProxy_DiseaseListHandling

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: DiseaseListHandling?

     func enableDefaultImplementation(_ stub: DiseaseListHandling) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

     func getDiseaseInfo() -> Observable<IllnessEmbedded> {
    return cuckoo_manager.call("getDiseaseInfo() -> Observable<IllnessEmbedded>",
                               parameters: (),
                               escapingParameters: (),
                               superclassCall:

                Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                               
            defaultCall: __defaultImplStub!.getDiseaseInfo())
    }

	 struct __StubbingProxy_DiseaseListHandling: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager

	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }

	    func getDiseaseInfo() -> Cuckoo.ProtocolStubFunction<Void, Observable<IllnessEmbedded>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDiseaseListHandling.self, method: "getDiseaseInfo() -> Observable<IllnessEmbedded>", parameterMatchers: matchers))
	    }
	}

	 struct __VerificationProxy_DiseaseListHandling: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation

	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }

	    @discardableResult
	    func getDiseaseInfo() -> Cuckoo.__DoNotUse<Void, Observable<IllnessEmbedded>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getDiseaseInfo() -> Observable<IllnessEmbedded>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	}
}

 class DiseaseListHandlingStub: DiseaseListHandling {
     func getDiseaseInfo() -> Observable<IllnessEmbedded> {
        return DefaultValueRegistry.defaultValue(for: Observable<IllnessEmbedded>.self)
    }
}

 class MockHospitalListHandling: HospitalListHandling, Cuckoo.ProtocolMock {
     typealias MocksType = HospitalListHandling

     typealias Stubbing = __StubbingProxy_HospitalListHandling
     typealias Verification = __VerificationProxy_HospitalListHandling

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: HospitalListHandling?

     func enableDefaultImplementation(_ stub: HospitalListHandling) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

     func getHospitalsInfo() -> Observable<HospitalEmbedded> {
    return cuckoo_manager.call("getHospitalsInfo() -> Observable<HospitalEmbedded>",
                               parameters: (),
                               escapingParameters: (),
                               superclassCall:

                Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                               
            defaultCall: __defaultImplStub!.getHospitalsInfo())
    }

	 struct __StubbingProxy_HospitalListHandling: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager

	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }

	    func getHospitalsInfo() -> Cuckoo.ProtocolStubFunction<Void, Observable<HospitalEmbedded>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHospitalListHandling.self, method: "getHospitalsInfo() -> Observable<HospitalEmbedded>", parameterMatchers: matchers))
	    }
	}

	 struct __VerificationProxy_HospitalListHandling: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation

	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }

	    @discardableResult
	    func getHospitalsInfo() -> Cuckoo.__DoNotUse<Void, Observable<HospitalEmbedded>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getHospitalsInfo() -> Observable<HospitalEmbedded>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	}
}

 class HospitalListHandlingStub: HospitalListHandling {
     func getHospitalsInfo() -> Observable<HospitalEmbedded> {
        return DefaultValueRegistry.defaultValue(for: Observable<HospitalEmbedded>.self)
    }
}
