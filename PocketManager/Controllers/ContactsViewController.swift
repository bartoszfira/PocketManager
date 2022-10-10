//
//  ContactsViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 01/07/2022.
//

import UIKit

class ContactsViewController: UIViewController {

    var dataSource = ContactsDataSource()
    var viewModel: ContactsViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchController?
    let header = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ContactsViewModel(presenter: self)
        setupActions()
        setupTable()
        setupSearchBar()
        setupSegmentController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillApear()
    }
    
    func setupActions() {
        let headerButtonAction = UIAction { [weak self] _ in
            self?.viewModel?.didSelectHeaderButton()
        }
        self.header.ctaButton.addAction(headerButtonAction,for: .touchUpInside)
    }

    func setupSegmentController() {
        let segmentController = UISegmentedControl(items: [DealType.contact.title, DealType.store.title])
        segmentController.selectedSegmentIndex = 0
        let action = UIAction { _ in
            self.segmentAction()
        }
        segmentController.addAction(action, for: .valueChanged)
        navigationItem.titleView = segmentController
    }
    
    func setupTable() {
        tableView.register(ContactTableViewCell.getNib, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.register(SimpleTableViewCell.getNib, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource

        dataSource.delegate = viewModel
        
        self.tableView.tableHeaderView = header
        self.tableView.tableHeaderView?.frame.size.height = 60
        setupHeader()
    }

    func setupHeader() {
        header.titleLabel.text = dataSource.listType.title
        header.ctaButton.setTitle("Add new", for: .normal)
    }

    func setupSearchBar() {
        let resultController = dataSource.listType.searchViewController
        
        searchBar = UISearchController(searchResultsController: resultController)
        navigationItem.searchController = searchBar
        searchBar?.searchBar.delegate = resultController as? UISearchBarDelegate
        searchBar?.searchBar.placeholder = "Search Contact..."
        searchBar?.searchBar.sizeToFit()
    }

    func segmentAction() {
        viewModel?.didSelect(dataSource)
    }
}

extension ContactsViewController: ContactsPresenter {
    func reloadTableData(with contact: [ContactDTO]?) {
        dataSource.contact = contact
        tableView.reloadData()
    }
    
    func reloadTableData(with store: [StoreDTO]?) {
        dataSource.store = store
        tableView.reloadData()
    }
    
    func navigateToAddNew() {
        switch self.dataSource.listType {
        case .contact:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddNewContactViewController") as!AddNewContactViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case .store:
            print("Add Store..")
        }
    }

    func navigateToContactInformation(with contact: ContactDTO) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ContactInformationViewController") as! ContactInformationViewController
        vc.dataSource.contact = contact
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateView() {
        self.setupHeader()
        setupSearchBar()
        (navigationItem.searchController?.searchResultsController as? SearchContactViewController)?.type = dataSource.listType
        
    }
}
