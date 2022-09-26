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
    
    weak var delegate: RecordInformationDelegate?
    var transactionType: DealType?
    var data: [TitleListable]? = []
    var filteredData: [TitleListable]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        (transactionType == .contact) ? fetchFriendData() : fetchStoreData()
        setupTable()
        setupSearchBar()
        
    }

    func setupSearchBar() {
        searchBar.delegate = self
    }

    func setupTable() {
        tableView.register(SimpleTableViewCell.getNib, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func fetchFriendData() {
        ContactService.shared.fetchFriends { [weak self] contacts in
            self?.data = contacts
            self?.filteredData = self?.data
            self?.tableView.reloadData()
        }
    }
    func fetchStoreData() {
        StoreService.shared.fetchStores { [weak self] store in
            self?.data = store
            self?.filteredData = self?.data
            self?.tableView.reloadData()
        }
    }

    func filterContentForSearchText (searchText: String) {
        guard let data = data else {
            return
        }
        for index in 0..<data.count {
            if data[index].title.lowercased().contains(searchText.lowercased()) {
                filteredData?.append(data[index])

            }
        }
    }

    @objc func didTapCell(sender: MyTapGesture) {
        guard let delegate = delegate else {
            print("Error Delegat = nil")
            return
        }
        delegate.setData(data: sender.data as! TitleListable)
        dismiss(animated: true, completion: nil)
    }
        
}

extension TitleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}
extension TitleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell,
              let filteredData = filteredData else {
            return UITableViewCell()
        }
        
        let name = filteredData[indexPath.row].title
        let initial = filteredData[indexPath.row].titleInitial
        let image = filteredData[indexPath.row].icon
        
        cell.configure(name: name, initial: initial, image: image)
        
        let tap = MyTapGesture(target: self, action: #selector(self.didTapCell))
        tap.data = filteredData[indexPath.row]
        cell.addGestureRecognizer(tap)
       
        
        return cell

    }
    
    
}

extension TitleListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        if searchText == "" {
            filteredData = data
            tableView.reloadData()
        } else {
            filteredData = []
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
}

class MyTapGesture: UITapGestureRecognizer {
    var data: TitleListable?
}
