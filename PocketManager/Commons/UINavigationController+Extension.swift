//
//  UINavigationController+Replace.swift
//  PocketManager
//
//  Created by Bartek Fira on 14/07/2022.
//

import UIKit

extension UINavigationController {
    func replaceWith(_ controller: UIViewController) {
        viewControllers[viewControllers.count - 1] = controller
        setViewControllers(viewControllers, animated: true)
    }
}
