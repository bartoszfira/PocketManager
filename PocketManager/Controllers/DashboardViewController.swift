//
//  ViewController.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TransactionsTableViewCell.getNib, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        tableView.register(HeaderTableView.getNib, forCellReuseIdentifier: HeaderTableView.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        //Header tabeli z ...TableViewCell.swift lub HeaderView.swift
        //let header = HeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        self.tableView.tableHeaderView = HeaderTableView()
        self.tableView.tableHeaderView?.frame.size.height = 100
//        self.tableView.tableHeaderView?.backgroundColor = .black
    }
    
}
extension DashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath)
    }
    
}

extension DashboardViewController: UITableViewDelegate {
    // Detected a case where constraints ambiguously suggest a height of zero for a table view cell's content view. We're considering the collapse unintentional and using standard height instead. A MIAŁO PODANE 90 W XIB
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


