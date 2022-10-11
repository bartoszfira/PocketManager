//
//  BlankWithControlView.swift
//  PocketManager
//
//  Created by Bartek Fira on 21/07/2022.
//

import UIKit

class BlankWithControlView: UIView, NibLoadable {
    var contentView: UIView?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        setupSegmentedControl()
    }
    
    func updateTitle(with text: String) {
        label.text = text
    }

    func updateSegmentedItems(item1: String, item2: String) {
        segmentedControl.setTitle(item1, forSegmentAt: 0)
        segmentedControl.setTitle(item2, forSegmentAt: 1)
    }

    func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
    }

}
