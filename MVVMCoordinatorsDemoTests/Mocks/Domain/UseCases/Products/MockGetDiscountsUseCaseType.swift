//
//  MockGetDiscountsUseCase.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation

class MockGetDiscountsUseCase: GetDiscountsUseCaseType {
    var executeCalled = false
    
    func execute() -> [String : Discount] {
        executeCalled = true
        return [ProductCode.voucher.rawValue : TwoForOneDiscount(),
                ProductCode.tshirt.rawValue : BulkDiscount(minimumQty: 3, discountPerUnit: 1.0),
        ]
    }
}
