//
//  ProductDecodable.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation

struct ProductDecodable: Decodable {
    let code: String?
    let name: String?
    let price: Double?
}
