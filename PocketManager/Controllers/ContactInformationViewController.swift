//
//  ContactInformationViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 13/07/2022.
//

import UIKit

protocol ContactInformationDelegate: AnyObject {
    func reloadData()
}

class ContactInformationViewController: UIViewController {

    var viewModel: ContactInformationViewModel?
    var dataSource = ContactInformationDataSource()

    let header = HeaderView()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ContactInformationViewModel(presenter: self)
        setupActions()
        setupTable()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupActions(){
        let didSelectRemove = UIAction { [weak self] _ in
            self?.viewModel?.didSelectRemove(with: self?.dataSource.contact)
        }
        header.ctaButton.addAction(didSelectRemove, for: .touchUpInside)
    }

    func setupTable() {
        
        tableView.register(ContactTableViewCell.getNib, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        
        dataSource.delegate = viewModel
        
        viewModel?.fetchTransactionData(with: dataSource.contact)
        
        header.titleLabel.text = "Contact"
        header.ctaButton.setTitle("Delete", for: .normal)
        header.ctaButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
    
        self.tableView.tableHeaderView = header
        self.tableView.tableHeaderView?.frame.size.height = 60
        
    }
}

// do VM
extension ContactInformationViewController: ContactInformationDelegate {
    func reloadData() {
        guard let contact = dataSource.contact else { return }
        ContactService.shared.fetchFriend(id: contact.userId) { contact in
            self.tableView.reloadData()
        }
    }
}

extension ContactInformationViewController: ContactInformationPresenter {

    func reloadTransactionsData(with transactions: [TransactionDTO]?) {
        dataSource.transaction = transactions
        tableView.reloadData()
    }
    
    func navigateToContacts() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToEdit(with contact: ContactDTO?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditContactViewController") as! EditContactViewController
        vc.delegate = self
        vc.contact = contact
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func presentRemoveAlert(with contact: ContactDTO?) {
        let alert = UIAlertController(title: "Delete contact", message: "Are you sure you want to delete the contact?", preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.viewModel?.deleteAction(with: contact)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)

        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
