//
//  AddNewRecordPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 29/09/2022.
//

import Foundation

protocol AddNewRecordPresenter: AnyObject {
    func navigateToDashboard()
    func navigateToTitleList(with transaction: DealType)
    func clearFild()
    func updateTitleTextField(with value: String)
}
