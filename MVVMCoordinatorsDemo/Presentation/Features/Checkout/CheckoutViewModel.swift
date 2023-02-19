//
//  CheckoutViewModel.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation

protocol CheckoutViewModelInput {
    func viewDidLoad()
}

protocol CheckoutViewModelOutput {
    var checkoutListCells: Box<[CheckoutCellViewModel]?> { get }
    var totalInfo: Box<TotalInfo?> { get }
}

protocol CheckoutViewModelProtocol: CheckoutViewModelInput, CheckoutViewModelOutput {}

final class CheckoutViewModel: CheckoutViewModelProtocol {
    
    var checkoutListCells: Box<[CheckoutCellViewModel]?> = Box(nil)
    var totalInfo: Box<TotalInfo?> = Box(nil)
    private let shoppingCart: ShoppingCart
    private let discountsUseCase: GetDiscountsUseCaseType
    
    init(shoppingCart: ShoppingCart, discountsUseCase: GetDiscountsUseCaseType) {
        self.shoppingCart = shoppingCart
        self.discountsUseCase = discountsUseCase
    }
    
    func calculateTotal(discounts: [String:Discount]) {
        var total: Double = 0.0
        var subTotal: Double = 0.0
        var totalDiscount: Double = 0.0
        
        let checkoutCells: [CheckoutCellViewModel] =  shoppingCart.map { (value) -> CheckoutCellViewModel in
            let (product, quantity) = value
            let unitPrice = product.price ?? 0.0
            let totalProductPrice = (Double(quantity) * unitPrice)
            
            var checkoutCell = CheckoutCellViewModel(name: product.name, unitPrice: unitPrice.currencyValue, quantity: "\(quantity)", discountText: nil, discountPrice: nil, totalProductsPrice: totalProductPrice.currencyValue)
            
            guard let code = product.code,
                  let discount = discounts[code.rawValue] else {
                subTotal += totalProductPrice
                return checkoutCell
            }
            
            let discountAmount = discount.discountAmount(productQty: quantity, unitPrice: unitPrice)
            subTotal += totalProductPrice
            totalDiscount += discountAmount
            
            checkoutCell.discountText = discount.description
            checkoutCell.discountPrice = "-" + discountAmount.currencyValue
            
            return checkoutCell
        }
        
        total = subTotal - totalDiscount
        self.checkoutListCells.value = checkoutCells
        self.totalInfo.value = TotalInfo(subtotal: subTotal, total: total, discount: totalDiscount)
    }
}

// MARK: - Input methods

extension CheckoutViewModel {

    func viewDidLoad() {
        let discountsAvailables = discountsUseCase.execute()
        calculateTotal(discounts: discountsAvailables)
    }
}
