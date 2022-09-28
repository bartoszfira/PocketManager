//
//  ContactsViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 01/07/2022.
//

import UIKit

class ContactsViewController: UIViewController {

    var listType: DealType = .contact
    
    var store: [StoreDTO]? = []
    var contact: [ContactDTO]? = []
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchController?
    let header = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupSearchBar()
        setupSegmentController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFriendData()
    }
    
    func displayContactInformation(with contact: ContactDTO?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ContactInformationViewController") as! ContactInformationViewController
        vc.contact = contact
        self.navigationController?.pushViewController(vc, animated: true)
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
        tableView.delegate = self
        tableView.dataSource = self

        self.tableView.tableHeaderView = header
        self.tableView.tableHeaderView?.frame.size.height = 60
        setupHeader()
    }

    func setupHeader() {
        header.titleLabel.text = listType.title
        header.ctaButton.setTitle("Add new", for: .normal)
//        header.completion = {
//            switch self.listType {
//            case .contact:
//
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "AddNewContactViewController") as! AddNewContactViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            case .store:
//                print("Add Store..")
//            }
//        }
    }

    func setupSearchBar() {
        let resultController = listType.searchViewController
        
        searchBar = UISearchController(searchResultsController: resultController)
        navigationItem.searchController = searchBar
        searchBar?.searchBar.delegate = resultController as? UISearchBarDelegate
        searchBar?.searchBar.placeholder = "Search Contact..."
        searchBar?.searchBar.sizeToFit()
    }

    func fetchFriendData() {
        ContactService.shared.fetchFriends { [weak self] contacts in
            self?.contact = contacts
            self?.tableView.reloadData()
        }
    }
    func fetchStoreData() {
        StoreService.shared.fetchStores { [weak self] store in
            self?.store = store
            self?.tableView.reloadData()
        }
    }

    func segmentAction() {
        self.listType.toggle()
        (self.listType == .contact) ? self.fetchFriendData() : self.fetchStoreData()
        self.tableView.reloadData()
        self.setupHeader()
        (navigationItem.searchController?.searchResultsController as? SearchContactViewController)?.type = listType
        setupSearchBar()
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch listType {
        case .contact:
            return contact?.count ?? 0
        case .store:
            return store?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch listType {
        case .contact:
            return generateContactCell(from: tableView, for: indexPath)
        case .store:
            return generateStoreCell(from: tableView, for: indexPath)
        }
    }
}


extension ContactsViewController {
    func generateContactCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell,
              let contact = contact else {
            return UITableViewCell()
        }

        cell.configure(personals: contact[indexPath.row].fullName,
                       mail: contact[indexPath.row].mail,
                       iconInitial: contact[indexPath.row].initial)

        cell.completion = { [weak self] in
            self?.displayContactInformation(with: contact[indexPath.row])
            
        }

        return cell
    }

    func generateStoreCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell,
              let store = store else {
            return UITableViewCell()
        }

        cell.configure(name: store[indexPath.row].name,
                       initial: store[indexPath.row].titleInitial,
                       image: nil)
        
        return cell
    }
}
