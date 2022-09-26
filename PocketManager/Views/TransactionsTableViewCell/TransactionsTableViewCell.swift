//
//  TransactionsViewCell.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {


    @IBOutlet weak var iconView: InitialView!
    @IBOutlet var descLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configure(description: String?, date: String?, amount: String?, initial: String?, icon: UIImage?, type: TransactionKind) {
        
    
        
        self.descLable.text = description
        self.dateLabel.text = date
        self.amountLabel.text = "\(type.typeChar) \(amount ?? "0") $"
        self.amountLabel.textColor = type.color
        self.iconView.label.text = initial
        self.iconView.imageView.image = icon
        
    }
}
