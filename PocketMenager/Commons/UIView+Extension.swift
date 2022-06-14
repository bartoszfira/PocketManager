//
//  UIView+Extension.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @discardableResult   // 1
    func fromNib<T : UIView>() -> T? {   // 2
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {    // 3
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)     // 4
        contentView.translatesAutoresizingMaskIntoConstraints = false   // 5
        contentView.setupLayout(for: self)   // 6
        return contentView   // 7
    }

    fileprivate func setupLayout(for view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let attributes: [NSLayoutConstraint.Attribute] = [.top, .trailing, .bottom, .leading]

        let constraints = attributes.map({ attr -> NSLayoutConstraint in
            return NSLayoutConstraint(item: view,
                                      attribute: attr,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: attr,
                                      multiplier: 1.0,
                                      constant: 0.0)
        })

        NSLayoutConstraint.activate(constraints)
    }
}
