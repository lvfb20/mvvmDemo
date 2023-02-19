//
//  CellConfigurable.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

protocol CellConfigurable {
    associatedtype ViewModel: CellViewModel
    func setup(viewModel: ViewModel)
}

protocol CellViewModel {}

typealias CellSelectionHandler = (() -> Void)
protocol CellSelectable {
    var cellSelectionHandler: CellSelectionHandler { get set }
}
