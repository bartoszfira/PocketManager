//
//  DealType.swift
//  PocketManager
//
//  Created by Bartek Fira on 21/07/2022.
//

import UIKit

enum DealType {
    case store
    case contact

    var title: String {
        switch self {
        case .store:
            return "Stores"
        case .contact:
            return "Contacts"
        }
    }

    mutating func toggle() {
        switch self {
        case .store:
            self = .contact
        case .contact:
            self = .store
        }
    }
    
    var searchViewController: UIViewController {
        switch self{
        case .store:
            return SearchStoreViewController.instantiate(controllerId: "SearchStoreViewController")
        case .contact:
            return SearchContactViewController.instantiate(controllerId: "SearchContactViewController")
        }
    }
    
}
