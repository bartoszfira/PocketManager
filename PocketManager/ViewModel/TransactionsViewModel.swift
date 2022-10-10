//
//  TransactionsViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import Foundation

final class TransactionsViewModel {
    weak var presenter: TransactionsPresenter?
    var transactionService: TransactionServiceProtocol
    
    init(presenter: TransactionsPresenter) {
        self.presenter = presenter
        self.transactionService = TransactionService()
    }
    
    func viewWillAppear() {
        fetchData()
    }
}

extension TransactionsViewModel {
    func fetchData() {
        transactionService.fetchTransactions { [weak self] transactions in
            self?.presenter?.reloadTableData(with: transactions) }
    }
}
