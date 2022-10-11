//
//  EditContactViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 19/07/2022.
//

import UIKit


class EditContactViewController: UIViewController {
    
    var viewModel: EditContactViewModel?
    
//    var contact: ContactDTO?
    
    @IBOutlet weak var contactView: AddNewContactView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel?.viewDidLoad()
        setupActions()
    }
    
    func setupActions() {
        let  buttonAction = UIAction{ [weak self] _ in
            self?.viewModel?.getData(name: self?.contactView.nameView.dataTextField.text,
                                     surname: self?.contactView.surenameView.dataTextField.text,
                                     mail: self?.contactView.mailView.dataTextField.text)
            self?.viewModel?.didSelectConfirm()
            
        }
        contactView.ctaButton.addAction(buttonAction, for: .touchUpInside)
    }
    
    func setupView() {
        super.view.backgroundColor = .appPrimary
        self.hideKeyboardWhenTappedAround()
        contactView.layer.cornerRadius = 20
        contactView.layer.borderWidth = 2
        contactView.layer.borderColor = UIColor.darkGray.cgColor
        contactView.ctaButton.setTitle("Save", for: .normal)
        contactView.ctaButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
    }
}

extension EditContactViewController: EditContactPresenter {
    func updateFields(with contact: ContactDTO?) {
        contactView.nameView.dataTextField.text = contact?.name
        contactView.surenameView.dataTextField.text = contact?.surname
        contactView.mailView.dataTextField.text = contact?.mail
    }
    
    func navigateToContactInformation() {
        self.navigationController?.popViewController(animated: true)
    }
}

