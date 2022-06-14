//
//  UIViewNib+Extension.swift
//  PocketMenager
//
//  Created by Bartek Fira on 14/06/2022.
//


import UIKit

/**
 Describes Nib object for UIView subclass.
 
 Used for NibLoadable
*/
public protocol HasNib: UIView {
    /**
     It is name of Nib where is designed UIView subclass.

     Default implementation of `nibName` returns name based on view's name. You can override it if XIB filename is different.

     F. ex. `ExampleView` will return `ExampleView` as `nibName`
     */
    static var nibName: String { get }
    
    /**
     It is Nib object where is designed UIView subclass.

     Default implementation of `nib` returns object created from `nibName` provided in `HasNib` protocol.
     */
    static var nib: UINib { get }
}

public extension HasNib where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}

public extension HasNib where Self: UIView {
    
    /**
     Initialize view from XIB
     
     XIB file should contains just 1 subview in itself which is subclass of UIView.
     
     Set it's view subclass and leave File's Owner empty.
     
     Such module can't be use inside Storyboard or other XIB file.
     
     - returns: UIView subclass
     */
    static func loadFromNib() -> Self {
        let views = nib.instantiate(withOwner: nil, options: nil)
        
        guard let view = views.first as? Self else {
            fatalError("Could not instantiate nib: \(nib) cause it expected it's root view to be \(self) type")
        }

        return view
    }
}

