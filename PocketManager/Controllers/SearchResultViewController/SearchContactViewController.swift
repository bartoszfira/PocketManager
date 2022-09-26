//
//  SearchContactViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 07/07/2022.
//

import UIKit

class SearchContactViewController: UIViewController {

    var type: DealType? = .contact

    @IBOutlet weak var tableView: UITableView!
    var contact: [ContactDTO]? = []
    var filteredContact: [ContactDTO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData() // przeniesienie danych z poprzedniego widoku
    }
    
    func filterContentForSearchText (searchText: String) {
        guard let contact = contact else {
            return
        }
        for index in 0..<contact.count {
            if contact[index].name!.lowercased().contains(searchText.lowercased()) || contact[index].surname!.lowercased().contains(searchText.lowercased()) {
                filteredContact?.append(contact[index])

            }
        }
    }

    func setupTable() {
        tableView.register(ContactTableViewCell.getNib, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        filteredContact = contact
    }
    
    func fetchData() {
        ContactService.shared.fetchFriends { [weak self] contacts in
            self?.contact = contacts
            self?.tableView.reloadData()
        }
    }
    
    func displayContactInformation(with contact: ContactDTO?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ContactInformationViewController") as! ContactInformationViewController
        self.presentingViewController?.navigationController?.pushViewController(vc, animated: true)
        // setup
        vc.contact = contact
    }

}
extension SearchContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}
extension SearchContactViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContact?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell,
               let filteredContact = filteredContact else {
                return UITableViewCell()
            }
        let personals = filteredContact[indexPath.row].fullName
        let initial = "\(filteredContact[indexPath.row].initial)"
        
        cell.configure(personals: personals,
                       mail: filteredContact[indexPath.row].mail,
                       iconInitial: initial )
        
        cell.completion = { [weak self] in
            
            self?.displayContactInformation(with: filteredContact[indexPath.row])
        }
            return cell

    }
}

extension SearchContactViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredContact = contact
            
        } else {
            filteredContact = []
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
}
