//
//  SimpleTableViewCell.swift
//  PocketManager
//
//  Created by Bartek Fira on 21/07/2022.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: InitialView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String, initial: String?, image: UIImage?) {
        self.label.text = name
        self.iconView.label.text = initial
        self.iconView.imageView.image = image
    }
    
}
