//
//  ProductRepositoryTest.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

import XCTest
@testable import MVVMCoordinatorsDemo
import Foundation
import RxSwift
import Moya

class ProductRepositoryTest: XCTestCase {
    
    var sut: ProductData!
    var mockNetworkManager: MockNetworkManager!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        mockNetworkManager = MockNetworkManager()
        sut = ProductRepository(networkManager: mockNetworkManager)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {}
    
    func testWhenGetProducts_ExecuteSuccessfullyWithProducts_HasProducts() {
        let data = TestingUtils.parseJsonFileToData(filename: "products")
               mockNetworkManager.responseToMock = Response(statusCode: 200, data: data!)
        let expect = expectation(description: "wait for products response")
       
        _ = sut.getProductList().subscribe { products in
            XCTAssertEqual(products.count, 3)
            let first = products.first
            XCTAssertEqual(first?.name, "Cabify Voucher")
            expect.fulfill()
        } onFailure: { error in
            XCTFail()
        }

        wait(for: [expect], timeout: 0.2)
    }
    
    func testWhenGetProducts_ExecuteSuccessfullyWithEmptyProducts_HasNoProducts() {
        let data = TestingUtils.parseJsonFileToData(filename: "productsEmpty")
               mockNetworkManager.responseToMock = Response(statusCode: 200, data: data!)
        let expect = expectation(description: "wait for products response")
       
        _ = sut.getProductList().subscribe { products in
            XCTAssertEqual(products.count, 0)
            expect.fulfill()
        } onFailure: { error in
            XCTFail()
        }

        wait(for: [expect], timeout: 0.2)
    }
    
    func testWhenGetProducts_ExecuteWithStatus500_ErrorShouldBeParse() {
        let data = TestingUtils.parseJsonFileToData(filename: "productsEmpty")
               mockNetworkManager.responseToMock = Response(statusCode: 500, data: data!)
        let expect = expectation(description: "wait for error 500 products response")
       
        _ = sut.getProductList().subscribe { products in
            XCTFail()
        } onFailure: { error in
            let appError = error as? AppError
            XCTAssertNotNil(appError)
            XCTAssertEqual(appError, AppError.serverException(message: "An error occured."))
            expect.fulfill()
        }
        wait(for: [expect], timeout: 0.2)
    }
}
