//
//  SearchTransactionPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import Foundation

protocol SearchTransactionPresenter: AnyObject {
    func reloadTransactionDate(transactions: [TransactionDTO]?)
}
