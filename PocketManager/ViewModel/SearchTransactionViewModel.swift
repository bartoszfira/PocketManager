//
//  SearchTransactionViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import Foundation

final class SearchTransactionViewModel {
    weak var presenter: SearchTransactionPresenter?
    let transactionService: TransactionServiceProtocol
    
    var transactions: [TransactionDTO] = []
    var scope: Int? = 0
    var searchText: String = ""
    
    init(presenter: SearchTransactionPresenter) {
        self.presenter = presenter
        transactionService = TransactionService()
    }
    
    func viewWillAppear() {
        fetchData()
    }
}

extension SearchTransactionViewModel {
    func fetchData() {
        transactionService.fetchTransactions { [weak self] transactions in
            self?.transactions = transactions ?? []
            self?.presenter?.reloadTransactionDate(transactions: transactions)
        }
    }
    
    func filterContent(with searchText: String? = nil, scope: Int? = nil) {
        self.searchText = searchText?.lowercased() ?? self.searchText
        self.scope = scope ?? 0

        if self.searchText.isEmpty {
            return
        }

        var filtred: [TransactionDTO] = []

        filtred = transactions.filter { transaction in
            let type = scope == 1 ? TransactionKind.income : TransactionKind.expenses

            return
                (transaction.type == type || self.scope == 0) &&
                transaction.name.lowercased().contains(self.searchText)
        }

        presenter?.reloadTransactionDate(transactions: filtred)
    }

}
