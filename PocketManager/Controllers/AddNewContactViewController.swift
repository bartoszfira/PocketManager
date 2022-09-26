//
//  AddNewContactViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/07/2022.
//

import UIKit

class AddNewContactViewController: UIViewController {
    
    @IBOutlet weak var addNewContactView: AddNewContactView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        addNewContactView.completion = {
            if  self.getData().name != "" ||
                self.getData().surname != "" ||
                self.getData().mail != "" {
               
                self.createContact()
                
                
            } else {
                print("Brak danych")
            }
        }
    }

    func setupView() {
        super.view.backgroundColor = .appPrimary
        self.hideKeyboardWhenTappedAround()
        addNewContactView.layer.cornerRadius = 20
        addNewContactView.layer.borderWidth = 2
        addNewContactView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
    func getData() -> ContactDTO {
        var name = addNewContactView.nameView.dataTextField.text
        var surname = addNewContactView.surenameView.dataTextField.text
        var mail = addNewContactView.mailView.dataTextField.text
        
        name = name?.lowercased().firstUppercased
        surname = surname?.lowercased().firstUppercased
        mail = mail?.lowercased()
        
        return ContactDTO(userId: UUID().uuidString,
                          name: name,
                          surname: surname,
                          mail: mail)
    }
    

    func createContact() {
        let contact = getData()
        ContactService.shared.addNew(contact) {
            print(self.getData())
            self.clearField()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func clearField() {
        addNewContactView.nameView.dataTextField.text = ""
        addNewContactView.surenameView.dataTextField.text = ""
        addNewContactView.mailView.dataTextField.text = ""
    }

}
