//
//  ProfileViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 15/07/2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var initialView: InitialView!
    @IBOutlet weak var personalsLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBAction func editTapped(_ sender: Any) {
    }
    
    @IBAction func logoutTapped(_ sender: Any) { logout() }
    
    var user: UserDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
  
    
    }
 
    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.navigationController?.replaceWith(LoginViewController.instantiate(controllerId: "LoginViewController"))
                print(Auth.auth().currentUser)
               
            }
        } catch let error {
            print(error)
        }
    }
    
    func setupView() {
        fetchUser()
    }
    
    func fetchUser() {
        UserService.shared.fetchUser() { [weak self] user in
            self?.user = user
            self?.setupLabel()

            print(user)
        }
    }
    
    func setupLabel() {
        guard let user = user else {
            print("Error, user is nil in setupLabel ")
            return
        }
        initialView.label.text = user.initial
        personalsLabel.text = user.fullName
        mailLabel.text = user.mail
    }

}
