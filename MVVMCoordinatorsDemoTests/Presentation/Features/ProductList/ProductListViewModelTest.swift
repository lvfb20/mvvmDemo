//
//  ProductListViewModelTest.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import XCTest

class ProductListViewModelTest: XCTestCase {
    
    var sut: ProductListViewModel!
    var mockGetProductListUseCase: MockGetProductListUseCase!
    
    override func setUp() {
        super.setUp()
        mockGetProductListUseCase = MockGetProductListUseCase()
        sut = ProductListViewModel(productListUseCase: mockGetProductListUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockGetProductListUseCase = nil
    }
    
    func testWhenViewDidLoad_GetProductListUseCase_Called() {
        let expectation = expectation(description: "Expected the execute() method to be called")
        mockGetProductListUseCase.expectation = expectation
        
        sut.viewDidLoad()
        self.wait(for: [expectation], timeout: 0.2)
        XCTAssertEqual(mockGetProductListUseCase.executeCalled, true)
    }
}
