//
//  LoginView.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit

class LoginView: UIView, NibLoadable {
    var contentView: UIView?

    @IBOutlet weak var loginView: BlankView!
    @IBOutlet weak var passwordView: BlankView!
    
    @IBOutlet weak var passwordResetButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

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
        loginView.updateTitle(with: "Email")
        passwordView.updateTitle(with: "Password")
    }
}
