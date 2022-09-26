//
//  RegisterView.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit

class RegisterView: UIView, NibLoadable {
    var contentView: UIView?
    
    var completion: (() -> Void)?

    
    @IBOutlet weak var nameView: BlankView!
    @IBOutlet weak var surnameView: BlankView!
    @IBOutlet weak var mailView: BlankView!
    @IBOutlet weak var passwordView: BlankView!
    
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
        nameView.updateTitle(with: "Name")
        surnameView.updateTitle(with: "Surname")
        mailView.updateTitle(with: "Email")
        passwordView.updateTitle(with: "Password")
    }
}
