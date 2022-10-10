//
//  TransactionsPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import Foundation

protocol TransactionsPresenter: AnyObject {
    func reloadTableData(with data: [TransactionDTO]?)
}
