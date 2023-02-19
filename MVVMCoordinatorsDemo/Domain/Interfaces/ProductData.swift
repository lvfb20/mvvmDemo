//
//  ProductData.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import Foundation
import RxSwift

protocol ProductData {
    func getProductList() -> Single<[ProductDecodable]>
}
