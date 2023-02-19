//
//  ProductRepository.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation
import RxSwift

class ProductRepository: ProductData {

    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getProductList() -> Single<[ProductDecodable]> {
        return self.networkManager.makeRequest(ProductsTarget.getProductList)
            .catchAppError()
            .map(ProductListDecodable.self)
            .flatMap({ (response) -> Single<[ProductDecodable]> in
                return Single.just(response.products ?? [])
            })
    }
}
