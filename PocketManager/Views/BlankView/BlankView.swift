//
//  ScrapAddNewRecord.swift
//  PocketManager
//
//  Created by Bartek Fira on 24/06/2022.
//

import UIKit

class BlankView: UIView, NibLoadable {
    var contentView: UIView?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        
    }
    
    func updateTitle(with text: String) {
        titleLabel.text = text
    }
}
