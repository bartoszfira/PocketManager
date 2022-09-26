//
//  TransactionsViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/06/2022.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    @IBOutlet weak var transactionsTableView: UITableView!
    var searchBar: UISearchController?

    var transactions: [TransactionDTO]? = []
    let header = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTable()
        setupHeader()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func setupTable() {
        transactionsTableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        self.transactionsTableView.tableHeaderView = header
        self.transactionsTableView.tableHeaderView?.frame.size.height = 60
    }
    
    func setupHeader() {
        header.ctaButton.tintColor = .clear
    }
    
    func setupSearchBar() {
        let resultController = SearchTransactionViewController.instantiate(controllerId: "SearchResultsViewController")
        searchBar = UISearchController(searchResultsController: resultController)

        navigationItem.searchController = searchBar
//        searchBar?.showsSearchResultsController = true
        searchBar?.searchBar.scopeButtonTitles = ["All","Income","Expenses"]
        searchBar?.searchBar.delegate = resultController
        searchBar?.searchBar.placeholder = "Search Transaction..."
        searchBar?.searchBar.sizeToFit()
    }
    
    func fetchData() {
        TransactionService.shared.fetchTransactions { [weak self] transactions in
            self?.transactions = transactions
            self?.transactionsTableView.reloadData()
        }
    }
    
}

extension TransactionsViewController: UITableViewDataSource {
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

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
