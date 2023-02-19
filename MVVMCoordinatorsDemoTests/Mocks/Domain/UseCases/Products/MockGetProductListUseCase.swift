//
//  MockGetProductListUseCase.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import RxSwift
import XCTest

class MockGetProductListUseCase: GetProductListUseCaseType {
    var expectation: XCTestExpectation?
    var executeCalled = false
    
    var productList: ProductListModel = []
    func execute() -> Single<ProductListModel> {
        executeCalled = true
        expectation?.fulfill()
        return TestingUtils.returnSingle(data: productList)
    }
}
