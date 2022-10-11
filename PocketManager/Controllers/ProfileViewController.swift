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
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var viewModel: ProfileViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel(presenter: self)
        viewModel?.viewDidLoad()
        setupActions()
    }
    
    func setupActions() {
        let logoutAction = UIAction { [weak self] _ in
            self?.viewModel?.didSelectLogout()
        }
        logoutButton.addAction(logoutAction, for: .touchUpInside)
        
        let editAction = UIAction { [weak self] _ in
    
        }
        editButton.addAction(editAction, for: .touchUpInside)
    }
    
}
extension ProfileViewController: ProfilePresenter {
    
    func navigateToLogin() {
        self.navigationController?.replaceWith(LoginViewController.instantiate(controllerId: "LoginViewController"))
    }

    func updateView(with user: UserDTO?) {
        initialView.label.text = user?.initial
        personalsLabel.text = user?.fullName
        mailLabel.text = user?.mail
    }
}
