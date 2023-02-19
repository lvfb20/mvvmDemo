//
//  ProductListViewControllerTest.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import XCTest

class ProductListViewControllerTest: XCTestCase {
    
    var sut: ProductListViewController!
    var mockProductListViewModel: MockProductListViewModel!
    
    override func setUp() {
        super.setUp()
        mockProductListViewModel = MockProductListViewModel()
        sut = ProductListViewController(viewModel: mockProductListViewModel)
        
        sut.preloadViewForTest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhenViewDidLoad_ViewModelViewDidLoad_Called() {
        sut.viewDidLoad()
        XCTAssertEqual(mockProductListViewModel.viewDidLoadCalled, true)
    }
    
    func testWhenViewModel_HasProductListCells_TableViewShowsData() {
        mockProductListViewModel.productListCells.value = TestingUtils.getProductListCells()
    
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 3)
    }
    
    func testWhenViewModel_HasNotProductListCells_TableViewDontShowsData() {
        mockProductListViewModel.productListCells.value = nil
    
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 0)
    }
}
