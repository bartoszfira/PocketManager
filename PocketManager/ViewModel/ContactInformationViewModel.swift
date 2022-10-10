//
//  ContactInformationViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 06/10/2022.
//

import UIKit

final class ContactInformationViewModel {
    weak var presenter: ContactInformationPresenter?
    var transactionService: TransactionServiceProtocol
    var contactService: ContactServiceProtocol
    
    init(presenter: ContactInformationPresenter) {
        self.presenter = presenter
        transactionService = TransactionService()
        contactService = ContactService()
    }
}

extension ContactInformationViewModel {
    
    func fetchTransactionData(with contact: ContactDTO?) {
        guard let id = contact?.userId else { return }
        transactionService.fetchTransactions(with: id) { [weak self] transactions in
            self?.presenter?.reloadTransactionsData(with: transactions)
        }
    }
    
    func didSelectRemove(with contact: ContactDTO?) {
        presenter?.presentRemoveAlert(with: contact)
    }
    
    func deleteAction(with contact: ContactDTO?) {
        guard let contact = contact else { return }
        contactService.delete(contact) { [weak self] error in
            guard let error = error else {
                self?.presenter?.navigateToContacts()
                return
            }
            print(error.localizedDescription)
            
        }
    }
    
   
}

extension ContactInformationViewModel: ContactInformationDataSourceDelegate {
    func didSelectEdit(with contact: ContactDTO?){
        presenter?.navigateToEdit(with: contact)
    }
}
