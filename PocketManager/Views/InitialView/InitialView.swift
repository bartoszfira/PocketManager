//
//  InitialView.swift
//  PocketManager
//
//  Created by Bartek Fira on 04/07/2022.
//

import UIKit

class InitialView: UIView, NibLoadable {
    var contentView: UIView?
    let color = UIColor.random()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        self.backgroundColor = color.withAlphaComponent(0.4)
        label.textColor = color
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layerCircle()
    }
}
