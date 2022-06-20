//
//  ViewController.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

class DashboardViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: HeaderView!
    
    var transactions: [TransactionDTO]? = TransactionDTO.mock
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    
        self.tableView.tableHeaderView = HeaderTableView()
        self.tableView.tableHeaderView?.frame.size.height = 60

        headerView.configure()
 
    }
    
}
extension DashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(description: transactions?[indexPath.row].transactionName,
                       date: transactions?[indexPath.row].date,
                       amount: transactions?[indexPath.row].amount.toString)

        return cell

    }

}

extension DashboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


