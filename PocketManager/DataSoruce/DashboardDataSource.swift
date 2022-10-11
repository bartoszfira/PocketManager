//
//  DashboardDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/09/2022.
//

import UIKit

class DashboardDataSource: NSObject, UITableViewDataSource {
    var transactions: [TransactionDTO]?

    init(transactions: [TransactionDTO]? = []) {
        self.transactions = transactions
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let transactionsNumber = transactions?.count ?? 0
        return transactionsNumber > 10 ? 10 : transactionsNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell,
              let transaction = transactions else {
            return UITableViewCell()
        }

        cell.configure(description: transaction[indexPath.row].name,
                       date: transaction[indexPath.row].date.shortDate,
                       amount: transaction[indexPath.row].amount.toString,
                       initial: transaction[indexPath.row].initial,
                       icon: nil,
                       type: transaction[indexPath.row].type)
       
        return cell

    }

}
extension DashboardDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

