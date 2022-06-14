//
//  HeaderView.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

class HeaderView: UIView {
    
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildTitleLabel()
        layoutTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildTitleLabel() {
        self.titleLabel.text = "Transactions History"
        self.titleLabel.backgroundColor = .black
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }

    func layoutTitleLabel() {
        
//        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: )
    }
}


