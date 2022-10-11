//
//  SearchContactPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 11/10/2022.
//

import Foundation

protocol SearchContactPresenter: AnyObject {
    func reloadContactData(contacts: [ContactDTO]?)
    func navigateToContactInformation(with contact: ContactDTO?)
}
