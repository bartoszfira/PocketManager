//
//  ContactService.swift
//  PocketManager
//
//  Created by Bartek Fira on 15/07/2022.
//

import Firebase
import FirebaseFirestoreSwift

protocol ContactServiceProtocol {
    func delete(_ contact: ContactDTO, completion: ((Error?) -> Void)?)
    func addNew(_ contact: ContactDTO, completion: @escaping () -> Void)
    func fetchFriends(completion: @escaping (([ContactDTO]?) -> Void))
    func fetchFriend(id: String, completion: @escaping ((ContactDTO?) -> Void))
}

class ContactService: ContactServiceProtocol {
    static let shared = ContactService()
    
    func delete(_ contact: ContactDTO, completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let friend = contact.userId 
        Firestore.firestore().collection("users").document(uid).collection("friends").document(friend).delete() { error in
            completion?(error)
        }
            

    }
    
    func addNew(_ contact: ContactDTO, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        try? Firestore.firestore().collection("users").document(uid).collection("friends").document(contact.userId).setData(from: contact.self) { error in
            if error != nil { return }
            completion()
        }
    }

    func fetchFriends(completion: @escaping (([ContactDTO]?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).collection("friends").getDocuments { snapshot, error in
            if error != nil { return }

            let contacts = snapshot?.documents.compactMap({ doc -> ContactDTO? in
                return try? doc.data(as: ContactDTO.self)
            })

            completion(contacts)
        }
    }
    func fetchFriend(id: String, completion: @escaping ((ContactDTO?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).collection("friends").document(id).getDocument { document, error in
            if error != nil { return }
            let contact = try? document?.data(as: ContactDTO.self)
            completion(contact)
        }
    }
    
}
