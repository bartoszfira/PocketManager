//
//  TransactionDTO.swift
//  PocketManager
//
//  Created by Bartek Fira on 17/06/2022.
//

import UIKit
import FirebaseFirestoreSwift

struct TransactionDTO: Codable {
    @DocumentID var id: String?
    let transactionId: String
    let storeId: String
    let name: String
    let image: String?
    let date: Date
    let type: TransactionKind
    let amount: Double
    let initial: String?
}


enum TransactionKind: String, Codable {
    case income = "income"
    case expenses = "expenses"
    
    mutating func toggle() {
        switch self {
        case .income:
            self = .expenses
        case .expenses:
            self = .income
        }
    }

    var image: UIImage? {
        switch self {
        case .expenses:
            return .init(named: "Up")
        case .income:
            return .init(named: "Down")
        }
    }

    var title: String {
        switch self {
        case .expenses:
            return "Expenses"
        case .income:
            return "Income"
        }
    }

    var constraintActive: Bool {
        switch self {
        case .expenses:
            return false
        case .income:
            return true
        }
    }

    var typeChar: String {
        switch self {
        case .income:
            return "+"
        case .expenses:
            return "-"
        }
    }
    
    var color: UIColor {
        switch self {
        case .income:
            return .strongGreen
        case .expenses:
            return .red
        }
    }
}

extension TransactionDTO {
    static let mock: [TransactionDTO] = []
//        [TransactionDTO(image: "", transactionName:
//                                            "Jarek", date: "22.10.2022", type: "income" , amount: 1000),
//                                         TransactionDTO(image: "", transactionName: "Jurek", date: "23.10.2022", type: "income", amount: 2000),
//                                         TransactionDTO(image: "", transactionName: "Marek", date: "24.10.2022", type: "income", amount: 3000),
//                                         TransactionDTO(image: "", transactionName: "Janek", date: "25.10.2022", type: "income", amount: 4000),
//                                         TransactionDTO(image: "", transactionName: "Jarek", date: "26.10.2022", type: "income", amount: 1100),
//                                         TransactionDTO(image: "", transactionName: "Jurek", date: "27.10.2022", type: "income", amount: 2200),
//                                         TransactionDTO(image: "", transactionName: "Marek", date: "28.10.2022", type: "income", amount: 3300),
//                                         TransactionDTO(image: "", transactionName: "Janek", date: "29.10.2022", type: "income", amount: 4400)]
}

