//
//  ProductListTableViewCell.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 8/2/23.
//

import UIKit

class ProductListTableViewCell: UITableViewCell, CellConfigurable {
    
    typealias ViewModel = ProductListCellViewModel
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    
    // MARK: - Private vars
    
    private var viewModel: ViewModel?
    var incrementActionBlock: (() -> Void)?
    var decrementActionBlock: (() -> Void)?
    
    // MARK: - View Life Cycle
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - CellConfigurable
    
    func setup(viewModel: ProductListCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        if let quantity = viewModel.quantity {
            qtyLabel.text = "\(quantity)"
        }
    }
    
    // MARK: - Actions
    
    @IBAction func incrementProductQtyAction(_ sender: UIButton) {
        if let action = self.incrementActionBlock {
            action()
        }
    }
    
    @IBAction func decrementProductQtyAction(_ sender: Any) {
        if let action = self.decrementActionBlock {
            action()
        }
    }
}
