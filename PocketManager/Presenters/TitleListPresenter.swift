//
//  TitleListPresenter.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/09/2022.
//

import Foundation

protocol TitleListPresenter: AnyObject {
    func close()
    func reloadTableView(with data: [TitleListable]?)
}
