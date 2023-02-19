//
//  MockProductListViewModel.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation

class MockProductListViewModel: ProductListViewModelProtocol {
    var shoppingCart: ShoppingCart = [:]
    var incremementProductQtyCalled = false
    var decrementProductQtyCalled = false
    var clearShoppingCartCalled = false
    var viewDidLoadCalled = false
    
    var productListCells: Box<[ProductListCellViewModel]?> = Box(nil)
    var productsQty: Box<Int> = Box(0)
    var loadingStatus: Box<LoadingStatus?> = Box(nil)
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func incremementProductQty(code: ProductCode) {
        incremementProductQtyCalled = true
    }
    
    func decrementProductQty(code: ProductCode) {
        decrementProductQtyCalled = true
    }
    
    func clearShoppingCart() {
        clearShoppingCartCalled = true
    }
}
