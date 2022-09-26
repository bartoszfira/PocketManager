//
//  ContactInformationViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 13/07/2022.
//

import UIKit

protocol ContactInformaitonDelegate: AnyObject {
    func reloadData()
}

class ContactInformationViewController: UIViewController {

    var contact: ContactDTO?
    var transaction: [TransactionDTO]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupTable()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
       
    }
    
    
    func setupTable() {
        
        tableView.register(ContactTableViewCell.getNib, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchTransactionData()
        
        let header = HeaderView()
        header.titleLabel.text = "Contact"
        header.ctaButton.setTitle("Delete", for: .normal)
        header.ctaButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        header.completion = { [weak self] in
            self?.deleteAction()
        }
    
        self.tableView.tableHeaderView = header
        self.tableView.tableHeaderView?.frame.size.height = 60
        
    }
    
    func deleteAction() {
        let alert = UIAlertController(title: "Delete contact", message: "Are you sure you want to delete the contact?", preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.removeContactClicked()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)

        alert.addAction(removeAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true)
    }

    func removeContactClicked() {
        guard let contact = contact else { return }
        ContactService.shared.delete(contact) { [weak self] error in
            guard let error = error else {
                self?.navigationController?.popViewController(animated: true)
                return
            }
            print(error.localizedDescription)
            
        }
    }

    func fetchTransactionData() {
        guard let id = contact?.userId else { return }
        TransactionService.shared.fetchTransactions(with: id) { [weak self] transactions in
            self?.transaction = transactions
            self?.tableView.reloadData()
        }
    }
    
    func displayEditContactVC(with contact: ContactDTO?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditContactViewController") as! EditContactViewController
        vc.delegate = self
        vc.contact = contact
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactInformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90
        default:
            return 72
        }
    }
}

extension ContactInformationViewController: UITableViewDataSource {
    
    
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
            cell.completion = {
                self.displayEditContactVC(with: contact)
            }
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell,
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
    
extension ContactInformationViewController: ContactInformaitonDelegate {
    func reloadData() {
        guard let contact = contact else { return }
        ContactService.shared.fetchFriend(id: contact.userId) { contact in
            self.contact = contact
            self.tableView.reloadData()
        }
    }
}
