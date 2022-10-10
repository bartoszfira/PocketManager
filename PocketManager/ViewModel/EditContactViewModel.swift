//
//  EditContactViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 10/10/2022.
//

import Foundation

final class EditContactViewModel {
    weak var presenter: EditContactPresenter?
    
    init(presenter: EditContactPresenter) {
        self.presenter = presenter
    }
}
