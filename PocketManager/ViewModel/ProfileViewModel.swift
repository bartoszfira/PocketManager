//
//  ProfileViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/10/2022.
//

import UIKit
import Firebase


final class ProfileViewModel {
    weak var presenter: ProfilePresenter?
    var userService: UserServiceProtocol
    
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        userService = UserService()
    }
    
    func viewDidLoad() {
        fetchUser()
    }
}

extension ProfileViewModel {
    func didSelectLogout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.presenter?.navigateToLogin()
            }
        } catch let error {
            print(error)
        }
    }
    
    func fetchUser() {
        userService.fetchUser() { [weak self] user in
            self?.presenter?.updateView(with: user)
        }
    }
}

