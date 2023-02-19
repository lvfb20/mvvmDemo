//
//  MockCheckoutViewModel.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation

class MockCheckoutViewModel: CheckoutViewModelProtocol {
    var viewDidLoadCalled = false
    var checkoutListCells: Box<[CheckoutCellViewModel]?> = Box(nil)
    var totalInfo: Box<TotalInfo?> = Box(nil)
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
}
