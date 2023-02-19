//
//  CheckoutViewModelTest.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import XCTest

class CheckoutViewModelTest: XCTestCase {
    
    var sut: CheckoutViewModel!
    var mockGetDiscountsUseCase: MockGetDiscountsUseCase!
    var mockShoppingCart: ShoppingCart!
    
    override func setUp() {
        super.setUp()
        mockShoppingCart = [:]
        mockGetDiscountsUseCase = MockGetDiscountsUseCase()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockShoppingCart = [:]
        mockGetDiscountsUseCase = nil
    }
    
    func testWhenViewDidLoad_GetDiscountsUseCase_Called() {
        sut = CheckoutViewModel(shoppingCart: mockShoppingCart, discountsUseCase: mockGetDiscountsUseCase)
        sut.viewDidLoad()
        XCTAssertEqual(mockGetDiscountsUseCase.executeCalled, true)
    }
    
    func testWhenShoppingCart_Has1Voucher1TShirt1Mug_Success() {
        
        mockShoppingCart = [TestingUtils.getVoucher(): 1,
                            TestingUtils.getTshirt(): 1,
                            TestingUtils.getMug(): 1]
        sut = CheckoutViewModel(shoppingCart: mockShoppingCart, discountsUseCase: mockGetDiscountsUseCase)
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.totalInfo.value?.subtotal, 32.5)
        XCTAssertEqual(sut.totalInfo.value?.total, 32.5)
        XCTAssertEqual(sut.totalInfo.value?.discount, 0)
    }
    
    func testWhenShoppingCart_Has2Voucher1TShirt_Success() {
        
        mockShoppingCart = [TestingUtils.getVoucher(): 2,
                            TestingUtils.getTshirt(): 1]
        sut = CheckoutViewModel(shoppingCart: mockShoppingCart, discountsUseCase: mockGetDiscountsUseCase)
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.totalInfo.value?.subtotal, 30)
        XCTAssertEqual(sut.totalInfo.value?.total, 25)
        XCTAssertEqual(sut.totalInfo.value?.discount, 5)
    }
    
    func testWhenShoppingCart_Has1Voucher4TShirt_Success() {
        
        mockShoppingCart = [TestingUtils.getVoucher(): 1,
                            TestingUtils.getTshirt(): 4]
        sut = CheckoutViewModel(shoppingCart: mockShoppingCart, discountsUseCase: mockGetDiscountsUseCase)
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.totalInfo.value?.subtotal, 85)
        XCTAssertEqual(sut.totalInfo.value?.total, 81)
        XCTAssertEqual(sut.totalInfo.value?.discount, 4)
    }
    
    func testWhenShoppingCart_Has3Voucher3TShirt1Mug_Success() {
        
        mockShoppingCart = [TestingUtils.getVoucher(): 3,
                            TestingUtils.getTshirt(): 3,
                            TestingUtils.getMug(): 1]
        sut = CheckoutViewModel(shoppingCart: mockShoppingCart, discountsUseCase: mockGetDiscountsUseCase)
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.totalInfo.value?.subtotal, 82.5)
        XCTAssertEqual(sut.totalInfo.value?.total, 74.5)
        XCTAssertEqual(sut.totalInfo.value?.discount, 8)
    }
}
