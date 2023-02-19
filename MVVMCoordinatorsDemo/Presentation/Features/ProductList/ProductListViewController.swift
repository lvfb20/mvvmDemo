//
//  ProductListViewController.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import UIKit

class ProductListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
   
    private let viewModel: ProductListViewModelProtocol!
    
    init(viewModel: ProductListViewModelProtocol) {
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
        self.loadNibFor(viewControllerClass: ProductListViewController.self)
    }
    
    private func reloadView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func checkoutItemsAction(_ sender: UIButton) {
        coordinator?.navigateToCheckout(shoppingCart: viewModel.shoppingCart)
    }
}

// MARK: - Setup View

extension ProductListViewController {
    
    private func setupView() {
        setupNavigationBar()
        setupTableView()
        setNavButton(text: "productList.button.clear".localized)
        setupBinding()
    }
    
    private func setupTableView() {
        self.tableView.registerCell(cell: ProductListTableViewCell.self)
        self.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        self.title = "productList.nav.title".localized
    }
    
    private func setNavButton(text: String?) {
        let myButton = UIButton.init(type: .custom)
        myButton.addTarget(self, action: #selector(self.rightButtonClicked(sender:)), for: .touchUpInside)
        myButton.setTitleColor(Color.accent, for: .normal)
        myButton.setTitle(text, for: .normal)
        myButton.contentHorizontalAlignment = .trailing
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: myButton)
    }
    
    private func setupBinding() {
        viewModel.productListCells.bind {[weak self] model in
            guard let self = self,
                  let _ = model else { return }
            self.reloadView()
        }
        
        viewModel.productsQty.bind {[weak self] quantity in
            self?.checkoutButton.isEnabled = quantity > 0
            self?.checkoutButton.setTitle(String(format: "productList.button.chechout".localized, quantity), for: .normal)
        }
        
        viewModel.loadingStatus.bind { [weak self] status in
            switch status {
            case .start:
                self?.showLoader()
            case .stop:
                self?.hideLoader()
            case .none:
                break;
            }
        }
    }
    
    @objc func rightButtonClicked(sender: UIBarButtonItem) {
        viewModel.clearShoppingCart()
    }
}

// MARK: - UITableViewDataSource

extension ProductListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productListCells.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = self.viewModel.productListCells.value?[indexPath.row],
              let productCode = cellViewModel.code,
              let cell = tableView.dequeueReusableBy(cell: ProductListTableViewCell.self) else {
            return UITableViewCell()
        }
        
        cell.setup(viewModel: cellViewModel)
        cell.decrementActionBlock = { [weak self] in
            self?.viewModel.decrementProductQty(code: productCode)
        }
        
        cell.incrementActionBlock = { [weak self] in
            self?.viewModel.incremementProductQty(code: productCode)
        }
        return cell
    }
}
