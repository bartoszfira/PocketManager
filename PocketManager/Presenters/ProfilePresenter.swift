//
//  ProfilePresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import Foundation

protocol ProfilePresenter: AnyObject {
    func navigateToLogin()
    func updateView(with user: UserDTO?)
}
