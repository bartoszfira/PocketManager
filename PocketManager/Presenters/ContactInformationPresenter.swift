//
//  ContactInformationPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 06/10/2022.
//

import UIKit

protocol ContactInformationPresenter: AnyObject {
    func navigateToContacts()
    func navigateToEdit(with contact: ContactDTO?)
    func reloadTransactionsData(with transactions: [TransactionDTO]?)
    func presentRemoveAlert(with contact: ContactDTO?)
}
