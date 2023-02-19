//
//  ProductsTarget.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import Moya

fileprivate struct ProductTargetUrls {
    static let baseUrl = "https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887"
}

enum ProductsTarget {
    case getProductList
}

extension ProductsTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: ProductTargetUrls.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getProductList:
            return "/Products.json"
        }
    }
    
    var method: Method {
        switch self {
        case .getProductList:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var task: Task {
        switch self {
        case .getProductList:
            return .requestPlain
        }
    }
}

