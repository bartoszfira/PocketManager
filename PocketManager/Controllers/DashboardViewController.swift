//
//  ViewController.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var balanceView: BalanceView!
    @IBOutlet weak var contactsView: ContactsView!

    var user: UserDTO?
    var transactions: [TransactionDTO]? = []
    var fiveContactTransaction: [TransactionDTO]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTransaction()
        fetchUser()

    }

    func setupView() {
        setupTitle()
        setupTable()
        setupContact()
    }
    
    func setupBalance() {
        self.balanceView.configure(balance: user?.balance ?? 0, income: user?.income ?? 0 , expenses: user?.expenses ?? 0)
    }
    
    func setupTitle() {
        UserService.shared.fetchUser() { user in
            self.navigationItem.title = "Hello " + (user?.name ?? "")
        }
    }

    func setupTable() {
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        let header = HeaderView()
        header.completion = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }

        tableView.tableHeaderView = header
        tableView.tableHeaderView?.frame.size.height = 60
    }
    
    func setupContact() {
        contactsView.headerView.ctaButton.tintColor = .clear
        contactsView.configure(text0: "JS",
                               text1: "KS",
                               text2: "JN",
                               text3: "B",
                               text4: "NS")
    }
    
    func setupFiveContactTransaction() {
        fiveContactTransaction = transactions?.sorted(by: {$0.storeId != $1.storeId })
    }
  
    func fetchTransaction() {
        TransactionService.shared.fetchTransactions { [weak self] transactions in
            self?.transactions = transactions
            self?.tableView.reloadData()
        }
    }
    
    func fetchUser() {
        UserService.shared.fetchUser { [unowned self] user in
            self.user = user
            self.setupBalance()
        }
    }
    
}

extension DashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let transactionsNumber = transactions?.count ?? 0
        return transactionsNumber > 10 ? 10 : transactionsNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell,
              let transaction = transactions else {
            return UITableViewCell()
        }

        cell.configure(description: transaction[indexPath.row].name,
                       date: transaction[indexPath.row].date.shortDate,
                       amount: transaction[indexPath.row].amount.toString,
                       initial: transaction[indexPath.row].initial,
                       icon: nil,
                       type: transaction[indexPath.row].type)
       
        return cell

    }

}

extension DashboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}


