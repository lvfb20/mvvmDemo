//
//  ProductListViewModel.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation
import RxSwift

typealias ShoppingCart = [ProductModel:Int]

protocol ProductListViewModelInput {
    func viewDidLoad()
    func incremementProductQty(code: ProductCode)
    func decrementProductQty(code: ProductCode)
    func clearShoppingCart()
}

protocol ProductListViewModelOutput {
    var productListCells: Box<[ProductListCellViewModel]?> { get }
    var productsQty: Box<Int> { get }
    var shoppingCart: ShoppingCart { get }
    var loadingStatus: Box<LoadingStatus?> { get }
}

protocol ProductListViewModelProtocol: ProductListViewModelInput, ProductListViewModelOutput {}

final class ProductListViewModel: ProductListViewModelProtocol {
    var productListCells: Box<[ProductListCellViewModel]?> = Box(nil)
    var productsQty: Box<Int> = Box(0)
    var shoppingCart: ShoppingCart = [:]
    var storeProducts: ProductListModel = []
    var loadingStatus: Box<LoadingStatus?> = Box(nil)
    
    private let productListUseCase: GetProductListUseCaseType
    private let disposeBag = DisposeBag()
   
    init(productListUseCase: GetProductListUseCaseType) {
        self.productListUseCase = productListUseCase
    }
    
    private func getProductList() {
        loadingStatus.value = .start
        productListUseCase.execute().subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onSuccess: {[weak self] (result) in
                self?.loadingStatus.value = .stop
                self?.storeProducts = result
                self?.refreshView()
            }, onFailure: { [weak self] (error) in
                self?.loadingStatus.value = .stop
                print("error: \(error)")
            }).disposed(by: disposeBag)
    }
    
    private func refreshView() {
        updateTableViewCells()
        updateProductsQty()
    }
    
    private func updateTableViewCells() {
        self.productListCells.value = self.storeProducts.map({ProductListCellViewModel(name: $0.name, code: $0.code, price: $0.price?.currencyValue, quantity: shoppingCart[$0, default: 0])})
    }
    
    private func updateProductsQty() {
        self.productsQty.value = shoppingCart.map { $0.value }.reduce(0,+)
    }
    
    private func getProductBy(code: ProductCode) -> ProductModel? {
        return self.storeProducts.filter({$0.code == code}).first
    }
}

// MARK: - Input methods

extension ProductListViewModel {
    func viewDidLoad() {
        getProductList()
    }
    
    func incremementProductQty(code: ProductCode) {
        guard let product = getProductBy(code: code) else { return }
        shoppingCart[product, default: 0] += 1
        self.refreshView()
    }
    
    func decrementProductQty(code: ProductCode) {
        guard let product = getProductBy(code: code) else { return }
        let currentQty = shoppingCart[product, default: 0]
        if currentQty > 1 {
            shoppingCart[product] = currentQty - 1
        } else {
            shoppingCart.removeValue(forKey: product)
        }
        self.refreshView()
    }
    
    func clearShoppingCart() {
        shoppingCart = [:]
        refreshView()
    }
}
