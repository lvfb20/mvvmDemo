//
//  MainCoordinator.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import UIKit
import Moya

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MainCoordinator {
    func start() {
        let provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.neverStub,
                                                        callbackQueue: DispatchQueue.main,
                                                        session: .default,
                                                        plugins: [RestClientHelper.getLoggerPlugin()])
        let productRepository = ProductRepository(networkManager: NetworkManagerImpl(provider: provider))
        let productListUseCase = GetProductListUseCase(repository: productRepository)
        let productListVm = ProductListViewModel(productListUseCase: productListUseCase)
        let productListVc = ProductListViewController(viewModel: productListVm)
        productListVc.coordinator = self
       
        navigationController.popToRootViewController(animated: false)
        navigationController.viewControllers = [productListVc]
    }
    
    func navigateToCheckout(shoppingCart: ShoppingCart) {
        let discountsRepository = DiscountRepository()
        let discountsUseCase = GetDiscountsUseCase(repository: discountsRepository)
        let checkoutVm = CheckoutViewModel(shoppingCart: shoppingCart, discountsUseCase: discountsUseCase)
        let checkoutVc = CheckoutViewController(viewModel: checkoutVm)
        checkoutVc.coordinator = self
        navigationController.pushViewController(checkoutVc, animated: true)
    }
}
