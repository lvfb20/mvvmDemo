//
//  String+Localized.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 18/2/23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
