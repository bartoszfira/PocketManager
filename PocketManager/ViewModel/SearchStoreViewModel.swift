//
//  SearchStoreViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import Foundation

final class SearchStoreViewModel {
    
    weak var presenter: SearchStorePresenter?
    let storeService: StoreServiceProtocol
    
    var store: [StoreDTO] = []
    var searchText: String = ""
    
    init(presenter: SearchStorePresenter) {
        self.presenter = presenter
        storeService = StoreService()
    }
    func viewWillAppear() {
        fetchData()
    }
}

extension SearchStoreViewModel {
    
    func fetchData() {
        storeService.fetchStores { [weak self] store in
            self?.store = store ?? []
            self?.presenter?.reloadStoreData(stores: store)
        }
    }
    func filterContentForSearchText(with searchText: String? = nil) {
        self.searchText = searchText?.lowercased() ?? self.searchText
        var filtered: [StoreDTO] = []

        filtered = store.filter { store in
            store.name.lowercased().contains(self.searchText)
        }
        presenter?.reloadStoreData(stores: filtered)
    }
}
