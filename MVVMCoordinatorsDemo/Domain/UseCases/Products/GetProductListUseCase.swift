//
//  GetProductListUseCase.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Foundation
import RxSwift

protocol GetProductListUseCaseType {
    func execute() -> Single<ProductListModel>
}

final class GetProductListUseCase: GetProductListUseCaseType {
    let repository: ProductData
    
    init(repository: ProductData) {
        self.repository = repository
    }
    
    func execute() -> Single<ProductListModel> {
        return repository.getProductList()
            .flatMap({ (response) -> Single<ProductListModel> in
                return Single.just(response.map({ProductModel(decodable: $0)}))
            })
    }
}
