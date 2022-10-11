//
//  SearchContactViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import Foundation

final class SearchContactViewModel {
    weak var presenter: SearchContactPresenter?
    let contactService: ContactServiceProtocol
    
    var contacts: [ContactDTO] = []
    var searchText: String = ""
    
    init(presenter: SearchContactPresenter) {
        self.presenter = presenter
        contactService = ContactService()
    }
    func viewWillAppear() {
        fetchData()
    }
}

extension SearchContactViewModel {
    
    func fetchData() {
        contactService.fetchFriends { [weak self] contacts in
            self?.contacts = contacts ?? []
            self?.presenter?.reloadContactData(contacts: contacts)
        }
    }
    func filterContentForSearchText(with searchText: String? = nil) {
        self.searchText = searchText?.lowercased() ?? self.searchText
        var filtred: [ContactDTO] = []

        filtred = contacts.filter { contact in
            contact.fullName.lowercased().contains(self.searchText)
        }
        presenter?.reloadContactData(contacts: filtred)
    }
}
