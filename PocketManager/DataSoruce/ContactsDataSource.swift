//
//  ContactsDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import UIKit

protocol ContactDataSourceDelegate: AnyObject {
    func didSelectCellButton(_ contact: ContactDTO)
}

class ContactsDataSource: NSObject, UITableViewDataSource {
    weak var delegate: ContactDataSourceDelegate?

    // var data: [Codable]? = []
    var store: [StoreDTO]? = []
    var contact: [ContactDTO]? = []
    var listType: DealType = .contact
    
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
    
    func generateContactCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell,
              let contact = contact else {
            return UITableViewCell()
        }

        cell.configure(personals: contact[indexPath.row].fullName,
                       mail: contact[indexPath.row].mail,
                       iconInitial: contact[indexPath.row].initial)
        
        cell.completion = { [weak self] in
            self?.delegate?.didSelectCellButton(contact[indexPath.row])
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

extension ContactsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
