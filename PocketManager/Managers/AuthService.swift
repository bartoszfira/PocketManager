//
//  AuthService.swift
//  PocketManager
//
//  Created by Bartek Fira on 14/07/2022.
//

import Firebase

typealias AuthResult = ((AuthDataResult?, Error?) -> Void)

protocol AuthServiceProtocol {
    func logIn(with credencials: LoginCredentials, _ completion: AuthResult?)
    func create(with credencials: RegistrationCredencial, completion: @escaping ((Error?)-> Void))
}

class AuthService: AuthServiceProtocol {
    func logIn(with credencials: LoginCredentials, _ completion: AuthResult?) {
        Auth.auth().signIn(withEmail: credencials.username, password: credencials.password, completion: completion)
    }

    func create(with credencials: RegistrationCredencial, completion: @escaping ((Error?)-> Void)) {
        guard
            let email = credencials.email,
            let password = credencials.password
        else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: ~ Failed to create user ERROR - \(error.localizedDescription)")
                return
            }

            guard let uid = result?.user.uid else { return }

            let data = ["mail": email,
                        "userId": uid,
                        "name": credencials.name ?? "",
                        "surname": credencials.surname ?? "",
                        "balance": 0.0,
                        "expenses": 0.0,
                        "income": 0.0 ] as [String : Any]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
    }
}
