//
//  UIViewController+LoadNibs.swift
//  MVVMCoordinatorsDemo
//
//  Created by legna filloy on 7/2/23.
//

import UIKit

extension UIViewController {
    
    func loadNibFor<Subject>(viewControllerClass: Subject) {
        loadNib(name: String(describing: viewControllerClass))
    }
    
    func loadNib(name: String) {
        if let customView = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView {
            customView.frame = self.view.bounds
            customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(customView)
        }
    }
}

