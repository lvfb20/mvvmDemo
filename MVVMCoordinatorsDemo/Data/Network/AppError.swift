//
//  AppError.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import Foundation

enum AppError: Error, Equatable {
    case badRequest
    case unauthorized
    case serverException(message: String?)
    case notFound
    case unknown(message: String?)
}
