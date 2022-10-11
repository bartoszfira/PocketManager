//
//  SearchContactViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 07/07/2022.
//

import UIKit

class SearchContactViewController: UIViewController {
    var viewModel: SearchContactViewModel?
    var dataSource = SearchContactDataSource()
    
    var type: DealType? = .contact

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchContactViewModel(presenter: self)
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    func setupTable() {
        tableView.register(ContactTableViewCell.getNib, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
}

extension SearchContactViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
            viewModel?.filterContentForSearchText(with: searchText)
            tableView.reloadData()
    }
}

extension SearchContactViewController: SearchContactPresenter {
    func reloadContactData(contacts: [ContactDTO]?) {
        dataSource.contact = contacts
        tableView.reloadData()
    }

    func navigateToContactInformation(with contact: ContactDTO?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ContactInformationViewController") as! ContactInformationViewController
        self.presentingViewController?.navigationController?.pushViewController(vc, animated: true)
        vc.dataSource.contact = contact
    }

    
}
