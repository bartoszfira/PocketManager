//
//  SearchResultsViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 07/07/2022.
//

import UIKit

class SearchTransactionViewController: UIViewController {

    var transaction: [TransactionDTO]? = []
    var filteredTransaction: [TransactionDTO]?
    var scope: Int?
    var search: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func filterContentForSearchText (searchText: String, scope: Int?) {
        guard var transaction = transaction else {
            return
        }
        if searchText == "" {
            filteredTransaction = transaction
        } else {
            filteredTransaction = []
            switch scope {
            case 1:
                transaction = transaction.filter({ $0.type == .income })
            case 2:
                transaction = transaction.filter({ $0.type == .expenses})
                
            default: ()
            }
            
            for index in 0..<transaction.count {
                if transaction[index].name.lowercased().contains(searchText.lowercased()) {
                    filteredTransaction?.append(transaction[index])

                }
            }
        
            tableView.reloadData()
        }
    }

    func setupTable() {
        
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        filteredTransaction = transaction
    }
    
    func fetchData() {
        TransactionService.shared.fetchTransactions { [weak self] transactions in
            self?.transaction = transactions
            self?.tableView.reloadData()
        }
    }

}
extension SearchTransactionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}
extension SearchTransactionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTransaction?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell,
                  let filteredTransactions = filteredTransaction else {
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

extension SearchTransactionViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        self.scope = selectedScope
        filterContentForSearchText(searchText: search ?? "", scope: scope)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.search = searchText
        filterContentForSearchText(searchText: search ?? "", scope: scope)
    }

}
