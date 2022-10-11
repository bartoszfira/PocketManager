//
//  SearchStoreDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import UIKit

class SearchStoreDataSource: NSObject, UITableViewDataSource {
    
    var store: [StoreDTO]? = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as?SimpleTableViewCell,
                let filteredStore = store else {
                return UITableViewCell()
            }
        cell.configure(name: filteredStore[indexPath.row].name,
                        initial: filteredStore[indexPath.row].titleInitial,
                        image: nil)
            return cell
    }
    
}
extension SearchStoreDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

