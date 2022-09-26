//
//  AddNewRecordViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 27/06/2022.
//

import UIKit

protocol RecordInformationDelegate: AnyObject {
    func setData(data: TitleListable)
}

class AddNewRecordViewController: UIViewController {
    
    var transactionType: DealType = .contact
    var transactionKind: TransactionKind = .income
    var customerData: TitleListable?
    var user: UserDTO?
    
    @IBOutlet weak var addNewRecord: AddNewRecordView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clean()
    }

    func setupView() {
        self.hideKeyboardWhenTappedAround()
        self.setupNameAction()
        self.setupSegmentControl()
        self.addNewRecord.completion = {
            self.createTransaction()
            self.fetchUser()
        }
    }

    func setupNameAction() {
        let action = UIAction { _ in
            self.displayTitleListVC(with: self.transactionType)
        }
        addNewRecord.nameView.textField.addAction(action, for: .touchDown)

    }
    
    func setupSegmentControl(){
        addNewRecord.nameView.updateSegmentedItems(item1: DealType.contact.title, item2: DealType.store.title)
        addNewRecord.amountView.updateSegmentedItems(item1: TransactionKind.income.rawValue, item2: TransactionKind.expenses.rawValue)
        
        addNewRecord.nameView.completion = { self.transactionType.toggle() }
        addNewRecord.amountView.completion = {self.transactionKind.toggle()
            print(self.transactionKind.rawValue)
        }
    }
    
    func displayTitleListVC(with transaction: DealType) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TitleListViewController") as! TitleListViewController
        vc.transactionType = transaction
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)

    }
    
    func displayDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData() -> TransactionDTO {
        let storeId = customerData?.dataId ?? "ErrorId"
        let name = customerData?.title ?? "Errorname"
        let image = customerData?.icon
        let date = addNewRecord.datePicker.date
        let type = transactionKind
        let amount = addNewRecord.amountView.textField.text?.toDouble ?? 0
        let titleInitial = customerData?.titleInitial
       
        
        return TransactionDTO(transactionId: UUID().uuidString,
                              storeId: storeId,
                              name: name,
                              image: nil,
                              date: date,
                              type: type,
                              amount: amount,
                              initial: titleInitial)
    }
    
    func createTransaction() {
        let transaction = getData()
        TransactionService.shared.addNew(transaction) { [weak self] in
            print(self?.getData())
            self?.clearField()
            self?.updateBalance(with: transaction)
            self?.displayDashboard()
        }
    }
    
    func clearField() {
        addNewRecord.nameView.textField.text = ""
        addNewRecord.amountView.textField.text = ""
     
    }
    
    func updateBalance(with transaction: TransactionDTO) {
        guard var user = user else {
            print("UpdateBalance user is nil")
            return
        }
        switch self.transactionKind {
        case .income:
            user.balance! += transaction.amount
            user.income! += transaction.amount
        case .expenses:
            user.balance! -= transaction.amount
            user.expenses! += transaction.amount
        }

        UserService.shared.setUser(user){}
    }
    
    func fetchUser() {
        UserService.shared.fetchUser { [weak self] user in
            self?.user = user
        }
    }

    func clean() {
        print("Funkcja Clean")
    }
}

extension AddNewRecordViewController: RecordInformationDelegate {
    func setData(data: TitleListable) {
        addNewRecord.nameView.textField.text = data.title
        customerData = data
       print(customerData)
    }    
}
