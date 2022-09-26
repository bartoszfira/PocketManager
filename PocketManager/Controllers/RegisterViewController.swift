//
//  RegisterViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        registerView.completion = {
            if self.registerView.mailView.dataTextField.text != "" ||
                self.registerView.nameView.dataTextField.text != "" ||
                self.registerView.surnameView.dataTextField.text != "" ||
                self.registerView.passwordView.dataTextField.text != ""
            {
            self.register()
            }
        }
    }
    
    func register() {
        guard let mail = registerView.mailView.dataTextField.text,
              let password = registerView.passwordView.dataTextField.text,
              let name = registerView.nameView.dataTextField.text,
              let surname = registerView.surnameView.dataTextField.text else {
            return
        }
        
        AuthService.shared.create(name: name, surname: surname, mail: mail, password: password) { error in
            print("OK")
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
