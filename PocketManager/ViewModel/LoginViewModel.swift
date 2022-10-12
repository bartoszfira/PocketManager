//
//  LoginViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 26/09/2022.
//

import Foundation

final class LoginViewModel {
    let authService: AuthServiceProtocol
    var credencials = LoginCredentials()
    weak var presenter: LoginPresenter?
    
    init(presenter: LoginPresenter) {
        authService = AuthService()
        self.presenter = presenter
    }

    func viewDidLoad() {
        // TODO: --
//        authService.logIn(with: .init(username: "barfira321@gmail.com", password: "admin1"), { [weak self] result, error in
//            if error != nil { return }
//            self?.presenter?.navigateToDashboard()
//        })
    }
}

extension LoginViewModel {
    public func updateCredentials(with username: String?, and password: String?) {
        credencials.username = username ?? ""
        credencials.password = password ?? ""
    }
}

extension LoginViewModel {
    @objc func didSelectPasswordReset() {
        print("Did select password reset")
    }
    
    func didSelectLogin() {
        authService.logIn(with: credencials) { [weak self] result, error in
            if error != nil { return }

            self?.presenter?.navigateToDashboard()
            
        }
    }
    
    @objc func didSelectRegister() {
        presenter?.navigateToRegister()
    }
}
