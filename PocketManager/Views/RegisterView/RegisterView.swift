//
//  RegisterView.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit

class RegisterView: UIView, NibLoadable {
    var contentView: UIView?

    @IBOutlet weak var nameView: BlankView!
    @IBOutlet weak var surnameView: BlankView!
    @IBOutlet weak var mailView: BlankView!
    @IBOutlet weak var passwordView: BlankView!
    @IBOutlet weak var ctaButton: UIButton!
    
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
        nameView.updateTitle(with: "Name")
        surnameView.updateTitle(with: "Surname")
        mailView.updateTitle(with: "Email")
        passwordView.updateTitle(with: "Password")
    }
}
