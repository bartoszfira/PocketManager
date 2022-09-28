//
//  UserService.swift
//  PocketManager
//
//  Created by Bartek Fira on 20/07/2022.
//

import Firebase
import FirebaseFirestoreSwift

protocol UserServiceProtocol {
    func fetchUser(completion: @escaping ((UserDTO?) -> Void))
    func setUser(_ user: UserDTO, completion: @escaping () -> Void)
}

class UserService: UserServiceProtocol {
    // TODO: Remove
    static let shared = UserService()

    func fetchUser(completion: @escaping ((UserDTO?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).getDocument { document, error in
            if error != nil { return }
            let user = try? document?.data(as: UserDTO.self)
            completion(user)
        }
    }
    
    func setUser(_ user: UserDTO, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        try? Firestore.firestore().collection("users").document(uid).setData(from: user.self) { error in
            if error != nil { return }
            completion()
        }
    }
}
