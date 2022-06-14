//
//  TransactionsViewCell.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {

    @IBOutlet var imageGroundView: UIView!
    @IBOutlet var imageImageView: UIImageView!
    @IBOutlet var descLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
