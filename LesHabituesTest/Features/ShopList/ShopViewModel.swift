//
//  ShopViewModel.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import UIKit

struct ShopViewModel {
    private let shop: Shop

    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()


    lazy var logo: URL? = {
        return URL(string: shop.logo)
    }()

    lazy var name: String = {
        return shop.name.uppercased()
    }()

    lazy var address: String = {
        return "\(shop.address)\n\(shop.zipcode) \(shop.city)"
    }()

    lazy var maxOffer: String = {
        formatter.currencyCode = shop.currency
        guard let maxOffer = shop.maxoffer.double(locale: Locale.init(identifier: "en")),
            let amount = formatter.string(from: NSNumber(value: maxOffer)) else { return "" }

        let format = NSLocalizedString("shop_list_max_offer", comment: "")
        return String(format: format, locale: Locale.current, arguments: [amount])
    }()

    init(shop: Shop) {
        self.shop = shop
    }
}
