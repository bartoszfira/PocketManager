//
//  TransactionService.swift
//  PocketManager
//
//  Created by Bartek Fira on 19/07/2022.
//


import Firebase
import FirebaseFirestoreSwift

class TransactionService {
    static let shared = TransactionService()
    
    func addNew(_ transaction: TransactionDTO, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        try? Firestore.firestore().collection("users").document(uid).collection("transactions").document(transaction.transactionId).setData(from: transaction.self) { error in
            if error != nil { return }
            completion()
        }
    }
    
    func fetchTransactions(completion: @escaping (([TransactionDTO]?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).collection("transactions").getDocuments { snapshot, error in
            if error != nil { return }

            var transactions = snapshot?.documents.compactMap({ doc -> TransactionDTO? in
                return try? doc.data(as: TransactionDTO.self)
            })
            transactions?.sort(){$0.date >= $1.date}
            completion(transactions)
        }
    }

    func fetchTransactions(with userId: String, completion: @escaping (([TransactionDTO]?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).collection("transactions").getDocuments { snapshot, error in
            if error != nil { return }

            var transactions = snapshot?.documents.compactMap({ doc -> TransactionDTO? in
                return try? doc.data(as: TransactionDTO.self)
            })
            
            transactions = transactions?.filter({ $0.storeId == userId })
            completion(transactions)
        }
    }
}
