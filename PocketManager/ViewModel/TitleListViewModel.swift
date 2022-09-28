//
//  TitleListViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/09/2022.
//

import Foundation

final class TitleListViewModel {
    let storeService: StoreServiceProtocol
    let contactService: ContactServiceProtocol
    
    weak var presenter: TitleListPresenter?
    weak var recordDelegate: RecordInformationDelegate?
    
    let transactionType: DealType
    var data: [TitleListable]? = []
    var filteredData: [TitleListable]?
    
    init(presenter: TitleListPresenter,
         transactionType: DealType,
         recordDelegate: RecordInformationDelegate) {
        self.presenter = presenter
        self.transactionType = transactionType
        self.recordDelegate = recordDelegate

        storeService = StoreService()
        contactService = ContactService()
    }
}

extension TitleListViewModel {
    func viewDidLoad(){
        (transactionType == .contact) ? fetchFriendData() : fetchStoreData()
    }
    
    func filterContentForSearchText (searchText: String) {
        guard let data = data else {
            return
        }

        data.forEach { element in
            if element.title.lowercased().contains(searchText.lowercased()) {
                filteredData?.append(element)
            }
        }
    }

    func serchBarDidChange(with searchText: String) {
        if searchText == "" {
            filteredData = data
        } else {
            filteredData = []
            filterContentForSearchText(searchText: searchText)
        }

        presenter?.reloadTableView(with: filteredData)
    }
}

extension TitleListViewModel {
    func fetchFriendData(){
        contactService.fetchFriends { [weak self] contacts in
            self?.data = contacts
            self?.filteredData = self?.data
            self?.presenter?.reloadTableView(with: contacts)
        }
    }
    
    func fetchStoreData() {
        storeService.fetchStores { [weak self] store in
            self?.data = store
            self?.filteredData = self?.data
            self?.presenter?.reloadTableView(with: store)
        }
    }
}

extension TitleListViewModel: TitleListDataSourceDelegate {
    func didTapCell(_ sender: MyTapGesture) {
        guard
            let delegate = recordDelegate
        else {
            print("Error Delegat = nil")
            return
        }
        
        delegate.setData(data: sender.data!)
        presenter?.close()
    }
}
