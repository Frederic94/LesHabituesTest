//
//  UIStoryboardExtensions.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import UIKit

extension UIViewController {
    static var controllerName: String {
        return String(describing: self)
    }
}


extension UIStoryboard {

    func viewController<T>(type: T.Type) -> T where T: UIViewController {
        let identifier = type.controllerName
        guard let vc = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to instantiate viewController for identifier \(identifier)")
        }
        return vc
    }

    func initialViewController<T>() -> T where T: UIViewController {
        guard let vc = instantiateInitialViewController() as? T else {
            fatalError("Failed to instantiate initial view controller")
        }
        return vc
    }
}


extension UIStoryboard {

    enum Name: String {
        case shop = "Shop"
    }

    convenience init(name: UIStoryboard.Name, bundle: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: bundle)
    }

    @objc class var shop: UIStoryboard {
        return UIStoryboard(name: Name.shop, bundle: nil)
    }
}
