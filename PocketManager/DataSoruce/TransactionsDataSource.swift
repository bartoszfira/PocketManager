//
//  TransactionsDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import UIKit

class TransactionsDataSource: NSObject, UITableViewDataSource {
 
    var transactions: [TransactionDTO]?
    
    init(transactions: [TransactionDTO]? = []) {
        self.transactions = transactions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell,
              let transactions = transactions else {
            return UITableViewCell()
        }

        cell.configure(description: transactions[indexPath.row].name,
                       date: transactions[indexPath.row].date.shortDate,
                       amount: transactions[indexPath.row].amount.toString,
                       initial: transactions[indexPath.row].initial,
                       icon: nil,
                       type: transactions[indexPath.row].type)

        return cell

    }
}
extension TransactionsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
