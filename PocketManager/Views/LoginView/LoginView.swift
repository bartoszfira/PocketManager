//
//  LoginView.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit

class LoginView: UIView, NibLoadable {
    var contentView: UIView?
    
    var loginCompletion: (() -> Void)?
    var registerCompletion: (() -> Void)?
    var passwordCompletion: (() -> Void)?
    
    @IBOutlet weak var loginView: BlankView!
    @IBOutlet weak var passwordView: BlankView!
    
    @IBAction func passwordAction(_ sender: Any) {
        passwordCompletion?()
    }
    @IBAction func registerAction(_ sender: Any) {
        registerCompletion?()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        loginCompletion?()
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
        loginView.updateTitle(with: "Email")
        passwordView.updateTitle(with: "Password")
    }
}
