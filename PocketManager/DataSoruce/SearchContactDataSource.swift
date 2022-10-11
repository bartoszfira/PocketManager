//
//  SearchContactDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import UIKit

class SearchContactDataSource: NSObject, UITableViewDataSource {
    weak var delegate: ContactDataSourceDelegate?
    
    var contact: [ContactDTO]? = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell,
               let filteredContact = contact else {
                return UITableViewCell()
            }
        let personals = filteredContact[indexPath.row].fullName
        let initial = "\(filteredContact[indexPath.row].initial)"
        
        cell.configure(personals: personals,
                       mail: filteredContact[indexPath.row].mail,
                       iconInitial: initial )
        
        cell.completion = { [weak self] in
            self?.delegate?.didSelectCellButton(filteredContact[indexPath.row])
        }
    
        return cell

    }
}

extension SearchContactDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
