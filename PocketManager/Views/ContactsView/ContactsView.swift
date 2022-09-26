//
//  ContactsView.swift
//  PocketManager
//
//  Created by Bartek Fira on 24/06/2022.
//

import UIKit

class ContactsView: UIView, NibLoadable {
    var contentView: UIView?

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var imageStackView: UIView!
    @IBOutlet weak var icon0View: InitialView!
    @IBOutlet weak var icon1View: InitialView!
    @IBOutlet weak var icon2View: InitialView!
    @IBOutlet weak var icon3View: InitialView!
    @IBOutlet weak var icon4View: InitialView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        setup()
       
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }


    func setup() {
        headerView.titleLabel.text = "Send Again"
  
    }
    
    func configure(text0: String?, text1: String?, text2: String?, text3: String?, text4: String?) {
        icon0View.label.text = text0
        icon1View.label.text = text1
        icon2View.label.text = text2
        icon3View.label.text = text3
        icon4View.label.text = text4
    }
//    fuicon4Viewnc update(with images: [UIImage]) {
//        images.forEach { image in
//            let imageView = UIImageView(image: image)
//            imageStackView.addArrangedSubview(imageView)
//        }
//
//        for _ in imageStackView.arrangedSubviews.count...5 {
//            imageStackView.addArrangedSubview(UIView())
//        }
//    }
}
