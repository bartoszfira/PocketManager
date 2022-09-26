//
//  BalanceView.swift
//  PocketManager
//
//  Created by Bartek Fira on 17/06/2022.
//

import UIKit

class BalanceView: UIView, NibLoadable {
    var contentView: UIView?
    
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var actionsStackView: UIStackView!
    @IBOutlet weak var incomeView: ScrapBalanceView!
    @IBOutlet weak var expensesView: ScrapBalanceView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        setupView()
    }
    
    func setupView() {
        backgroundColor = .appPrimary
        layer.cornerRadius = 20
        
        balanceLabel.text = "Total Balance"
    }

    func configure(balance: Double, income: Double, expenses: Double) {
    
        
        amountLabel.text = "$ " + balance.toString
        incomeView.update(with: .init(
                            amount: "$ " + income.toString,
                            type: .income))

        expensesView.update(with: .init(
                                amount: "$ " + expenses.toString,
                                type: .expenses))
        
    }
}

//extension BalanceView {
//    struct ViewModel {
//        var incomeVM: ScrapBalanceView.ViewModel
//        var expensesVM: ScrapBalanceView.ViewModel
//    }
//}
