//
//  ContactTableViewCell.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/07/2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var completion: (() -> Void)?
    
    @IBOutlet var iconView: InitialView!
    @IBOutlet weak var personalsLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    @IBAction func ctaTapped(_ sender: Any) {
        completion?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(personals: String?, mail: String?, iconInitial: String) {
        self.personalsLabel.text = personals
        self.mailLabel.text = mail
        self.iconView.label.text = iconInitial
    }
    
}
