//
//  Nibable.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import UIKit

public protocol Nibable {
    static var nibName: String { get }
    static var nib: UINib { get }
    static var bundle: Bundle { get }
}

public extension Nibable {
    public static var nibName: String {
        return String(describing: self)
    }

    public static var nib: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    public static var bundle: Bundle {
        return Bundle.main
    }
}

public extension Nibable where Self: UIView {

    public static func viewFromNib() -> Self {
        guard let rootObject = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("The root object must be the \(String(describing: self)) class")
        }

        return rootObject
    }
}
