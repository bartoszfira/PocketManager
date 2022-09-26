//
//  SearchStoreViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 01/08/2022.
//

import UIKit

class SearchStoreViewController: UIViewController {

    var type: DealType? = .store

    @IBOutlet weak var tableView: UITableView!
    var store: [StoreDTO]? = []
    var filteredStore: [StoreDTO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData() // przeniesienie danych z poprzedniego widoku
    }
    
    func filterContentForSearchText (searchText: String) {
        guard let store = store else {
            return
        }
        for index in 0..<store.count {
            if store[index].name.lowercased().contains(searchText.lowercased()){
                filteredStore?.append(store[index])

            }
        }
    }

    func setupTable() {
        tableView.register(SimpleTableViewCell.getNib, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        filteredStore = store
    }
    
    func fetchData() {
        StoreService.shared.fetchStores{ [weak self] store in
            self?.store = store
            self?.tableView.reloadData()
        }
    }
    
//    func displayContactInformation(with contact: ContactDTO?) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "ContactInformationViewController") as! ContactInformationViewController
//        self.presentingViewController?.navigationController?.pushViewController(vc, animated: true)
//        // setup
//        vc.contact = contact
//    }

}
extension SearchStoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension SearchStoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStore?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell,
               let filteredStore = filteredStore else {
                return UITableViewCell()
            }
        cell.configure(name: filteredStore[indexPath.row].name,
                       initial: filteredStore[indexPath.row].titleInitial,
                       image: nil)
            return cell

    }
}

extension SearchStoreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredStore = store
            
        } else {
            filteredStore = []
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
}

