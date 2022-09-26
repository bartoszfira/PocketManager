//
//  AddNewRecord.swift
//  PocketManager
//
//  Created by Bartek Fira on 24/06/2022.
//

import UIKit

class AddNewRecordView: UIView, NibLoadable {
    var contentView: UIView?
    
    var completion: (() -> (Void))?
    var segmentComplition: (() -> (Void))?
    
    var datePicker = UIDatePicker()

    @IBOutlet weak var nameView: BlankWithControlView!
    @IBOutlet weak var amountView: BlankWithControlView!
    @IBOutlet weak var dateView: BlankView!
    @IBOutlet weak var invoiceView: InvoiceAddNewRecordView!

    
    @IBAction func ctaTapped(_ sender: Any) {
        completion?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        configure()
        createDatePicker()
        
    }
    
    func configure() {
        nameView.updateTitle(with: "NAME")
        amountView.updateTitle(with: "AMOUNT")
        dateView.updateTitle(with: "DATE")
        invoiceView.updateTitle(with: "INVOICE")
        
    }

    func createDatePicker() {
        datePicker.sizeToFit()
        datePicker.preferredDatePickerStyle = .compact
        dateView.dataTextField.addSubview(datePicker)
    }
}
