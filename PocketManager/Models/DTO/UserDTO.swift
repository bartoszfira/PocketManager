//
//  UserDTO.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/07/2022.
//
import UIKit
import FirebaseFirestoreSwift

struct UserDTO: Codable {
    @DocumentID var id: String?
    let userId: String
    let name: String?
    let surname: String?
    let mail: String?
    var balance: Double?
    var expenses: Double?
    var income: Double?
}

extension UserDTO {
    var fullName: String {
        guard let name = name,
              let surname = surname else {
            return ""
        }

        return name + " " + surname
    }

    var initial: String {
        let nameChar = name?.first?.description ?? ""
        let surnameChar = surname?.first?.description ?? ""
        return nameChar + surnameChar
    }
}
