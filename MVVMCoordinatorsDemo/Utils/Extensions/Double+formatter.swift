//
//  Double+formatter.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import Foundation

extension Double {
    
    var currencyValue: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "es_ES")
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? "0"
    }
}
