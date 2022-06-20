//
//  TransactionDTO.swift
//  PocketManager
//
//  Created by Bartek Fira on 17/06/2022.
//

import UIKit

struct TransactionDTO {
    let image: String
    let transactionName: String
    let date: String
    let type: String
    let amount: Double
}

extension TransactionDTO {
    static let mock: [TransactionDTO] = [TransactionDTO(image: "", transactionName: "Jarek", date: "22.10.2022", type: "+", amount: 1000),
                                         TransactionDTO(image: "", transactionName: "Jurek", date: "23.10.2022", type: "+", amount: 2000),
                                         TransactionDTO(image: "", transactionName: "Marek", date: "24.10.2022", type: "+", amount: 3000),
                                         TransactionDTO(image: "", transactionName: "Janek", date: "25.10.2022", type: "+", amount: 4000),
                                         TransactionDTO(image: "", transactionName: "Jarek", date: "26.10.2022", type: "+", amount: 1100),
                                         TransactionDTO(image: "", transactionName: "Jurek", date: "27.10.2022", type: "+", amount: 2200),
                                         TransactionDTO(image: "", transactionName: "Marek", date: "28.10.2022", type: "+", amount: 3300),
                                         TransactionDTO(image: "", transactionName: "Janek", date: "29.10.2022", type: "+", amount: 4400)]
}

