//
//  DashboardPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/09/2022.
//

import Foundation

protocol DashboardPresenter: AnyObject {
    func navigateToTransactions()
    func reloadTableView(with transactions: [TransactionDTO]?)
    func setupView(with user: UserDTO?)
}
