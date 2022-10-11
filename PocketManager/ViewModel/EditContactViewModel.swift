//
//  EditContactViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 10/10/2022.
//

import Foundation

final class EditContactViewModel {
    weak var presenter: EditContactPresenter?
    weak var delegate: ContactInformationDelegate?
    let contactService: ContactServiceProtocol?
    
    var contact: ContactDTO?
    
    init(presenter: EditContactPresenter) {
        self.presenter = presenter
        contactService = ContactService()
    }
    
    func viewDidLoad() {
        presenter?.updateFields(with: contact)
    }
}

extension EditContactViewModel {
    func getData(name: String?, surname: String?, mail: String?){
        self.contact = ContactDTO(userId: contact?.userId ?? "",
                                  name: name?.lowercased().firstUppercased,
                                  surname: surname?.lowercased().firstUppercased,
                                  mail: mail?.lowercased())
    }
 
    func didSelectConfirm() {
        guard let contact = contact else { return }
        contactService?.addNew(contact) { [weak self] in
            self?.delegate?.reloadData(contact: contact)
            self?.presenter?.navigateToContactInformation()
        }
    }
}
