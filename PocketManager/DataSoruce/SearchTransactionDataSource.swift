//
//  SearchTransactionDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import UIKit

class SearchTransactionDataSource: NSObject, UITableViewDataSource {
    
    var transaction: [TransactionDTO]? = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell,
              let filteredTransactions = transaction else {
            return UITableViewCell()
        }

        cell.configure(description: filteredTransactions[indexPath.row].name,
                       date: filteredTransactions[indexPath.row].date.shortDate,
                           amount: filteredTransactions[indexPath.row].amount.toString,
                           initial: filteredTransactions[indexPath.row].initial,
                           icon: nil,
                           type: filteredTransactions[indexPath.row].type)

        return cell

    }
}

extension SearchTransactionDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}
