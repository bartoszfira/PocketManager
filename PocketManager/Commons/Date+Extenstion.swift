//
//  Date+Extenstion.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/07/2022.
//

import Foundation

extension Date {
    static let shortDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd.MM.yyyy"

        return dateFormatter
    }()

    var shortDate: String {
        return Date.shortDateFormatter.string(from: self)
    }
}
