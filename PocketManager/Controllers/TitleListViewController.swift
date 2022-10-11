//
//  TitleListViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 21/07/2022.
//

import UIKit

protocol TitleListable {
    var title: String { get }
    var dataId: String { get }
    var titleInitial: String? { get }
    var icon: UIImage? { get }
}

class TitleListViewController: UIViewController {
    var viewModel: TitleListViewModel?
    let dataSource: TitleListDataSource = TitleListDataSource()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearchBar()

        viewModel?.viewDidLoad()
    }

    func setupSearchBar() {
        searchBar.delegate = self
    }

    func setupTable() {
        dataSource.delegate = viewModel

        tableView.register(SimpleTableViewCell.getNib, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
}

extension TitleListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.serchBarDidChange(with: searchText)
    }
}

extension TitleListViewController: TitleListPresenter {
    func close() {
        dismiss(animated: true, completion: nil)
    }

    func reloadTableView(with data: [TitleListable]?) {
        dataSource.models = data
        tableView.reloadData()
    }
}
