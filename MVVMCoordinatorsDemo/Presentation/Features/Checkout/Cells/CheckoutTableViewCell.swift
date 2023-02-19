//
//  CheckoutTableViewCell.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 9/2/23.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell, CellConfigurable {

    typealias ViewModel = CheckoutCellViewModel
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unitPriceValueLabel: UILabel!
    @IBOutlet weak var quantityValueLabel: UILabel!
    @IBOutlet weak var discountTextLabel: UILabel!
    @IBOutlet weak var discountAmountValue: UILabel!
    @IBOutlet weak var totalProductsValueLabel: UILabel!
    @IBOutlet weak var unitPriceTextLabel: UILabel!
    @IBOutlet weak var quantityTextLabel: UILabel!
    
    private var viewModel: ViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(viewModel: CheckoutCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        unitPriceValueLabel.text = viewModel.unitPrice
        quantityValueLabel.text = viewModel.quantity
        totalProductsValueLabel.text = viewModel.totalProductsPrice
        discountTextLabel.text = viewModel.discountText
        discountAmountValue.text = viewModel.discountPrice
        quantityTextLabel.text = "checkout.label.quantity".localized
        unitPriceTextLabel.text = "checkout.label.unitPrice".localized
    }
}
