//
//  BaseViewController.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import UIKit
import PKHUD

enum LoadingStatus {
    case start
    case stop
}

protocol BaseViewProtocol: AnyObject {
    func showLoader()
    func hideLoader()
}

class BaseViewController: UIViewController, BaseViewProtocol {
    weak var coordinator: Coordinator?
}

extension BaseViewController {
    func showLoader() {
        HUD.show(.progress, onView: self.view)
    }
    func hideLoader() {
        HUD.hide()
    }
}
