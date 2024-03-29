//
//  DashboardViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/09/2022.
//

import Foundation

final class DashboardViewModel {
    let transactionService: TransactionServiceProtocol
    let userService: UserServiceProtocol
    weak var presenter: DashboardPresenter?
    
    var fiveContactTransaction: [TransactionDTO]?
    
    init(presenter: DashboardPresenter) {
        self.presenter = presenter
        transactionService = TransactionService()
        userService = UserService()
    }
    
    func viewWillAppear(){
        fetchUser()
        fetchTransaction()
    }
}

extension DashboardViewModel {
    @objc func didSelectTransactions() {
        presenter?.navigateToTransactions()
    }
}

extension DashboardViewModel {
    func fetchTransaction() {
        transactionService.fetchTransactions { [weak self] transactions in
            self?.presenter?.reloadTableView(with: transactions)
        }
    }
    
    func fetchUser() {
        userService.fetchUser { [unowned self] user in
            self.presenter?.setupView(with: user)
        }
    }
}
