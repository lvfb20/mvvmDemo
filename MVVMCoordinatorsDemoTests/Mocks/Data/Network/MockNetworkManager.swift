//
//  MockNetworkManager.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

import Foundation
import Moya
import RxSwift
@testable import MVVMCoordinatorsDemo

class MockNetworkManager: NetworkManager {
    var provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub,
                                                                        plugins:[])
    var targetToRequest: TargetType?
    var responseToMock: Response?  {
        didSet {
            let serverEndpointClosure = { (target: MultiTarget) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: {.networkResponse(self.responseToMock!.statusCode, self.responseToMock!.data)} ,
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
            self.provider = MoyaProvider<MultiTarget>(endpointClosure: serverEndpointClosure,
                                                      stubClosure: MoyaProvider.immediatelyStub,
                                                      plugins: [])
            
        }
    }
    
    func makeRequest(_ target: TargetType) -> Single<Response> {
        targetToRequest = target
        return self.provider.rx.request(MultiTarget(target))
    }
}
