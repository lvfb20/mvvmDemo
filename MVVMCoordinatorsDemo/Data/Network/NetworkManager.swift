//
//  NetworkManager.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation
import Moya
import RxSwift

protocol NetworkManager {
    func makeRequest(_ target: TargetType) -> Single<Response>
    var provider: MoyaProvider<MultiTarget> {get set}
}

class NetworkManagerImpl: NetworkManager {

    internal var provider: MoyaProvider<MultiTarget>
    
    init (provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    func makeRequest(_ target: TargetType) -> Single<Response> {
        return self.provider.rx.request(MultiTarget(target))
    }
}

// MARK: - Rest Client Helper

class RestClientHelper {
    static func getLoggerPlugin() -> PluginType {
        return NetworkLoggerPlugin(configuration: .init(formatter: .init(requestData: jsonPrettyDataFormatter,
                                                                         responseData: jsonPrettyDataFormatter),
                                                        logOptions: [.formatRequestAscURL,
                                                                     .successResponseBody,
                                                                     .errorResponseBody]))
    }
    
    static private func jsonPrettyDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
}
