//
//  AddNewContact.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/07/2022.
//

import UIKit

class AddNewContactView: UIView, NibLoadable {
    var contentView: UIView?
    
    var completion : (() -> Void)?
    
    @IBOutlet weak var nameView: BlankView!
    @IBOutlet weak var surenameView: BlankView!
    @IBOutlet weak var mailView: BlankView!
    @IBOutlet weak var ctaButton: UIButton!
    
    
    @IBAction func ctaTapped(_ sender: Any) {
        completion?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        configure()
    }
    
    func configure() {
        nameView.updateTitle(with: "NAME")
        surenameView.updateTitle(with: "SURENAME")
        mailView.updateTitle(with: "EMAIL")
    }
}
