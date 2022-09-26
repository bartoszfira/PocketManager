//
//  AppColors.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/07/2022.
//

import UIKit

extension UIColor {
    
    class var appPrimary: UIColor {
        return UIColor(red: 57/255, green: 137/255, blue: 131/255, alpha: 1)
    }
    
    class var strongGreen: UIColor {
        return UIColor(red: 84/255, green: 168/255, blue: 95/255, alpha: 1)
    }
    
    static func random() -> UIColor {
            return UIColor(
                red:    .random(),
                green:  .random(),
                blue:   .random(),
                alpha: 1.0
            )
        }
}
