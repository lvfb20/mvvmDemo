//
//  DiscountData.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 9/2/23.
//

import Foundation

protocol DiscountData {
    func getAvailableDiscounts() -> [String: Discount]
}
