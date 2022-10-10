//
//  AddNewContactViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 06/10/2022.
//

import Foundation

final class AddNewContactViewModel {
    weak var presenter: AddNewContactPresenter?
    let contactService: ContactServiceProtocol?
    var contact: ContactDTO?
    
    init(presenter: AddNewContactPresenter) {
        self.presenter = presenter
        contactService = ContactService()
    }
}

extension AddNewContactViewModel {
    func didSelectConfirm() {
        if  self.contact?.name != "" ||
            self.contact?.surname != "" ||
            self.contact?.mail != "" {
            
            createContact()
            
        } else {
            print("Brak danych")
        }
    }
    
    func getData(with name: String?, surname: String?, mail: String?){
        self.contact = ContactDTO(userId: UUID().uuidString,
                              name: name?.lowercased().firstUppercased,
                              surname: surname?.lowercased().firstUppercased,
                              mail: mail?.lowercased())
    }
    
    func createContact() {
        guard let contact = contact else { return }
        contactService?.addNew(contact, completion: { [weak self] in
            self?.presenter?.clearFields()
            self?.presenter?.navigateToContacts()
        })
    }
    
}
