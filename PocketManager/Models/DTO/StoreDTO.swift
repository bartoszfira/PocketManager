//
//  StoreDTO.swift
//  PocketManager
//
//  Created by Bartek Fira on 21/07/2022.
//

import UIKit
import FirebaseFirestoreSwift

struct StoreDTO: Codable {
    @DocumentID var id: String?
    let storeId: String
    let name: String
    let image: String?
}

extension StoreDTO: TitleListable {
    var title: String {
        return name
    }
    var dataId: String {
        return storeId
    }

    var titleInitial: String? {
        return name.first?.description ?? ""
    }

    var icon: UIImage? {
        return nil
    }
}
