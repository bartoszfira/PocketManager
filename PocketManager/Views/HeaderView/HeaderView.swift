//
//  HeaderView.swift
//  PocketManager
//
//  Created by Bartek Fira on 17/06/2022.
//

import UIKit

class HeaderView: UIView, NibLoadable {
    var contentView: UIView?
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var balanceView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
        configure()
    }

    // dlaczego w required init config działa(w override nie)?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        configure()
    }
    
    func configure() {
        greetingLabel.text = "Hello,"
        nameLabel.text = "Bartek"
    }
}
