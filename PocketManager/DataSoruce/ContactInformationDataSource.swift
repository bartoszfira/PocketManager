//
//  ContactInformationDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 06/10/2022.
//

import UIKit
protocol ContactInformationDataSourceDelegate: AnyObject {
    func didSelectEdit(with contact: ContactDTO?)
}
class ContactInformationDataSource: NSObject, UITableViewDataSource {
    weak var delegate: ContactInformationDataSourceDelegate?
    
    var contact: ContactDTO?
    var transaction: [TransactionDTO]?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return transaction?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell,
                    let contact = contact else {
                return UITableViewCell()
            }
            cell.ctaButton.setImage(UIImage(systemName: "square.and.pencil"), for:.normal)
            let personals = contact.fullName
            let initial = contact.initial
            cell.configure(personals: personals,
                            mail: contact.mail,
                            iconInitial: initial)
            cell.completion = { [weak self] in
                self?.delegate?.didSelectEdit(with: self?.contact)
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath)as? TransactionsTableViewCell,
                    let transaction = transaction else {
                return UITableViewCell()
            }
            cell.configure(description: transaction[indexPath.row].name,
                            date: transaction[indexPath.row].date.shortDate,
                            amount: "\(transaction[indexPath.row].amount)",
                            initial: transaction[indexPath.row].initial,
                            icon: nil,
                            type: transaction[indexPath.row].type)
            return cell
            
        }
    }
}

extension ContactInformationDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90
        default:
            return 72
        }
    }
}
