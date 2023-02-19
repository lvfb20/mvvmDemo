//
//  BulkDiscount.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import Foundation

struct BulkDiscount: Discount {
    
    let minimumQty: Int
    let discountPerUnit: Double
    
    var description: String {
        return "discount.bulk.description".localized
    }
    
    func discountAmount(productQty: Int, unitPrice: Double) -> Double {
        return productQty >= minimumQty ? discountPerUnit * Double(productQty) : 0.0
    }
}
