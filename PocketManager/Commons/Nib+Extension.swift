//
//  Nib+Extension.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//


import UIKit


public protocol NibLoadable: HasNib {

    var contentView: UIView? { get set }
}

extension NibLoadable where Self: UIView {
    
    func loadFromNib() {
        let viewsInNib = Self.nib.instantiate(withOwner: self, options: nil).compactMap { $0 as? UIView }

        for element in viewsInNib {
            setupLayout(for: element)
        }

        contentView = viewsInNib.first
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

