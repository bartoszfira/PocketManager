//
//  SearchResultsViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 07/07/2022.
//

import UIKit

class SearchTransactionViewController: UIViewController {

    var viewModel: SearchTransactionViewModel?
    let dataSource = SearchTransactionDataSource()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        viewModel = SearchTransactionViewModel(presenter: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }

    func setupTable() {
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource

//        dataSource.filteredTransaction = dataSource.transaction
    }
}

extension SearchTransactionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel?.filterContent(scope: selectedScope)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterContent(with: searchText)
    }

}

extension SearchTransactionViewController: SearchTransactionPresenter {
    func reloadTransactionDate(transactions: [TransactionDTO]?) {
        dataSource.transaction = transactions
        tableView.reloadData()
    }

}
