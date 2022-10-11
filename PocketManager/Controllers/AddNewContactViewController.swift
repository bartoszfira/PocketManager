//
//  AddNewContactViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/07/2022.
//

import UIKit

class AddNewContactViewController: UIViewController {
    
    @IBOutlet weak var addNewContactView: AddNewContactView!
    
    var viewModel: AddNewContactViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddNewContactViewModel(presenter: self)
        setupView()
        setupAction()
//        addNewContactView.completion = {
//            if  self.getData().name != "" ||
//                self.getData().surname != "" ||
//                self.getData().mail != "" {
//
//                self.createContact()
//
//
//            } else {
//                print("Brak danych")
//            }
//        }
    }
    func setupAction() {
        let ctaAction = UIAction{ [weak self] _ in
            self?.viewModel?.getData(with: self?.addNewContactView.nameView.dataTextField.text,
                                     surname: self?.addNewContactView.surenameView.dataTextField.text,
                                     mail: self?.addNewContactView.mailView.dataTextField.text)
            self?.viewModel?.didSelectConfirm()
        }
        self.addNewContactView.ctaButton.addAction(ctaAction, for: .touchUpInside)
    }

    func setupView() {
        super.view.backgroundColor = .appPrimary
        self.hideKeyboardWhenTappedAround()
        addNewContactView.layer.cornerRadius = 20
        addNewContactView.layer.borderWidth = 2
        addNewContactView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
//    func getData() -> ContactDTO {
//        var name = addNewContactView.nameView.dataTextField.text
//        var surname = addNewContactView.surenameView.dataTextField.text
//        var mail = addNewContactView.mailView.dataTextField.text
//
//        name = name?.lowercased().firstUppercased
//        surname = surname?.lowercased().firstUppercased
//        mail = mail?.lowercased()
//
//        return ContactDTO(userId: UUID().uuidString,
//                          name: name,
//                          surname: surname,
//                          mail: mail)
//    }
    

//    func createContact() {
//        let contact = getData()
//        ContactService.shared.addNew(contact) {
//            print(self.getData())
//            self.clearField()
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
    
    
//    func clearField() {
//        addNewContactView.nameView.dataTextField.text = ""
//        addNewContactView.surenameView.dataTextField.text = ""
//        addNewContactView.mailView.dataTextField.text = ""
//    }

}
extension AddNewContactViewController: AddNewContactPresenter {
    func clearFields() {
        addNewContactView.nameView.dataTextField.text = ""
        addNewContactView.surenameView.dataTextField.text = ""
        addNewContactView.mailView.dataTextField.text = ""
    }
    
    func navigateToContacts() {
        self.navigationController?.popViewController(animated: true)
    }
}
