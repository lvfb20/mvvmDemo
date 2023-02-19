//
//  GetDiscountsUseCase.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 9/2/23.
//

import Foundation

protocol GetDiscountsUseCaseType {
    func execute() -> [String:Discount]
}

final class GetDiscountsUseCase: GetDiscountsUseCaseType {
    let repository: DiscountData
    
    init(repository: DiscountData) {
        self.repository = repository
    }
    
    func execute() -> [String:Discount] {
        return repository.getAvailableDiscounts()
    }
}
