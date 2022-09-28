//
//  ViewController.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {
    let transactionHeader = HeaderView()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var balanceView: BalanceView!
    @IBOutlet weak var contactsView: ContactsView!

    var viewModel: DashboardViewModel?
    var dataSource = DashboardDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = DashboardViewModel(presenter: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }

    func setupView() {
        setupTable()
        setupContact()
    }

    func setupTable() {
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)

        tableView.delegate = dataSource
        tableView.dataSource = dataSource

        tableView.tableHeaderView = transactionHeader
        tableView.tableHeaderView?.frame.size.height = 60
    }
    
    func setupActions() {
        transactionHeader.ctaButton.addTarget(
            viewModel,
            action: #selector(viewModel?.didSelectTransactions),
            for: .touchUpInside)
    }
    
    func setupContact() {
        contactsView.headerView.ctaButton.tintColor = .clear
        contactsView.configure(text0: "JS",
                               text1: "KS",
                               text2: "JN",
                               text3: "B",
                               text4: "NS")
    }
}

extension DashboardViewController: DashboardPresenter {
    func navigateToTransactions() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func setupView(with user: UserDTO?) {
        self.navigationItem.title = "Hello " + (user?.name ?? "")
        balanceView.configure(
            balance: user?.balance ?? 0,
            income: user?.income ?? 0,
            expenses: user?.expenses ?? 0)
    }

    func reloadTableView(with transactions: [TransactionDTO]?) {
        dataSource.transactions = transactions
        tableView.reloadData()
    }
}


