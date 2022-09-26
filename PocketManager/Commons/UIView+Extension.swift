//
//  UIView+Extension.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var getNib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func layerCircle() {
        self.layer.cornerRadius = frame.size.width/2
    }
}
