//
//  ProductModel.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation

enum ProductCode: String {
    case voucher = "VOUCHER"
    case mug = "MUG"
    case tshirt = "TSHIRT"
}

struct ProductModel: Hashable {
    var name: String?
    var code: ProductCode?
    var price: Double?
    
    init(decodable: ProductDecodable) {
        if let name = decodable.name { self.name = name }
        if let code = decodable.code { self.code = ProductCode(rawValue: code) }
        if let price = decodable.price { self.price = price }
    }
}

typealias ProductListModel = [ProductModel]
