//
//  LoginViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupActions()

        // TODO: --
//        AuthService.shared.logIn(withEmail: "barfira321@gmail.com",
//                                 password: "admin1") { [weak self] result, error in
//            if error != nil { return }
//            DispatchQueue.main.async {
//                self?.navigationController?.replaceWith(UITabBarController.instantiate(controllerId: "MainTabBarController"))
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func setupActions() {
        loginView.loginCompletion = { self.logIn() }
        loginView.registerCompletion = { self.displayRegister() }
    }
    
    func displayRegister() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            self.navigationController?.pushViewController(vc, animated: true)
       
    }
    

    func logIn() {
        guard let email = loginView.loginView.dataTextField.text,
              let password = loginView.passwordView.dataTextField.text else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error != nil { return }

            // success
            print(Auth.auth().currentUser)
            DispatchQueue.main.async {
                self?.navigationController?.replaceWith(UITabBarController.instantiate(controllerId: "MainTabBarController"))
            }
        }
    }

    
    
}
