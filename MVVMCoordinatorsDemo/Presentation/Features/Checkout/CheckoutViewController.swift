//
//  CheckoutViewController.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import UIKit

class CheckoutViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var subTotalTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var subTotalPriceLabel: UILabel!
    @IBOutlet weak var discountTextLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    private let viewModel: CheckoutViewModelProtocol!
    
    init(viewModel: CheckoutViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupView()
        
    }
    
    // MARK: - View Methods
    
    override func loadView() {
        super.loadView()
        loadNibFor(viewControllerClass: CheckoutViewController.self)
    }
    
    private func reloadView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func buyButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "checkout.alert.title".localized, message: "checkout.alert.description".localized,         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "checkout.alert.button".localized,
                                      style: UIAlertAction.Style.default,
                                      handler: {[weak self] _ in
            self?.coordinator?.start()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - IBActions

extension CheckoutViewController {
    
    private func setupView() {
        setupNavigationBar()
        setupTableView()
        buyButton.setTitle("checkout.button.buy".localized, for: .normal)
        setupBinding()
    }
    
    private func setupTableView() {
        self.tableView.registerCell(cell: CheckoutTableViewCell.self)
        self.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        self.title = "checkout.nav.title".localized
    }
    
    private func setupBinding() {
        viewModel.checkoutListCells.bind {[weak self] model in
            guard let self = self,
                  let _ = model else { return }
            self.reloadView()
        }
        
        viewModel.totalInfo.bind { [weak self] totalInfo in
            self?.subTotalPriceLabel.text = totalInfo?.subtotal.currencyValue
            self?.totalPriceLabel.text = totalInfo?.total.currencyValue
            self?.discountPriceLabel.text = "-" + (totalInfo?.discount.currencyValue ?? 0.currencyValue)
        }
    }
}

// MARK: - UITableViewDataSource

extension CheckoutViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.checkoutListCells.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = self.viewModel.checkoutListCells.value?[indexPath.row],
              let cell = tableView.dequeueReusableBy(cell: CheckoutTableViewCell.self) else {
            return UITableViewCell()
        }
        
        cell.setup(viewModel: cellViewModel)
        return cell
    }
}
