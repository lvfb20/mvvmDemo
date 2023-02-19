//
//  DiscountRepository.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 9/2/23.
//

import Foundation

class DiscountRepository: DiscountData {
    
    func getAvailableDiscounts() -> [String : Discount] {
        return [ProductCode.voucher.rawValue : TwoForOneDiscount(),
                ProductCode.tshirt.rawValue : BulkDiscount(minimumQty: 3, discountPerUnit: 1.0),
        ]
    }
}
