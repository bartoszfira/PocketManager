//
//  SearchStoreViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 01/08/2022.
//

import UIKit

class SearchStoreViewController: UIViewController {
    var viewModel: SearchStoreViewModel?
    var dataSource = SearchStoreDataSource()
    
    var type: DealType? = .store
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchStoreViewModel(presenter: self)
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    func setupTable() {
        tableView.register(SimpleTableViewCell.getNib, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource

    }
}

extension SearchStoreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterContentForSearchText(with: searchText)
        tableView.reloadData()
    }
}

extension SearchStoreViewController: SearchStorePresenter {
    func reloadStoreData(stores: [StoreDTO]?) {
        dataSource.store = stores
        tableView.reloadData()
    }
}

