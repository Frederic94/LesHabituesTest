//
//  Fonts.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import UIKit

enum FontFamily {
    enum Lato {
        static let regular = FontConvertible(name: "Lato-Regular", family: "Lato Regular", path: "Lato-Regular.ttf")
    }
}

struct FontConvertible {
    let name: String
    let family: String
    let path: String

    func font(size: CGFloat) -> UIFont! {
        return UIFont(font: self, size: size)
    }

    func register() {
        // swiftlint:disable:next conditional_returns_on_newline
        guard let url = url else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }

    fileprivate var url: URL? {
        let bundle = Bundle(for: BundleToken.self)
        return bundle.url(forResource: path, withExtension: nil)
    }
}

extension UIFont {
    convenience init!(font: FontConvertible, size: CGFloat) {
        if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
            font.register()
        }
        self.init(name: font.name, size: size)
    }
}

private final class BundleToken {}
