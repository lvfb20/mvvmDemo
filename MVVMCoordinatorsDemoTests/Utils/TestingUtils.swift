//
//  TestingUtils.swift
//  MVVMCoordinatorsDemoTests
//
//  Created by legna filloy on 18/2/23.
//

@testable import MVVMCoordinatorsDemo
import Foundation
import RxSwift

class TestingUtils {
    
    static func parseJsonFileToData(filename: String) -> Data! {
        @objc class TestClass: NSObject {}
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
    static func parseJsonFileToString(filename: String) -> String {
        @objc class TestClass: NSObject {}
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        let data = (try? Data(contentsOf: URL(fileURLWithPath: path!)))
        return String(data: data!, encoding: .utf8)!
    }
    
    static func returnSingle<P>(data: P) -> Single<P> {
        return Single.just(data)
    }
    
    static func getDecodables() -> [ProductDecodable] {
        return [ProductDecodable(code: "VOUCHER", name: "Cabify Voucher", price: 5), ProductDecodable(code: "TSHIRT", name: "Cabify T-Shirt", price: 20),
                ProductDecodable(code: "MUG", name: "Cabify Coffee Mug", price: 7.5)]
    }
    
    static func getProductList() -> ProductListModel {
        return getDecodables().map({ProductModel(decodable: $0)})
    }

    static func getVoucher() -> ProductModel {
        return getProductList()[0]
    }
    
    static func getTshirt() -> ProductModel {
        return getProductList()[1]
    }
    
    static func getMug() -> ProductModel {
        return getProductList()[2]
    }
    
    static func getProductListCells(qty: Int = 0) -> [ProductListCellViewModel] {
        return getProductList().map({ProductListCellViewModel(name: $0.name, code: $0.code, price: $0.price?.currencyValue, quantity: qty)})
    }
}
