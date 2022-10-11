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
    var viewModel: TransactionsViewModel?
    var dataSource = TransactionsDataSource()

    let header = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TransactionsViewModel(presenter: self)
        setupSearchBar()
        setupTable()
        setupHeader()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    func setupTable() {
        transactionsTableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        
        transactionsTableView.delegate = dataSource
        transactionsTableView.dataSource = dataSource
        
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
        searchBar?.searchBar.scopeButtonTitles = ["All","Income","Expenses"]
        searchBar?.searchBar.delegate = resultController
        searchBar?.searchBar.placeholder = "Search Transaction..."
        searchBar?.searchBar.sizeToFit()
    }
}

extension TransactionsViewController: TransactionsPresenter {
    func reloadTableData(with data: [TransactionDTO]?) {
        dataSource.transactions = data
        transactionsTableView.reloadData()
    }
}
