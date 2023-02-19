//
//  ProductListDecodable.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation

struct ProductListDecodable: Decodable {
    let products: [ProductDecodable]?
}
