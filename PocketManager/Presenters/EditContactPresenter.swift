//
//  EditContactPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 10/10/2022.
//

import Foundation

protocol EditContactPresenter: AnyObject {
    func navigateToContactInformation()
//    func clearFields()
    func updateFields(with contact: ContactDTO?)
}
