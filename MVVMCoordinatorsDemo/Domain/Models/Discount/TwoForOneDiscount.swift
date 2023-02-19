//
//  TwoForOneDiscount.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import Foundation

class TwoForOneDiscount: Discount {
    
    var description: String {
        return "discount.2x1.description".localized
    }
    
    func discountAmount(productQty: Int, unitPrice: Double) -> Double {
        return Double(productQty / 2) * unitPrice
    }
}
