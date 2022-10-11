//
//  AddNewRecordViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 29/09/2022.
//

import Foundation

final class AddNewRecordViewModel {
    let transactionsService: TransactionServiceProtocol
    let userService: UserServiceProtocol

    var transactionType: DealType = .contact
    var transactionKind: TransactionKind = .income
    var customerData: TitleListable?
    var user: UserDTO?
    var transaction: TransactionDTO?
    weak var presenter: AddNewRecordPresenter?
    
    init(presenter: AddNewRecordPresenter) {
        self.presenter = presenter
        userService = UserService()
        transactionsService = TransactionService()
    }
    
    func viewDidLoad() {
        fetchUser()
    }
    
}

extension AddNewRecordViewModel {
    func updateViewInformation(date: Date, amount: Double?) {
    let model = TransactionDTO(
            transactionId:  UUID().uuidString,
            storeId: customerData?.dataId ?? "ERROR",
            name: customerData?.title ?? "",
            image: nil,
            date: date,
            type: transactionKind,
            amount: amount ?? 0,
            initial: customerData?.titleInitial
        )

        self.transaction = model
    }
    
    func fetchUser() {
        userService.fetchUser { [weak self] user in
            self?.user = user
        }
    }

    func updateBalance() {
        guard
            var user = user,
            let transaction = transaction
        else {
            print("UpdateBalance user is nil")
            return
        }
        
        switch transactionKind {
        case .income:
            user.balance! += transaction.amount
            user.income! += transaction.amount
        case .expenses:
            user.balance! -= transaction.amount
            user.expenses! += transaction.amount
        }

        userService.setUser(user) { [weak self] in
            self?.presenter?.navigateToDashboard()
        }
    }
}

extension AddNewRecordViewModel {
    func didSelectTitleTextField() {
        self.presenter?.navigateToTitleList(with: transactionType)
    }

    func didSelectTransaction() {
        guard let transaction = transaction else {
            print("Transaction in AddNewRecordVM is nil")
            return
        }
        transactionsService.addNew(
            transaction) { [weak self] in
            self?.presenter?.clearFild()
            self?.updateBalance()
            
            print("Udało sie")
        }
    }

    @objc func didSelectTransactionType() {
        transactionType.toggle()
    }

    @objc func didSelectTransactionKind() {
        transactionKind.toggle()
    }
}

extension AddNewRecordViewModel: RecordInformationDelegate {
    func setData(data: TitleListable) {
        presenter?.updateTitleTextField(with: data.title)
        customerData = data
    }
}
