//
//  CheckoutCellViewModel.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 9/2/23.
//

import Foundation

struct CheckoutCellViewModel: CellViewModel {
    var name: String?
    var unitPrice: String?
    var quantity: String?
    var discountText: String?
    var discountPrice: String?
    var totalProductsPrice: String?
}
