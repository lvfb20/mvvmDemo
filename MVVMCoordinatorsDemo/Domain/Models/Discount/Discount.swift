//
//  Discount.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import Foundation

protocol Discount {
    var description: String { get }
    func discountAmount(productQty: Int, unitPrice: Double) -> Double
}
