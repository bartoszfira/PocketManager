//
//  SearchStorePresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import Foundation

protocol SearchStorePresenter: AnyObject {
    func reloadStoreData(stores: [StoreDTO]?)
}
