//
//  TitleListDataSource.swift
//  PocketManager
//
//  Created by Bartek Fira on 28/09/2022.
//

import UIKit

protocol TitleListDataSourceDelegate: AnyObject {
    func didTapCell(_ sender: MyTapGesture)
}

class TitleListDataSource: NSObject, UITableViewDataSource {
    var models: [TitleListable]? = []
    weak var delegate: TitleListDataSourceDelegate?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell,
              let model = models else {
            return UITableViewCell()
        }
        
        let name = model[indexPath.row].title
        let initial = model[indexPath.row].titleInitial
        let image = model[indexPath.row].icon
        
        cell.configure(name: name, initial: initial, image: image)
        
        let tap = MyTapGesture(
            target: self,
            action: #selector(didTapCell)
        )

        tap.data = model[indexPath.row]
        cell.addGestureRecognizer(tap)

        return cell
    }

    @objc func didTapCell(sender: MyTapGesture) {
        delegate?.didTapCell(sender)
    }
}

extension TitleListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

