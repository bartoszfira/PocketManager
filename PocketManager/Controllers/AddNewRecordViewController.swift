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
    @IBOutlet weak var addNewRecord: AddNewRecordView!

    var viewModel: AddNewRecordViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupView()

        viewModel = AddNewRecordViewModel(presenter: self)
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        addNewRecord.ctaButton.addTarget(
            self,
            action: #selector(didSelectConfirm),
            for: .touchUpInside)

        let txtFieldAction = UIAction { [weak self] _ in
            self?.viewModel?.didSelectTitleTextField()
        }
        addNewRecord.nameView.textField.addAction(txtFieldAction, for: .touchDown)

        let transactionTypeAction = UIAction { [weak self] _ in
            self?.viewModel?.didSelectTransactionType()
        }
        addNewRecord.nameView.segmentedControl.addAction(
            transactionTypeAction,
            for: .valueChanged
        )

        let transactionKindAction = UIAction { [weak self] _ in
            self?.viewModel?.didSelectTransactionKind()
        }
        addNewRecord.amountView.segmentedControl.addAction(
            transactionKindAction,
            for: .valueChanged
        )
    }

    @objc func didSelectConfirm() {
        viewModel?.updateViewInformation(date: addNewRecord.datePicker.date,
                                         amount: addNewRecord.amountView.textField.text?.toDouble)

        viewModel?.didSelectTransaction()
    }
    
    func setupView() {
        self.setupSegmentControl()
        self.setupActions()
    }
    
    func setupSegmentControl(){
        addNewRecord.nameView.updateSegmentedItems(
            item1: DealType.contact.title,
            item2: DealType.store.title
        )
        addNewRecord.amountView.updateSegmentedItems(
            item1: TransactionKind.income.rawValue,
            item2: TransactionKind.expenses.rawValue
        )
    }
}

extension AddNewRecordViewController: AddNewRecordPresenter {
    func navigateToDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToTitleList(with transaction: DealType) {
        guard let viewModel = viewModel else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TitleListViewController") as! TitleListViewController
        let vm = TitleListViewModel(presenter: vc,
                                    transactionType: transaction,
                                    recordDelegate: viewModel)

        vc.viewModel = vm
        self.present(vc, animated: true, completion: nil)
    }
    
    func clearFild() {
        addNewRecord.nameView.textField.text = ""
        addNewRecord.amountView.textField.text = ""
    }

    func updateTitleTextField(with value: String) {
        addNewRecord.nameView.textField.text = value
    }

}
