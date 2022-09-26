//
//  HeaderTableView.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

class HeaderView: UIView, NibLoadable {
    var contentView: UIView?


    var completion: (() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    @IBAction func ctaTapped(_ sender: Any) {
        completion?()
    }

    init(completion: (() -> Void)?) {
        super.init(frame: .zero)
        self.completion = completion
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
}
