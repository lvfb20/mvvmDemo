//
//  Colors.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 18/2/23.
//

import UIKit

enum Color {
    private enum ColorKeys: String {
        case purple
    }
    
    private static func color(key: Color.ColorKeys) -> UIColor {
        return UIColor(named: key.rawValue) ?? UIColor.black
    }
    
    private static let purple = color(key: .purple)
    
    // Semantic Colors
    static var accent: UIColor { return purple }
}
