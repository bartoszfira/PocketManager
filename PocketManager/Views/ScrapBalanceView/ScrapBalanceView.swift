//
//  ScrapBalanceView.swift
//  PocketManager
//
//  Created by Bartek Fira on 23/06/2022.
//

import UIKit

class ScrapBalanceView: UIView, NibLoadable {
    var contentView: UIView?
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var imageLeadingConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }


    func update(with viewModel: ViewModel) {
        amountLabel.text = viewModel.amount

        titleLabel.text = viewModel.type.title
        iconImageView.image = viewModel.type.image
        imageLeadingConstraint.isActive = viewModel.type.constraintActive

        if viewModel.type == .expenses {
            titleLabel.textAlignment = .right
            amountLabel.textAlignment = .right
        }

        layoutIfNeeded()
        
    }
}

extension ScrapBalanceView {
    struct ViewModel {
        let amount: String
        let type: TransactionKind
    }
}
