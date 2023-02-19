//
//  GetProductListUseCaseTest.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import XCTest
import RxSwift

class GetProductListUseCaseTest: XCTestCase {
    
    var sut: GetProductListUseCaseType!
    var mockRepository: MockProductRepository!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockProductRepository()
        sut = GetProductListUseCase(repository: mockRepository)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockRepository = nil
        disposeBag = nil
    }
    
    func testWhenGetProductListUseCase_ExecuteSuccessfully_HasProducts() {
        mockRepository.decodables = TestingUtils.getDecodables()
       
        let expect = expectation(description: "wait for GetProductListUseCase execution")
       
        _ = sut.execute().subscribe { products in
            XCTAssertEqual(products.count, 3)
            let first = products.first
            XCTAssertEqual(first?.name, "Cabify Voucher")
            XCTAssertEqual(first?.code, ProductCode.voucher)
            XCTAssertEqual(first?.price, 5)
            expect.fulfill()
        } onFailure: { error in
            XCTFail()
        }

        wait(for: [expect], timeout: 0.2)
    }
}

