//
//  StoreService.swift
//  PocketManager
//
//  Created by Bartek Fira on 21/07/2022.
//

import Firebase
import FirebaseFirestoreSwift

class StoreService {
    
    static let shared = StoreService()
    
    func addNew(_ store: StoreDTO, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        try? Firestore.firestore().collection("users").document(uid).collection("stores").document(store.storeId).setData(from: store.self) { error in
            if error != nil { return }
            completion()
        }
    }
    func fetchStores(completion: @escaping (([StoreDTO]?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).collection("stores").getDocuments { snapshot, error in
            if error != nil { return }

            let stores = snapshot?.documents.compactMap({ doc -> StoreDTO? in
                return try? doc.data(as: StoreDTO.self)
            })

            completion(stores)
        }
    }
    func fetchStore(id: String, completion: @escaping ((StoreDTO?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).collection("stores").document(id).getDocument { document, error in
            if error != nil { return }
            let store = try? document?.data(as: StoreDTO.self)
            completion(store)
        }
    }
}
