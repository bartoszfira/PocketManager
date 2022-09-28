//
//  RegisterViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/09/2022.
//

import Foundation

final class RegisterViewModel {
    let authSercice: AuthServiceProtocol
    var registerCredeintials: RegistrationCredencial
    weak var presenter: RegisterPresenter?

    init(presenter: RegisterPresenter) {
        authSercice = AuthService()
        registerCredeintials = RegistrationCredencial()
        self.presenter = presenter
    }
}

extension RegisterViewModel {
    func updateCredentials(_ credentials: RegistrationCredencial) {
        registerCredeintials = credentials
    }
}

extension RegisterViewModel {
    func didSelectRegister() {
        authSercice.create(
            with: registerCredeintials) { [weak self] error in
            if let error = error {
                return
            }

            self?.presenter?.navigateToLogin()
            
        }
    }

}
