//
//  String+Extension.swift
//  PocketManager
//
//  Created by Bartek Fira on 18/07/2022.
//

import UIKit

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

extension String {
    var toDouble: Double {
        return Double(self) ?? 0
    }
}
