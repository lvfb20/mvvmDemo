//
//  CatchError+RxSwift.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import RxSwift
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func catchAppError() -> Single<Element> {
        return flatMap { response in
            switch response.statusCode {
            case 200...299: return .just(response)
            case 400: return .error(AppError.badRequest)
            case 401: return .error(AppError.unauthorized)
            case 404: return .error(AppError.notFound)
            case 500: return .error(AppError.serverException(message: "An error occured."))
          
            default:
                return .error(AppError.unknown(message: "Unknown error"))
            }
        }
    }
}
