//
//  ContactDTO.swift
//  PocketManager
//
//  Created by Bartek Fira on 07/07/2022.
//

import UIKit
import FirebaseFirestoreSwift

struct ContactDTO: Codable {
    @DocumentID var id: String?
    let userId: String
    let name: String?
    let surname: String?
    let mail: String?
}

extension ContactDTO {
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

extension ContactDTO {
    var documentPath: String {
        let name = name ?? ""
        let surname = surname ?? ""

        return name + "." + surname
    }
}

extension ContactDTO: TitleListable {
    var title: String {
        return fullName
    }
    var dataId: String {
        return userId
    }

    var titleInitial: String? {
        return initial
    }

    var icon: UIImage? {
        return nil
    }
}

extension ContactDTO {
    static var mock: [ContactDTO] = []
}


