//
//  CheckoutViewControllerTest.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import XCTest

class CheckoutViewControllerTest: XCTestCase {
    
    var sut: CheckoutViewController!
    var mockCheckoutViewModel: MockCheckoutViewModel!
    
    override func setUp() {
        super.setUp()
        mockCheckoutViewModel = MockCheckoutViewModel()
        sut = CheckoutViewController(viewModel: mockCheckoutViewModel)
        
        sut.preloadViewForTest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhenViewDidLoad_ViewModelViewDidLoad_Called() {
        sut.viewDidLoad()
        XCTAssertEqual(mockCheckoutViewModel.viewDidLoadCalled, true)
    }
}

