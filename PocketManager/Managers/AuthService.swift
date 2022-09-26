//
//  AuthService.swift
//  PocketManager
//
//  Created by Bartek Fira on 14/07/2022.
//

import Firebase

typealias AuthResult = ((AuthDataResult?, Error?) -> Void)

class AuthService {
    static let shared = AuthService()

    // logowanie
    public func logIn(withEmail mail: String, password: String, completion: AuthResult?) {
        Auth.auth().signIn(withEmail: mail, password: password, completion: completion)
    }

    // rejestracja
    public func create(name: String = "", surname: String = "", mail: String, password: String, completion: @escaping ((Error?)-> Void)) {
        Auth.auth().createUser(withEmail: mail, password: password) { result, error in
            if let error = error {
                print("DEBUG: ~ Failed to create user ERROR - \(error.localizedDescription)")
                return
            }

            guard let uid = result?.user.uid else { return }

            let data = ["mail": mail,
                        "userId": uid,
                        "name": name,
                        "surname": surname,
                        "balance": 0.0,
                        "expenses": 0.0,
                        "income": 0.0 ] as [String : Any]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
    }
}
