//
//  CGFloat+Extension.swift
//  PocketManager
//
//  Created by Bartek Fira on 05/07/2022.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
