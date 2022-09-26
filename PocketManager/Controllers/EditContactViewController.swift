//
//  EditContactViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 19/07/2022.
//

import UIKit


class EditContactViewController: UIViewController {
    
    var contact: ContactDTO?
    weak var delegate: ContactInformaitonDelegate?
 
    @IBOutlet weak var contactView: AddNewContactView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupField()
        
        contactView.completion = {
            guard let contact = self.contact else { return }
            
            if  self.getData().name != contact.name ||
                self.getData().surname != contact.surname ||
                self.getData().mail != contact.mail {
               
                self.createContact()
                self.delegate?.reloadData()
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Brak danych")
            }
        }
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
    
    func setupField() {
        contactView.nameView.dataTextField.text = contact?.name
        contactView.surenameView.dataTextField.text = contact?.surname
        contactView.mailView.dataTextField.text = contact?.mail
    }
    
    
    func getData() -> ContactDTO {
        var name = contactView.nameView.dataTextField.text
        var surname = contactView.surenameView.dataTextField.text
        var mail = contactView.mailView.dataTextField.text
        let userId = contact?.userId ?? ""

        name = name?.lowercased().firstUppercased
        surname = surname?.lowercased().firstUppercased
        mail = mail?.lowercased()
        
        return ContactDTO(userId: userId,
                          name: name,
                          surname: surname,
                          mail: mail)
    }
    

    func createContact() {
        let contact = getData()
        ContactService.shared.addNew(contact) {
            print(self.getData())
            self.clearField()
        }
    }
    
    
    func clearField() {
        contactView.nameView.dataTextField.text = ""
        contactView.surenameView.dataTextField.text = ""
        contactView.mailView.dataTextField.text = ""
    }
    

}

