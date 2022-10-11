//
//  ContactsPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import Foundation

protocol ContactsPresenter: AnyObject {
    func navigateToContactInformation(with contact: ContactDTO)
    func navigateToAddNew()
    func reloadTableData(with contact: [ContactDTO]?)
    func reloadTableData(with store: [StoreDTO]?)
    func updateView()
}
