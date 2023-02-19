//
//  ProductListCellViewModel.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import Foundation

struct ProductListCellViewModel: CellViewModel {
    var name: String?
    var code: ProductCode?
    var price: String?
    var quantity: Int?
}
