//
//  ContactsViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import Foundation

final class ContactsViewModel {
    weak var presenter: ContactsPresenter?
    var contactService: ContactServiceProtocol
    var storeService: StoreServiceProtocol
  
    init(presenter: ContactsPresenter) {
        self.presenter = presenter
        
        contactService = ContactService()
        storeService = StoreService()
    }
    
    func viewWillApear() {
        fetchFriendData()
    }
}

extension ContactsViewModel {
    func fetchFriendData() {
        contactService.fetchFriends { [weak self] contacts in
            self?.presenter?.reloadTableData(with: contacts)
        }
    }
    
    func fetchStoreData() {
        storeService.fetchStores { [weak self] store in
            self?.presenter?.reloadTableData(with: store)
        }
    }
    
    func didSelect(_ dataSource: ContactsDataSource){
        dataSource.listType.toggle()
        (dataSource.listType == .contact) ? fetchFriendData() : fetchStoreData()
        presenter?.updateView()
    }
    
    func didSelectHeaderButton() {
        presenter?.navigateToAddNew()
    }
}

extension ContactsViewModel: ContactDataSourceDelegate {
    func didSelectCellButton(_ contact: ContactDTO) {
        presenter?.navigateToContactInformation(with: contact)
    }
}

