//
//  MockProductRepository.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import RxSwift

class MockProductRepository: ProductData {
    
    var decodables: [ProductDecodable] = []
    func getProductList() -> Single<[ProductDecodable]> {
        TestingUtils.returnSingle(data: decodables)
    }
}
